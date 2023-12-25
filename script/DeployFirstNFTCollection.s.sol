// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {Helper} from "../script/Helper.s.sol";
import {FirstNFTCollection} from "../src/FirstNFTCollection.sol";

contract DeployFirstNFTCollection  is Script {

    function run() external returns(FirstNFTCollection _collection) {

        Helper helper = new Helper();
         string memory  name = helper.getItems()._name;
         string memory symbol = helper.getItems()._symbol;

         vm.startBroadcast();
         _collection = new FirstNFTCollection(name, symbol);
         vm.stopBroadcast();
    }

}