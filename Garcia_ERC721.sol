// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract SimpleMinContract is ERC721URIStorage, Ownable {
    uint256 public mintAmount = 0.05 ether;
    uint256 public totalSupply;
    uint256 public maxSupply;
    bool public isMintEnabled;
    mapping(address => uint256) public mintedWallets;

    constructor() ERC721("Sample Minting", "SAMPLEMINT") Ownable(msg.sender) {
        maxSupply = 2;
    }

    function toggleisMintEnabled() external onlyOwner {
        isMintEnabled = !isMintEnabled;
    }

    function setmaxsupply(uint maxSupply_) external onlyOwner {
        maxSupply = maxSupply_;
    }

    function mint() external payable  {
        require(isMintEnabled, "Minting not available");
        require(mintedWallets[msg.sender] < 1, "Exceeds max per wallet");
        require(msg.value == mintAmount, "Wrong Value");
        require(maxSupply > totalSupply, "Sold out");

        mintedWallets[msg.sender]++;
        totalSupply++;
        uint256 tokenId = totalSupply;
        _safeMint(msg.sender, tokenId);
    }
}