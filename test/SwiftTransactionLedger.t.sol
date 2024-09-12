// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {SwiftTransactionLedger} from "../src/SwiftTransactionLedger.sol";

contract SwiftTransactionLedgerTest is Test {
    SwiftTransactionLedger public swiftTransactionLedger;

    function setUp() public {
        swiftTransactionLedger = new SwiftTransactionLedger();
    }


    function testRecordAndGetFinFile() public {
        swiftTransactionLedger.recordFinFile("FIN2024", "cid_12345");

        string memory finFileCid = swiftTransactionLedger.getFinFile();

        assertEq(finFileCid, "cid_12345");
    }


}
