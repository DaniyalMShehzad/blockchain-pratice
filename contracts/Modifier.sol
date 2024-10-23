// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

contract Modifier {
    address public owner;
    bool public paused;

    mapping(address => uint256) public balances;

    constructor() {
        owner = msg.sender;
        paused = false;
        balances[owner] = 1000;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner");
        _;
    }

    modifier notPaused() {
        require(!paused, "The contract is paused");
        _;
    }

    function pause() public onlyOwner {
        paused = true;
    }

    function unpause() public onlyOwner {
        paused = false;
    }

    function transfer(address to, uint256 amount) public notPaused {
        require(balances[msg.sender] >= amount, "Insufficient balance");

        balances[msg.sender] -= amount;
        balances[to] += amount;
    }
}
