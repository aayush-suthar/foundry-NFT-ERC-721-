// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {DeployBasicNft} from "../../script/DeployBasicNft.s.sol";
import {BasicNft} from "../../src/BasicNft.sol";

contract BasicNftTest is Test{
    DeployBasicNft public deployer;
    BasicNft public basicNft;
    address public USER = makeAddr("user_aayush");
    string public constant PUG = "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function setUp() public {
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    function testNameIsCorrect() public {
        // Arrange
        string memory expectedName = "Dogie";
        string memory expectedSymbol = "DOG";

        // Act
        string memory name = basicNft.name();
        string memory symbol = basicNft.symbol();

        // Assert 
        assertEq(name , expectedName);
        assertEq(symbol , expectedSymbol);

        // we can't do name == expectedName as string are array of character and we can't array by ==. 
        // Convert them to hash and then compare.
        // string --> dynamic bytes --> hash (byte32) and compare

        assert(keccak256(abi.encodePacked(name)) == keccak256(abi.encodePacked(expectedName)));
        assert(keccak256(abi.encodePacked(symbol)) == keccak256(abi.encodePacked(expectedSymbol)));
    }

    function testCanMintAndHaveABalance() public {
        // Arrange
        vm.prank(USER);

        // Act
        basicNft.mintNft(PUG);

        // Assert
        assertEq(basicNft.balanceOf(USER) , 1);
        assertEq(basicNft.tokenURI(0) , PUG);
        /* OR */
        assert(keccak256(abi.encodePacked(basicNft.tokenURI(0))) == keccak256(abi.encodePacked(PUG)));
    }

}