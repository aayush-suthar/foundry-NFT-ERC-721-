// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract BasicNft is ERC721 {
    uint256 private s_tokenCounter;
    mapping(uint256 => string) private s_tokenIdToUri;

    // This is just a collection with name "Dogie" and symbol "DOG"
    // we will have different unique token under this collection
    constructor() ERC721("Dogie" , "DOG") {
        s_tokenCounter = 0;
    }

    function mintNft(string memory tokenUri) public {
        s_tokenIdToUri[s_tokenCounter] = tokenUri;
        /**
         * _safeMint is that the "safe" version checks if the 
         * receiver (msg.sender in your code) is a smart contract.
         * 
         * If the receiver is an EOA (Externally Owned Account): It behaves exactly like _mint.
         * 
         * If the receiver is a Smart Contract: _safeMint attempts to 
         * call a specific function on that contract: onERC721Received. 
         * If the recipient contract does not have this function, or if it doesn't 
         * return the exact correct "magic value" (the 4-byte selector of the function), the entire transaction reverts.
         * 
         */
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter++;
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory){
        return s_tokenIdToUri[tokenId]; 
    }

}