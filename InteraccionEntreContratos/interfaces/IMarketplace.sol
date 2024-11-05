// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

interface IMarketplace {
    function price() external returns (uint256);
    function ownersAddress() external returns (address);
    function nftAddress() external returns (address);

    /**
     * @notice Permite comprar un NFT.
     * @dev En caso de éxito debe disparar el evento `NFTBought`.
     * @dev Revertir si msg.value no alcanza para pagar por el NFT al precio actual. Mensaje: "Insufficient ETH"
     * @return Es el identificador del NFT comprado.
     */
    function buyNFT() external payable returns (uint256);

    /**
     * @notice Transfiere el NFT del msg.sender al contrato y devuelve el valor en ETH a 1/3 del precio al dueño del NFT.
     * @dev Debe revertir si el NFT está bloqueado. Mensaje: "NFT is locked"
     * @dev En caso de éxito debe disparar el evento `NFTSold`.
     * @dev Revertir si el contrato no tiene permisos para transferir el NFT. Mensaje: "No permissions"
     * @param _tokenId Es el identificador del NFT a vender.
     */
    function sellNFT(uint256 _tokenId) external;

    /**
     * @notice Bloquea un NFT para que no pueda ser vendido.
     * @dev Debe revertir si el NFT está bloqueado. Mensaje: "NFT is locked"
     * @dev Debe revertir si el msg.sender no es el dueño del NFT. Mensaje: "Not the owner"
     * @param _tokenId Es el identificador del NFT a bloquear.
     */
    function lockNFT(uint256 _tokenId) external;

    /**
     * @notice Desbloquea un NFT para que pueda ser vendido.
     * @dev Debe revertir si el NFT no está bloqueado. Mensaje: "NFT is not locked"
     * @dev Debe revertir si el msg.sender no es el dueño del NFT. Mensaje: "Not the owner"
     * @param _tokenId Es el identificador del NFT a desbloquear.
     */
    function unlockNFT(uint256 _tokenId) external;

    /**
     * @notice Fija el precio del NFT para compra.
     * @dev Revertir si `_price` es cero. Mensaje: "Invalid _price"
     * @dev Revertir si msg.sender no es owner del contrato. Mensaje: "Not an owner"
     * @param _price Es el nuevo precio del contrato
     */
    function setPrice(uint256 _price) external;

    /**
     * @notice Envia las comisiones obtenidas (la diferencia entre compra-venta) al owner
     * @dev Revertir si msg.sender no es owner del contrato. Mensaje: "Not an owner"
     */
    function collectFees() external;

    event NFTBought(address indexed buyer, uint256 amount);
    event NFTSold(address indexed sellet, uint256 amount);
}