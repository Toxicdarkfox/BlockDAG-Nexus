🌌 BlockDAG Quantum Nexus: Secure Data Transfer Protocol 

🏆 BlockDAG Hackathon Submission | Project Goal: True Data Sovereignty 

The Quantum Nexus is a fully functional, decentralized application (dApp) that solves the critical Web2 problem of centralized data ownership. It utilizes the high-speed, EVM-compatible BlockDAG network to provide immutable and granular access control for off-chain data (such as encrypted files stored on IPFS). 

✨ Core Features & Differentiators 

Icon 

Feature 

Description 

<i class="fa-solid fa-code-branch"></i> 

Immutable Authority 

Access permissions are managed by the AccessControl.sol smart contract on BlockDAG, guaranteeing that permissions can never be altered or censored by a third party. 

<i class="fa-solid fa-lock-open"></i> 

Granular Control 

File owners can register unique data entities and explicitly grantAccess or removeAccess to any individual wallet address with a single transaction. 

<i class="fa-solid fa-skull-crossbones"></i> 

Digital Kill-Switch 

The revokeFile function provides a permanent, non-reversable measure to instantly sever all non-owner access, ensuring data security in case of a breach or change in status. 

<i class="fa-solid fa-satellite-dish"></i> 

Real-Time Verification 

The frontend queries the chain via isAuthorized for instant, trustless access status updates, critical for Web2-like latency. 

<i class="fa-solid fa-display"></i> 

Futuristic UI/UX 

The "Quantum Nexus" interface offers a responsive, dark-mode command center, built to reflect a high-tech, digital-console aesthetic. 

🛠️ Technology Stack 

Category 

Component 

Rationale / Use 

Blockchain 

BlockDAG Network 

Selected for its scalability and speed (10,000+ TPS), allowing real-time permission updates and low transaction latency. 

Logic 

Solidity (AccessControl.sol) 

The foundation for the immutable access policy deployed directly to the EVM layer. 

Web3 

Ethers.js (v6) 

Robust library used for wallet connection (BrowserProvider), transaction signing, and contract interaction. 

Frontend 

React.js / TailwindCSS 

Provides the dynamic user experience and the modern, utility-first styling for the UI. 

Data Layer 

IPFS (Conceptual) 

Used as the assumed decentralized storage for the encrypted file payload, referenced by the CID. 

🔗 Deployment Details 

Component 

Status 

Address / Link 

Smart Contract 

Deployed 

0x7e27a64b4CA431D7C9aeE8aF98E203163b01380a 

Frontend 

Single File 

./frontend/index.html (Open directly in browser) 

🚀 Getting Started 

To launch the Quantum Nexus interface and interact with the deployed contract: 

Clone the Repository: 

git clone [https://github.com/Toxicdarkfox/BlockDAG-Nexus](https://github.com/Toxicdarkfox/BlockDAG-Nexus) 
cd BlockDAG-Nexus 
 

Open the Frontend: Navigate to the frontend folder and open index.html directly in your web browser. 

Connect Wallet: Click the "Connect Neuralink Interface" button and connect your MetaMask wallet configured for the BlockDAG network. 

Test Functions: Use the interface to register a new entity (use a unique ID like 0x33...), retrieve its status, authorize a secondary address, and finally, initiate the Termination Protocol. 

 

Contact 

My email :hamzamarke2020@gmail.com 

Phone number :09034342402 

Team Cybernetic Bots 
