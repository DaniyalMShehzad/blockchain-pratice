// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;
import "@openzeppelin/contracts/access/Ownable.sol";

contract Twitter is Ownable {
    // address public owner;
    uint256 MAX_TWEET_LENGTH;
    struct Tweet {
        uint256 id;
        address auther;
        string content;
        uint256 timestamp;
        uint256 likes;
    }

    mapping(address => Tweet[]) public tweets;

    event tweetCreated(
        uint256 id,
        address auther,
        string content,
        uint256 timestamp
    );
    event tweetLiked(address liker, uint256 id, address auther, uint256 likes);

    event tweetUnLiked(
        address unliker,
        uint256 id,
        address auther,
        uint256 likes
    );

    constructor() Ownable(msg.sender) {
        MAX_TWEET_LENGTH = 280;
    }

    function changeTweetLength(uint256 _length) public onlyOwner {
        MAX_TWEET_LENGTH = _length;
    }

    function createTweet(string memory _tweet) public {
        // conditional
        // if tweet length <= then we are good, otherwise we revert
        // 1 bytes = one character
        require(bytes(_tweet).length <= MAX_TWEET_LENGTH, "Tweet is too long");
        Tweet memory newTweet = Tweet({
            id: tweets[msg.sender].length,
            auther: msg.sender,
            content: _tweet,
            timestamp: block.timestamp,
            likes: 0
        });

        tweets[msg.sender].push(newTweet);
        emit tweetCreated(
            newTweet.id,
            newTweet.auther,
            newTweet.content,
            newTweet.timestamp
        );
    }

    function likeTweet(address auther, uint256 _id) external {
        require(tweets[auther][_id].id == _id, "Tweet does not exist");
        tweets[auther][_id].likes++;
        emit tweetLiked(msg.sender, _id, auther, tweets[auther][_id].likes);
    }

    function unLikeTweet(address auther, uint256 _id) external {
        require(tweets[auther][_id].id == _id, "Tweet does not exist");
        require(tweets[auther][_id].likes > 0, "Tweet has no likes");

        tweets[auther][_id].likes--;
        emit tweetLiked(msg.sender, _id, auther, tweets[auther][_id].likes);
    }

    function getTweet(uint256 _i) public view returns (Tweet memory) {
        return tweets[msg.sender][_i];
    }

    function getAllTweet() public view returns (Tweet[] memory) {
        return tweets[msg.sender];
    }
}
