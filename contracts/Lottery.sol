// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Lottery {
    address public manager;
    address[] public players;

    constructor() {
        manager = msg.sender;
    }

    function enterLottery() public payable {
        require(msg.value > 0.01 ether, "Minimum ETH not sent.");
        players.push(msg.sender);
    }

    function getPlayers() public view returns (address[] memory) {
        return players;
    }

    function random() private view returns (uint) {
        return uint(
            keccak256(abi.encodePacked(block.difficulty, block.timestamp, players))
        );
    }

    function pickWinner() public onlyManager {
        require(players.length > 0, "No players in the lottery.");
        uint index = random() % players.length;
        address winner = players[index];
        payable(winner).transfer(address(this).balance);
        players = new address ; // Reset the players array
    }

    modifier onlyManager() {
        require(msg.sender == manager, "Only manager can call this.");
        _;
    }
}

