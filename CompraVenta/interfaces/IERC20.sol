//SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

/// @notice Este contrato sigue el estándar para tokens fungibles ERC-20
/// @dev El comentario sigue el formato de lenguaje de 'Especificación natural' de Ethereum ('natspec')
/// Referencia: https://docs.soliditylang.org/en/v0.8.16/natspec-format.html
interface IERC20 {
    function name() external returns (string memory);
    function symbol() external returns (string memory);
    function decimals() external returns (uint8);
    function totalSupply() external returns (uint256);
    function maxSupply() external returns (uint256);
    function owner() external returns (address);
    function balanceOf(address account) external view returns (uint256);
    function allowance(address _owner, address _spender) external view returns (uint256);

    /**
     * @notice Transfiere la cantidad `_value` de tokens a la dirección `_to`.
     * @dev En caso de éxito debe disparar el evento `Transfer`.
     * @dev Revertir si `_to` es la dirección cero. Mensaje: "Invalid _to"
     * @dev Revertir si `_to` es la cuenta del remitente. Mensaje: "Invalid recipient, same as remittent"
     * @dev Revertir si `_value` es cero. Mensaje: "Invalid _value"
     * @dev Revertir si la cuenta remitente tiene saldo insuficiente. Mensaje: "Insufficient balance"
     * @param _to Es la dirección de la cuenta del destinatario
     * @param _value Es la cantidad de tokens a transferir.
     */
    function transfer(address _to, uint256 _value) external;

    /**
     * @notice Transfiere la cantidad `_value` de tokens desde la dirección `_from` a la dirección `_to`.
     * En caso de éxito debe disparar el evento `Transfer`.
     * @dev Revertir si `_from` es la dirección cero. Mensaje: "Invalid _from"
     * @dev Revertir si `_to` es la dirección cero. Mensaje: "Invalid _to"
     * @dev Revertir si `_to` es la misma cuenta que `_from`. Mensaje: "Invalid recipient, same as remittent"
     * @dev Revertir si `_value` es cero. Mensaje: "Invalid _value"
     * @dev Revertir si la cuenta `_from` tiene saldo insuficiente. Mensaje: "Insufficient balance"
     * @dev Revertir si `msg.sender` no es el propietario actual o una dirección aprobada con permiso para
     * gastar el saldo de la cuenta '_from'. Mensaje: "Insufficent allowance"
     * @param _from Es la dirección de la cuenta del remitente
     * @param _to Es la dirección de la cuenta del destinatario
     * @param _value Es la cantidad de tokens a transferir.
     */
    function transferFrom(address _from, address _to, uint256 _value) external;

    /**
     * @notice Permite que `_spender` realice retiros de la cuenta del remitente varias veces, hasta el monto de `_value`
     * En caso de éxito debe disparar el evento `Approval`.
     * @dev Si esta función se llama varias veces, sobrescribe la asignación actual con `_value`.
     * @dev Revertir si la asignación intenta establecerse en un nuevo valor superior a cero, para la misma cuenta `_spender`,
     * con una asignación vigente diferente a cero. Mensaje: "Invalid allowance amount. Set to zero first"
     * @dev Revertir si `_spender` es la dirección cero. Mensaje: "Invalid _spender"
     * @dev Revertir si `_value` excede el saldo del remitente. Mensaje: "Insufficient balance"
     * @param _spender Es la dirección de la cuenta del gastador
     * @param _value Es el monto de la asignación.
     */
    function approve(address _spender, uint256 _value) external;

    /**
     * @notice Emite una nueva cantidad de tokens para el Marketplace
     * @dev Emitir el evento `Transfer` con el parametro `_from` establecida en la dirección cero.
     * @dev Revertir si el msg.sender no es el owner del contrato
     * @dev Revertir si el suministro total superó el suministro máximo. Mensaje: "Total supply exceeds maximum supply"
     */
    function mint() external;

    /**
     * @notice Asigna el address de marketplace
     * @dev Revertir si el msg.sender no es el owner del contrato
     * @dev Revertir si el _marketplace es el address 0
     */
    function setMarketplaceAddress(address _marketplace) external;

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}