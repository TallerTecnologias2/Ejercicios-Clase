// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.16;

import "../interfaces/IOwnersContract.sol";

abstract contract OwnableContract {
    IOwnersContract ownersContract;

    modifier isOwner(address possibleOwner) {
        require(ownersContract.isOwner(possibleOwner), "Not an owner");
        _;
    }

    constructor(address _ownersContract) {
        ownersContract = IOwnersContract(_ownersContract);
    }
}