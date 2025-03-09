// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import { console } from "forge-std/console.sol";
import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";

contract BridgeBase is Ownable {
    constructor() Ownable(msg.sender) {

    }

    function withdraw() public {

    }
    function burn() public {

    }
    function depositEventOnOtherSide() public {

    }
}