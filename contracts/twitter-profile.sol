// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Profile {
    struct userProfile {
        string username;
        string bio;
    }

    mapping(address => userProfile) public profiles;

    function createProfile(string memory _username, string memory _bio) public {
        profiles[msg.sender] = userProfile(_username, _bio);
    }

    function getProfile(address _user)
        public
        view
        returns (userProfile memory)
    {
        return profiles[_user];
    }
}
