// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {
    // Mapping for item prices
    mapping (string => uint256) public itemPrices;
    // Array to keep track of item names
    string[] private itemNames;

    // Event for minting tokens
    event TokensMinted(address indexed to, uint256 amount);
    // Event for redeeming items
    event ItemRedeemed(address indexed by, string itemName, uint256 itemPrice);
    // Event for burning tokens
    event TokensBurned(address indexed from, uint256 amount);

    // Constructor with initialization for ERC20 and Ownable
    constructor() ERC20("Degen", "DGN") Ownable(msg.sender) {
        // Setting item prices
        itemPrices["primer"] = 499;
        itemPrices["foundation"] = 550;
        itemPrices["cream blush"] = 350;
        itemPrices["lip oil"] = 285;
        itemPrices["eyebrow pencil"] = 100;
        
        // Adding item names to the array
        itemNames.push("primer");
        itemNames.push("foundation");
        itemNames.push("cream blush");
        itemNames.push("lip oil");
        itemNames.push("eyebrow pencil");
    }

    // Function to get all item names and their prices
    function getAllItems() public view returns (string[] memory, uint256[] memory) {
        uint256[] memory prices = new uint256[](itemNames.length);
        for (uint256 i = 0; i < itemNames.length; i++) {
            prices[i] = itemPrices[itemNames[i]];
        }
        return (itemNames, prices);
    }

    // Function to mint tokens to a specified address
    function mintTokens(address to, uint256 amount) external onlyOwner {
        require(to != address(0), "Invalid address");
        require(amount > 0, "Amount must be greater than zero");

        _mint(to, amount);
        emit TokensMinted(to, amount);
    }

    // Function to redeem an item
    function redeemItem(string memory itemName) external {
        uint256 itemPrice = itemPrices[itemName];
        require(itemPrice > 0, "Item not in the list");
        require(balanceOf(msg.sender) >= itemPrice, "Insufficient balance");

        _burn(msg.sender, itemPrice);
        emit ItemRedeemed(msg.sender, itemName, itemPrice);
    }

    // Function to burn tokens
    function burnTokens(uint256 amount) external {
        require(amount > 0, "Amount must be greater than zero");
        require(balanceOf(msg.sender) >= amount, "Insufficient balance");

        _burn(msg.sender, amount);
        emit TokensBurned(msg.sender, amount);
    }
}
