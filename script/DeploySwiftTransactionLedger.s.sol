// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {SwiftTransactionLedger} from "../src/SwiftTransactionLedger.sol";

contract SwiftTransactionLedgerScript is Script {
    SwiftTransactionLedger public swiftTransactionLedger;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        swiftTransactionLedger = new SwiftTransactionLedger();

        vm.stopBroadcast();
    }
}