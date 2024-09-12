// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SwiftTransactionLedger {
    address internal owner;

    struct Transaction {
        string transactionReference;
        string dateCurrencyAmount;
        string orderingCustomer;
        string beneficiary;
    }

    struct FinFile {
        string name;
        string cid;
    }

    Transaction[] public transactions;
    FinFile public finFile;

    error NOT_AUTHORIZED();

    modifier onlyOwner(){
        if (msg.sender != owner) {
            revert NOT_AUTHORIZED();
        }
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function addTransaction(
        string memory _transactionReference,
        string memory _dateCurrencyAmount,
        string memory _orderingCustomer,
        string memory _beneficiary
    ) public onlyOwner {
        transactions.push(Transaction(
            _transactionReference,
            _dateCurrencyAmount,
            _orderingCustomer,
            _beneficiary
        ));
    }


    function getTransaction(uint _index) public view onlyOwner returns (
        string memory, string memory, string memory, string memory
    ) {
        Transaction memory transaction = transactions[_index];
        return (
            transaction.transactionReference,
            transaction.dateCurrencyAmount,
            transaction.orderingCustomer,
            transaction.beneficiary
        );
    }


    function recordFinFile(string memory _name, string memory _cid) public onlyOwner {
        finFile.cid = _cid;
        finFile.name = _name;
    }

    function getFinFile() public onlyOwner returns (string)  {
        return finFile.cid;
    }


}