// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {FirstNFTCollection} from "../src/FirstNFTCollection.sol";
import {console} from "forge-std/console.sol";

contract MintFirstNFT is Script {
    // Add it manually
    address private constant NFT_CONTRACT_ADD = address(0);
    string private constant TOKEN_URI = "";

    function mint(string memory _tokenURI, address _add) public {
        console.log(msg.sender);
        FirstNFTCollection collection = FirstNFTCollection(payable(_add));

        vm.startBroadcast();
        collection.minNft(_tokenURI);
        vm.stopBroadcast();
    }

    function run() external {
        mint(TOKEN_URI, NFT_CONTRACT_ADD);
    }
}

contract GetTokenURI is Script {
    // Add it manually
    address private constant NFT_CONTRACT_ADD = address(0);
    uint256 private constant TOKEN_ID = 0;

    function getTokenUri(uint256 _tokenId, address _add) public {
        FirstNFTCollection collection = FirstNFTCollection(payable(_add));

        vm.startBroadcast();
        string memory returnedUri = collection.tokenURI(_tokenId);
        vm.stopBroadcast();

        console.log(returnedUri);
    }

    function run() external {
        getTokenUri(TOKEN_ID, NFT_CONTRACT_ADD);
    }
}
