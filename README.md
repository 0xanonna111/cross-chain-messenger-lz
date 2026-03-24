# Cross-Chain Messenger (LayerZero)

This repository demonstrates how to implement cross-chain communication using LayerZero. It enables "Omnichain" functionality where a contract on a Source Chain can trigger logic on a Destination Chain.

## How it Works
1. **Source**: User calls `sendMessage` on Chain A.
2. **Endpoint**: The LayerZero Endpoint contract routes the message.
3. **Relayer/Oracle**: These off-chain entities move the message and validate the block header.
4. **Destination**: The `_nonblockingLzReceive` function is triggered on Chain B.

## Configuration
- Update the `lzEndpoint` address in the deployment script for your specific network (Mainnet, Goerli, Mumbai, etc.).
- Set the `destChainId` using LayerZero's specific chain ID mapping.
