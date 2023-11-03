// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

interface IMarketplace {
    function price() external returns (uint256);
    function owner() external returns (address);
    function tokenAddress() external returns (address);

    /**
     * @notice Transfiere la cantidad `amount` de tokens a la dirección `msg.sender`.
     * @dev En caso de éxito debe disparar el evento `TokenBought`.
     * @dev Revertir si `_amount` es cero. Mensaje: "Invalid amount"
     * @dev Revertir si msg.value no alcanza para pagar por la cantidad `_amount` al precio actual. Mensaje: "Insufficient ETH"
     * @dev Revertir si el contrato no posee suficientes tokens. Mensaje: "Contract doesn't have enough tokens"
     * @param _amount Es la cantidad de tokens a comprar.
     */
    function buyToken(uint256 _amount) external payable;

    /**
     * @notice Transfiere la cantidad `amount` de tokens del msg.sender al contrato y devuelve el valor en ETH a 1/3 del precio.
     * @dev En caso de éxito debe disparar el evento `TokenSold`.
     * @dev Revertir si `_amount` es cero. Mensaje: "Invalid amount"
     * @dev Revertir si el no tiene suficiente allowance del token. Mensaje: "Insufficient allowance"
     * @param _amount Es la cantidad de tokens a comprar.
     */
    function sellToken(uint256 _amount) external;

    /**
     * @notice Fija el precio del token para compra.
     * @dev Revertir si `_price` es cero. Mensaje: "Invalid _price"
     * @dev Revertir si msg.sender no es el owner del contrato. Mensaje: "Not the owner"
     * @param _price Es el nuevo precio del contrato
     */
    function setPrice(uint256 _price) external;

    /**
     * @notice Envia las comisiones obtenidas (la diferencia entre compra venta) al owner
     * @dev Revertir si msg.sender no es el owner del contrato. Mensaje: "Not the owner"
     */
    function collectFees() external;

    event TokenBought(address indexed buyer, uint256 amount);
    event TokenSold(address indexed sellet, uint256 amount);
}