// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract MultiPlayerGame {
    mapping(address => bool) public player;

    function joinGame() public virtual {
        player[msg.sender] = true;
    }
}

contract Game is MultiPlayerGame {
    string public gameName;
    uint256 public playerCount;

    constructor(string memory _gameName) {
        gameName = _gameName;
        playerCount = 0;
    }

    function startGame() public view {}

    function joinGame() public override {
        super.joinGame();
        playerCount++;
    }
}
