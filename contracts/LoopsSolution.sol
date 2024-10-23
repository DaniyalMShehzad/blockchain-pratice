// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Loops {
    struct Expanses {
        address user;
        string descripton;
        uint256 amount;
    }
    mapping(address => Expanses[]) public expanses;

    function createExpanse(string memory _descripton, uint256 _amount) public {
        Expanses memory newExpanse = Expanses({
            user: msg.sender,
            descripton: _descripton,
            amount: _amount
        });
        expanses[msg.sender].push(newExpanse);
    }

    function getExpanses() public view returns (Expanses[] memory) {
        return expanses[msg.sender];
    }
}
