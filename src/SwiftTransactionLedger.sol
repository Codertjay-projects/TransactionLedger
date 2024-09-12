// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    event Approval(address indexed owner, address indexed spender, uint value);
    event Transfer(address indexed from, address indexed to, uint value);

    function name() external view returns (string memory);

    function symbol() external view returns (string memory);

    function decimals() external view returns (uint8);

    function totalSupply() external view returns (uint);

    function balanceOf(address owner) external view returns (uint);

    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint value) external returns (bool);

    function transfer(address to, uint value) external returns (bool);

    function transferFrom(address from, address to, uint value) external returns (bool);
}

contract SwiftTransactionLedger {
    address internal owner;
    address internal token;

    struct FinFile {
        string name;
        string cid;
    }

    FinFile public finFile;

    error NOT_AUTHORIZED();
    error INVALID_ADDRESS();
    error INVALID_AMOUNT();

    modifier onlyOwner(){
        if (msg.sender != owner) {
            revert NOT_AUTHORIZED();
        }
        _;
    }

    constructor(address _token) {
        owner = msg.sender;
        token = _token;
    }

    function recordFinFile(string memory _name, string memory _cid) external onlyOwner {
        finFile.cid = _cid;
        finFile.name = _name;
    }

    function getFinFile() external view onlyOwner returns (string memory)  {
        return finFile.cid;
    }


    function withdrawERC20(uint256 _amount, address _recipient) external onlyOwner {
        require(_recipient != address(0), "Recipient Address is Zero");
        require(_amount > 0, "Recipient Address is Zero");

        IERC20(token).transfer(_recipient, _amount);
    }

    function batchTransfer(address[] calldata recipients, uint256[] calldata amounts) external onlyOwner{
        require(recipients.length == amounts.length, "Recipients and amounts length mismatch");

        for (uint256 i = 0; i < recipients.length; i++) {
            require(IERC20(token).transfer(recipients[i], amounts[i]), "Transfer failed");
        }
    }


    function withdrawEther(uint256 _amount) external onlyOwner {
        require(address(this).balance >= _amount, "Insufficient balance");
        payable(owner).transfer(_amount);
    }


    function changeOwner(address newOwner) external onlyOwner {
        if (newOwner == address(0)) {
            revert INVALID_ADDRESS();
        }
        owner = newOwner;
    }

    function updateToken(address _token) external onlyOwner {
        require(_token != address(0), "Invalid address");
        token= _token;
    }

    receive() external payable {}

}