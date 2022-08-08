// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Pbank{
    event Deposit(address caller, uint amount);
    event withdraw(address caller,uint amount);

    // address public owner;

    struct Users{
        address  owner;
        uint userBalance;
        bool hasWithdrawn;

    }
    mapping(address => Users) public user;

    function deposit(uint value) payable external {
        Users storage user1 = user[msg.sender];
        require( value == msg.value && value >= 1 ether, "invalid deposit");
        user1.owner = msg.sender;
        user1.userBalance = user1.userBalance + value;
        // user1.hasWithdrawn = false;
        emit Deposit(msg.sender, value);
        
    } 

    function Withdraw(uint _amount) external  {
        Users storage user1 = user[msg.sender];
        require(_amount == user1.userBalance, "invalid amount");
        require( msg.sender == user1.owner, "not the owner");
        user1.hasWithdrawn = true;
        user1.userBalance = user1.userBalance - _amount;
        payable(user1.owner).transfer(_amount);
        emit withdraw(user1.owner , _amount);
        selfdestruct(payable(user1.owner));
    }

}