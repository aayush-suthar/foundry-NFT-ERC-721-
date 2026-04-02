# 100% On-Chain Dynamic SVG NFT (ERC-721)

This repository contains a fully on-chain ERC-721 implementation utilizing dynamic SVG generation and base64 metadata encoding. It serves as a technical proving ground for advanced EVM mechanics, low-level call encoding, and Foundry-based state manipulation.

## ⚙️ Core Architecture

Unlike standard NFTs that rely on fragile off-chain storage (AWS/IPFS) for metadata, this implementation stores image data directly within the EVM state. 

* **Protocol:** ERC-721 (OpenZeppelin Implementation).
* **Metadata Generation:** On-chain, mathematically deterministic base64 encoding of raw SVG parameters.
* **State Updates:** Dynamic token URI modification via the `flipMood` function, updating the mathematical output without requiring an external oracle or off-chain server.

## 🔬 Technical Concepts Mapped

This repository demonstrates mastery over several low-level EVM primitives and framework edge cases:

* **EVM Memory Optimization:** Elimination of redundant type-casting loops (`bytes(string(abi.encodePacked...))`) during base64 payload construction to reduce gas overhead.
* **Low-Level Execution (`.call`):** Manual manipulation of transaction data via `abi.encodeWithSignature` and `abi.encodeWithSelector` to bypass high-level compiler safety nets and interact directly with contract bytecode.
* **Calldata Verification:** Inspecting and decoding raw hex calldata to verify transaction integrity against front-end interface spoofing.
* **Foundry State-Forking Diagnostics:** Successfully isolated and bypassed the `_safeMint` revert collision on Sepolia forks caused by deterministic `makeAddr` address generation.
* **State vs. Cache Discrepancy:** Navigating Web2 interface (MetaMask) local caching latency by utilizing direct `cast call` RPC queries to prove raw EVM state truth.

## 🛠 Toolchain

* **Framework:** Foundry (`forge`, `cast`, `anvil`, `chisel`)
* **Libraries:** `forge-std`, `openzeppelin-contracts`, `foundry-devops`
* **Workflow Automation:** `Makefile`

## 🚀 Usage & Execution Commands

**1. Compilation & Testing**
```bash
forge build
forge test -vvv
```

**2. Local Deployment (Anvil)**
Deploy the contract to a local Anvil node using the predefined Makefile target.
```bash
make deployMood
```

**3. Minting a Token**
Mint Token ID 0 to the default active deployment address.
```bash
make mintMood
```

**4. State Manipulation (Dynamic Update)**
Flip the metadata of the minted NFT. This command utilizes a dynamic CLI argument to target specific Token IDs.
```bash
make flipMood TOKEN_ID=0
```

**5. EVM State Verification**
Bypass GUI caching and query the blockchain directly to prove the metadata state change.
```bash
cast call [CONTRACT_ADDRESS] "tokenURI(uint256)(string)" 0 --rpc-url http://localhost:8545
```