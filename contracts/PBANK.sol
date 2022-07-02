// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PBANK{
    event deposit(uint amount);
    event withdraw(uint amount);

    address public owner;

    modifier onlyowner(){
        require(msg.sender == owner, "not the owner");
        _;
    }

    receive() external payable{
        emit deposit(msg.value);
    }

    function Withdraw() external onlyowner {
        emit withdraw(address(this).balance);
        selfdestruct(payable(msg.sender));
    }

}
