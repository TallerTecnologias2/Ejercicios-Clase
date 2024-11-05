// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
// import "hardhat/console.sol";
import "../interfaces/IMarketplace.sol";
import "./OwnableContract.sol";
import "../interfaces/IOwnersContract.sol";

contract Marketplace is IMarketplace, OwnableContract {
    constructor(address _ownersContract) OwnableContract(_ownersContract) {
    }
}