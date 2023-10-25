// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.16;

import "./OwnableContract.sol";

contract Store is OwnableContract {
    uint256 public price;
    mapping(address => uint256) public balance;

    constructor(address _ownersContract) OwnableContract(_ownersContract) {}

    /**
   * @notice Permiter agregar "balance" a la cuenta a relacion 1:1 con ethers
   */
    function buy() external payable {
        // TODO
    }

    /**
     * @notice Permite al owner cambiar el precio
     * @dev Revertir si `msg.sender` no es un Owner. Mensaje "Not an Owner".
     * @param _price Es el nuevo precio para comprar
     */
    function setPrice(uint256 _price) external {
        // TODO
    }
}