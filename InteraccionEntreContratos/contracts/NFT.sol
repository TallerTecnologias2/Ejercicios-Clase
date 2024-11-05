// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
// import "hardhat/console.sol";
import "../interfaces/IERC721.sol";
import "../interfaces/ILockableNFT.sol";

contract NFT is IERC721, ILockableNFT {
}