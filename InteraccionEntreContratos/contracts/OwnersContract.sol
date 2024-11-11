// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.16;

import "../interfaces/IOwnersContract.sol";

contract OwnersContract is IOwnersContract {
    uint256 ownersCount;
    mapping(address => bool) public owners;

    constructor() {
        owners[msg.sender] = true;
        ownersCount = 1;
    }

    /**
   * @notice Permite agregar owners al contrato
   * En caso de éxito debe disparar el evento `OwnerAdded`.
   * @dev Revertir si `msg.sender` no es un Owner. Mensaje "Not an Owner".
   * @dev Revertir si `newOwner` es la direccion 0. Mensaje: "Invalid address"
   * @dev Revertir si `newOwner` ya es owner del contrato. Mensaje: "Already an Owner"
   * @param newOwner Es la dirección de la nueva cuenta
   */
    function addOwner(address newOwner) external override {
        require(isOwner(msg.sender), "Not an Owner");
        require(newOwner != address(0), "Invalid address");
        require(!isOwner(newOwner), "Already an Owner");

        owners[newOwner] = true;
        ownersCount++;
        emit OwnerAdded(newOwner, msg.sender);
    }

    /**
   * @notice Permite remover owners al contrato
   * En caso de éxito debe disparar el evento `OwnerRemoved`.
   * @dev Revertir si `msg.sender` no es un Owner. Mensaje "Not an Owner".
   * @dev Revertir si `ownerToRemove` es la direccion 0. Mensaje: "Invalid address"
   * @dev Revertir si `ownerToRemove` no es owner del contrato. Mensaje: "ownerToRemove is not an Owner"
   * @dev Revertir si quedarían 0 owners en el contrato. Mensaje: "Must have at least 1 owner"
   * @param ownerToRemove Es la dirección de la cuenta a eliminar
   */
    function removeOwner(address ownerToRemove) external override {
        require(isOwner(msg.sender), "Not an Owner");
        require(ownerToRemove != address(0), "Invalid address");
        require(isOwner(ownerToRemove), "ownerToRemove is not an Owner");
        require(ownersCount > 1, "Must have at least 1 owner");

        owners[ownerToRemove] = false;
        ownersCount--;
        emit OwnerRemoved(ownerToRemove, msg.sender);
    }

    /**
   * @notice Permite consutlar si una dirección es owner del contrato
   * @param account Es la dirección de la cuenta a consultar
   */
    function isOwner(address account) external view override returns (bool) {
        return owners[account];
    }
}