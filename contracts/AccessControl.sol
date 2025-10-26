// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/**
 * @title AccessControl
 * @dev Manages decentralized access control for off-chain data (e.g., IPFS CIDs).
 * Deploys on the BlockDAG EVM-compatible network.
 */
contract AccessControl {
    // Structure to hold metadata for a secured file.
    struct FileRecord {
        address owner;
        string cid;       // IPFS CID (ciphertext reference)
        bytes32 sha256;   // sha256 of ciphertext for integrity check
        bool revoked;
    }

    // Mapping of fileId (unique identifier) to its metadata.
    mapping(bytes32 => FileRecord) public files;
    // Mapping of fileId => address => boolean: tracks which users are allowed access.
    mapping(bytes32 => mapping(address => bool)) public allowed;

    // --- EVENTS for off-chain tracking ---
    event FileRegistered(bytes32 indexed fileId, address indexed owner, string cid, bytes32 sha256);
    event AccessGranted(bytes32 indexed fileId, address indexed grantee);
    event AccessRevoked(bytes32 indexed fileId, address indexed revoker); // Added revoker for traceability
    event AccessRemoved(bytes32 indexed fileId, address indexed grantee);

    // Modifier to restrict functions to the file owner.
    modifier onlyOwner(bytes32 fileId) {
        require(files[fileId].owner == msg.sender, "not owner");
        _;
    }

    /**
     * @dev Registers a new file on the access control system.
     * @param fileId Unique identifier for the file (bytes32).
     * @param cid The Content ID (e.g., IPFS hash) of the encrypted file.
     * @param sha256Val The SHA256 hash of the encrypted file content.
     * @param initialGrantees List of addresses granted access immediately upon registration.
     */
    function registerFile(bytes32 fileId, string calldata cid, bytes32 sha256Val, address[] calldata initialGrantees) external {
        // Prevent re-registration of the same fileId.
        require(files[fileId].owner == address(0), "file exists");
        
        // Store the new file record.
        files[fileId] = FileRecord({ owner: msg.sender, cid: cid, sha256: sha256Val, revoked: false });
        
        // Grant access to initial grantees and emit events.
        for (uint i = 0; i < initialGrantees.length; i++) {
            allowed[fileId][initialGrantees[i]] = true;
            emit AccessGranted(fileId, initialGrantees[i]);
        }
        
        emit FileRegistered(fileId, msg.sender, cid, sha256Val);
    }

    /**
     * @dev Grants access to a specific address. Only callable by the file owner.
     * @param fileId The ID of the file.
     * @param grantee The address to grant access to.
     */
    function grantAccess(bytes32 fileId, address grantee) external onlyOwner(fileId) {
        allowed[fileId][grantee] = true;
        emit AccessGranted(fileId, grantee);
    }

    /**
     * @dev Removes access from a specific address. Only callable by the file owner.
     * @param fileId The ID of the file.
     * @param grantee The address to remove access from.
     */
    function removeAccess(bytes32 fileId, address grantee) external onlyOwner(fileId) {
        allowed[fileId][grantee] = false;
        emit AccessRemoved(fileId, grantee);
    }

    /**
     * @dev Revokes access to the file permanently. The 'revoked' flag is set to true.
     * No one except the owner (who is always authorized) can access the file data after this.
     * @param fileId The ID of the file.
     */
    function revokeFile(bytes32 fileId) external onlyOwner(fileId) {
        files[fileId].revoked = true;
        emit AccessRevoked(fileId, msg.sender);
    }

    /**
     * @dev Checks if a user is authorized to access the file metadata/key.
     * @param fileId The ID of the file.
     * @param user The address to check authorization for.
     * @return bool True if authorized, false otherwise.
     */
    function isAuthorized(bytes32 fileId, address user) external view returns (bool) {
        // Owner is always authorized.
        if (files[fileId].owner == user) return true;
        // If revoked, non-owners are denied.
        if (files[fileId].revoked) return false;
        // Check the explicit allow-list.
        return allowed[fileId][user];
    }

    /**
     * @dev Returns the file metadata.
     * @param fileId The ID of the file.
     * @return owner The file owner.
     * @return cid The Content ID.
     * @return sha256Val The integrity hash.
     * @return revoked The revocation status.
     */
    function getFile(bytes32 fileId) external view returns (address owner, string memory cid, bytes32 sha256Val, bool revoked) {
        FileRecord storage f = files[fileId];
        return (f.owner, f.cid, f.sha256, f.revoked);
    }
}
