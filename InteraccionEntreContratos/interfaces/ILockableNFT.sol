//SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

/**
 * @notice Este contrato permite bloquear y desbloquear un NFT para que no puedan ser vendidos.
 */
interface ILockableNFT {
    struct LockState {
        bool isLocked;
        address lockedBy;
    }

    /**
     * @notice Devuelve el estado del NFT.
     */
    function lockInfo(uint256 _tokenId) external view returns (LockState memory);

    /**
     * @notice Fija el estado del NFT.
     * @dev Revertir si el msg.sender no es owner del contrato. Mensaje: "Not an owner"
     */
    function setIsLocked(uint256 _tokenId, bool _isLocked) external;

    /**
     * @notice Asigna el address de marketplace
     * @dev Revertir si el msg.sender no es el owner del contrato
     * @dev Revertir si el _marketplace es el address 0
     */
    function setMarketplaceAddress(address _marketplace) external;
}