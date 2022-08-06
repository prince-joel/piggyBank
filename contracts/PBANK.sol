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

    function deposit() payable external {
        Users storage user1 = user[msg.sender];
        // require( msg.sender == user1.owner, "not the owner");
        user1.owner = msg.sender;
        user1.userBalance = user1.userBalance + msg.value;
        user1.hasWithdrawn = false;
        emit Deposit(msg.sender, msg.value);
        
    } 

    function Withdraw(uint _amount) external  {
        Users storage user1 = user[msg.sender];
        require(_amount == user1.userBalance, "invalid amount");
        require(user1.hasWithdrawn != true, "cant withdraw again");
        require( msg.sender == user1.owner, "not the owner");
        user1.userBalance = user1.userBalance - _amount;
        user1.hasWithdrawn = true;
        payable(user1.owner).transfer(_amount);
        emit withdraw(user1.owner , _amount);
        selfdestruct(payable(user1.owner));
    }

}