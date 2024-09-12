// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {SwiftTransactionLedger} from "../src/SwiftTransactionLedger.sol";

contract DeploySwiftTransactionLedgerScript is Script {
    SwiftTransactionLedger public swiftTransactionLedger;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        swiftTransactionLedger = new SwiftTransactionLedger(0x54AafdbFa2f52a8E5871E14EE2b863ff9C695F19);

        vm.stopBroadcast();
    }


}

/*

forge  script  script/DeploySwiftTransactionLedger.s.sol:DeploySwiftTransactionLedgerScript  --rpc-url https://polygon-mainnet.g.alchemy.com/v2/H8ULeB__nMzZyhy_1SRZT08PE7A1Fhyj   --account defaultkey --sender 0x1b395389386f3f2a27866dad8f7ddbb31c392e66 -vvvv --broadcast --verify
*/