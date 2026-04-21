# Yield Farming Vault Core

This repository contains a professional-grade implementation of a Yield Farming Vault. It is designed to demonstrate how DeFi protocols automate the process of harvesting rewards and reinvesting them into the underlying pool.

### Core Architecture
* **Vault Contract:** Handles user deposits, withdrawals, and share minting (ERC4626-inspired).
* **Strategy Logic:** Interacts with external MasterChef or Liquidity Pool contracts to farm tokens.
* **Auto-Compounding:** A public or restricted function that sells reward tokens for more of the base asset to grow the total value locked (TVL).

### Security Features
* **Reentrancy Protection:** Guarding against common smart contract exploits.
* **Access Control:** Owner-only functions for emergency pauses and strategy updates.
