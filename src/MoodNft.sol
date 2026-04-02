// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MoodNft is ERC721 {
    // errors
    error MoodNft__CantFlipMoodIfNotOwner();

    uint256 private s_tokenCounter;
    string private s_sadSvgImageUri;
    string private s_happySvgImageUri;

    enum Mood{
        HAPPY,
        SAD
    }

    mapping(uint256 => Mood) private s_tokenIdToMood;

    // send the svg encoded
    constructor(string memory sadSvgImageUri , string memory happySvgImageUri) ERC721("Mood Nft" , "MN") {
        s_tokenCounter = 0;
        s_sadSvgImageUri = sadSvgImageUri;
        s_happySvgImageUri = happySvgImageUri;   
    }

    function mintNft() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter++;
        s_tokenIdToMood[s_tokenCounter] = Mood.HAPPY;
    }

    function flipMood(uint256 tokenId) public {
        // fetch the owner of the token
        address owner = ownerOf(tokenId);
        // Only want the owner of NFT to change the mood.
        _checkAuthorized(owner, msg.sender, tokenId);

        if(s_tokenIdToMood[tokenId] == Mood.HAPPY){
            s_tokenIdToMood[tokenId] = Mood.SAD;
        }else{
            s_tokenIdToMood[tokenId] = Mood.HAPPY;
        }
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,"; // since we are working with json
    }

    function getJson(string memory imageUri) public view returns(string memory) {
        return string(abi.encodePacked(_baseURI(),Base64.encode(bytes(abi.encodePacked('{"name": "', name() , '", "description": "An NFT that reflects the owners mood.", "attributes": [{"trait_type": "moodiness", "value": 100}], "image": "', imageUri, '"}')))));
    }

    function tokenURI(uint256 tokenId)  public view override returns (string memory){

        string memory imageUri;
        if(s_tokenIdToMood[tokenId] == Mood.HAPPY){
            imageUri = s_happySvgImageUri;
        }else{
            imageUri = s_sadSvgImageUri;
        }

        // string memory tokenMetadata = string.concat('{"name": "', name() , '", "description": "An NFT that reflects the owners mood.", "attributes": [{"trait_type": "moodiness", "value": 100}], "image": "', imageUri, '"}');
        return getJson(imageUri);
    }

}