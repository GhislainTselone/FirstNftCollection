// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {DeployFirstNFTCollection} from "../../script/DeployFirstNFTCollection.s.sol";
import {FirstNFTCollection} from "../../src/FirstNFTCollection.sol";
import {MintFirstNFT, GetTokenURI} from "../../script/Interactions.s.sol";

contract TestIntergration is Test {
    MintFirstNFT private s_mint;
    GetTokenURI private s_getUri;

    FirstNFTCollection private s_collection;
    address private s_sender = msg.sender;
    string private constant TOKEN_URI =
        "ipfs://QmdojBG7ruYZ6EuiECgxtzV3XGJ4a6kLZRA8GTtyLgV4BU";
    string private constant COLLECTION_NAME = "CUTE-DOGS";
    string private constant COLLECTION_SYMBOL = "DOGGIE";

    function setUp() external {
        DeployFirstNFTCollection deploy = new DeployFirstNFTCollection();
        s_collection = deploy.run();
        s_mint = new MintFirstNFT();
        s_getUri = new GetTokenURI();

        vm.deal(s_sender, 10e18);
    }

    function testMintNftAndRetrieveTokenuri() external {
        console.log(address(this));
        s_mint.mint(TOKEN_URI, address(s_collection));
        string memory uri = s_collection.tokenURI(0);
        assert(
            keccak256(abi.encodePacked(TOKEN_URI)) ==
                keccak256(abi.encodePacked(uri))
        );
    }
}
