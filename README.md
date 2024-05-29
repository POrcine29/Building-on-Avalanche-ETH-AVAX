# Degen Token 

The contract allows users to mint tokens, redeem items, and burn tokens. Minting involves calling the `mintTokens` function, redeeming involves calling the `redeemItem` function, and burning involves calling the `burnTokens` function.

## Description

A decentralized, community-driven cryptocurrency that has grown in popularity among traders and cryptocurrency aficionados is called Degen Token.

## Getting Started

### Executing program

Open your web browser and navigate to Remix IDE. 

https://remix.ethereum.org/

Click on the file icon in the File Explorer tab to create a new file and name it `MyDegenToken.sol`.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {
    mapping(string => uint256) public itemPrices;
    string[] private itemNames;

    constructor() ERC20("Degen", "DGN") Ownable(msg.sender) {
    _initializeItemPrices();
    }

    function _initializeItemPrices() private {
        itemPrices["Moisturizer"] = 499;
        itemPrices["Serum"] = 500;
        itemPrices["Toner"] = 350;
        itemPrices["Sunscreen"] = 285;
        itemPrices["Facial Cleanser"] = 100;

        itemNames.push("Moisturizer");
        itemNames.push("Serum");
        itemNames.push("Toner");
        itemNames.push("Sunscreen");
        itemNames.push("Facial Cleanser");
    }

    function getAllItems() external view returns (string[] memory, uint256[] memory) {
        uint256[] memory prices = new uint256[](itemNames.length);
        for (uint256 i = 0; i < itemNames.length; i++) {
            prices[i] = itemPrices[itemNames[i]];
        }
        return (itemNames, prices);
    }

    function mintTokens(address to, uint256 amount) external onlyOwner {
        require(to != address(0), "Invalid address");
        require(amount > 0, "Amount must be greater than zero");

        _mint(to, amount);
    }

    function redeemItem(string memory itemName) external {
        uint256 itemPrice = itemPrices[itemName];
        require(itemPrice > 0, "Item not available");
        require(balanceOf(msg.sender) >= itemPrice, "Insufficient balance");

        _burn(msg.sender, itemPrice);
    }

    function burnTokens(uint256 amount) external {
        require(amount > 0, "Amount must be greater than zero");
        require(balanceOf(msg.sender) >= amount, "Insufficient balance");

        _burn(msg.sender, amount);
    }
}   
```

Copy and Paste: Copy the contract code you provided and paste it into the `MyDegenToken.sol`.file in Remix.

Click on the "Compile MyDegenToken.sol" button in the compiler tab to compile the contract in the left side. You should see a green checkmark if it transaction is successful.

Deploy the Contract: Click on the "Deploy" button. This will deploy the contract to the selected environment.

Once the contract is deployed, you can transact the provided functions like Minting new tokens:, Transferring tokens,Redeeming tokens,Checking token balance and Burning tokens and call the total supply,symbol,owner,name,Get all items,and Decimals.

## Authors

Orcine,Poliana J.

8210778@ntc.edu.ph
