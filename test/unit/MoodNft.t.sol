// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {MoodNft} from "../../src/MoodNft.sol";

contract TestMoodNft is Test{

    MoodNft moodNft;
    address USER = makeAddr("user_aayush");
    string public constant HAPPY_SVG_URI = "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAxMDAgMTAwIiB3aWR0aD0iMTAwIiBoZWlnaHQ9IjEwMCI+CiAgPGNpcmNsZSBjeD0iNTAiIGN5PSI1MCIgcj0iNDUiIGZpbGw9IiNGRkQ3MDAiIHN0cm9rZT0iI0I4ODYwQiIgc3Ryb2tlLXdpZHRoPSIyIi8+CiAgCiAgPGNpcmNsZSBjeD0iMzUiIGN5PSI0MCIgcj0iNSIgZmlsbD0iIzMzMzMzMyIvPgogIAogIDxjaXJjbGUgY3g9IjY1IiBjeT0iNDAiIHI9IjUiIGZpbGw9IiMzMzMzMzMiLz4KICAKICA8cGF0aCBkPSJNIDMwIDYwIFEgNTAgODAgNzAgNjAiIGZpbGw9Im5vbmUiIHN0cm9rZT0iIzMzMzMzMyIgc3Ryb2tlLXdpZHRoPSI1IiBzdHJva2UtbGluZWNhcD0icm91bmQiLz4KPC9zdmc+Cg==";

    string public constant SAD_SVG_URI = "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAxMDAgMTAwIiB3aWR0aD0iMTAwIiBoZWlnaHQ9IjEwMCI+CiAgPGNpcmNsZSBjeD0iNTAiIGN5PSI1MCIgcj0iNDUiIGZpbGw9IiNGRkQ3MDAiIHN0cm9rZT0iI0I4ODYwQiIgc3Ryb2tlLXdpZHRoPSIyIi8+CiAgCiAgPGNpcmNsZSBjeD0iMzUiIGN5PSI0MCIgcj0iNSIgZmlsbD0iIzMzMzMzMyIvPgogIAogIDxjaXJjbGUgY3g9IjY1IiBjeT0iNDAiIHI9IjUiIGZpbGw9IiMzMzMzMzMiLz4KICAKICA8cGF0aCBkPSJNIDMwIDcwIFEgNTAgNTAgNzAgNzAiIGZpbGw9Im5vbmUiIHN0cm9rZT0iIzMzMzMzMyIgc3Ryb2tlLXdpZHRoPSI1IiBzdHJva2UtbGluZWNhcD0icm91bmQiLz4KPC9zdmc+Cg==";

    function setUp() public {
        moodNft = new MoodNft(SAD_SVG_URI, HAPPY_SVG_URI);
    }

    function testViewTokenURI() public {
        vm.prank(USER);
        moodNft.mintNft();
        console.log(moodNft.tokenURI(0));
    } 

    
}