// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {
    mapping(string => uint256) public itemPrices;
    string[] private itemNames;
    mapping(address => mapping(string => uint256)) public playerItems;

    event ItemRedeemed(address indexed player, string itemName);

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
        playerItems[msg.sender][itemName]++;
        emit ItemRedeemed(msg.sender, itemName);
    }

    function burnTokens(uint256 amount) external {
        require(amount > 0, "Amount must be greater than zero");
        require(balanceOf(msg.sender) >= amount, "Insufficient balance");

        _burn(msg.sender, amount);
    }

    function getPlayerItems(address player) external view returns (string[] memory, uint256[] memory) {
        uint256 itemCount = itemNames.length;
        string[] memory ownedItems = new string[](itemCount);
        uint256[] memory itemQuantities = new uint256[](itemCount);

        for (uint256 i = 0; i < itemCount; i++) {
            string memory itemName = itemNames[i];
            ownedItems[i] = itemName;
            itemQuantities[i] = playerItems[player][itemName];
        }

        return (ownedItems, itemQuantities);
    }
}
      

   
