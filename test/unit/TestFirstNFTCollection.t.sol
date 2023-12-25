// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {DeployFirstNFTCollection} from "../../script/DeployFirstNFTCollection.s.sol";
import {FirstNFTCollection} from "../../src/FirstNFTCollection.sol";

contract TestFirstNFTCollection is Test {
    FirstNFTCollection private s_collection;
    address private s_sender = msg.sender;
    string private constant TOKEN_URI =
        "ipfs://QmdojBG7ruYZ6EuiECgxtzV3XGJ4a6kLZRA8GTtyLgV4BU";
    string private constant COLLECTION_NAME = "CUTE-DOGS";
    string private constant COLLECTION_SYMBOL = "DOGGIE";

    function setUp() external {
        DeployFirstNFTCollection deploy = new DeployFirstNFTCollection();
        s_collection = deploy.run();
        vm.deal(s_sender, 10e18);
    }

    function testCheckNameAndSymbol() external view {
        string memory collectionName = s_collection.name();
        string memory collectionSymbol = s_collection.symbol();
        assert(
            keccak256(abi.encodePacked(collectionName)) ==
                keccak256(abi.encodePacked(COLLECTION_NAME))
        );
        assert(
            keccak256(abi.encodePacked(collectionSymbol)) ==
                keccak256(abi.encodePacked(COLLECTION_SYMBOL))
        );
    }

    function testMintNftAndTokenURI() external {
        vm.prank(msg.sender);
        s_collection.minNft(TOKEN_URI);
        uint256 counter = s_collection.getTokenCounter();
        string memory tokenUri = s_collection.tokenURI(0);
        assertEq(counter, 1);
        assert(
            keccak256(abi.encodePacked(tokenUri)) ==
                keccak256(abi.encodePacked(TOKEN_URI))
        );
    }
}
