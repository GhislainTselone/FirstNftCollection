// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";

contract Helper {
    Items private s_items;

    constructor() {
        uint256 activeNetwork = block.chainid;
        if (activeNetwork == 80001) {
            s_items = whenOnMumbai();
        } else {
            s_items = whenOther();
        }
    }

    struct Items {
        string _name;
        string _symbol;
    }

    function whenOnMumbai() internal pure returns (Items memory _items) {
        _items = Items("CUTE-DOGS", "DOGGIE");
    }

    function whenOther() internal pure returns (Items memory _items) {
        _items = Items("CUTE-DOGS", "DOGGIE");
    }

    function getItems() external view returns (Items memory) {
        return s_items;
    }
}
