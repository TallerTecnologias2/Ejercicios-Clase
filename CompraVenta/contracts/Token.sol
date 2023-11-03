// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
// import "hardhat/console.sol";
import "../interfaces/IERC20.sol";

contract Token is IERC20 {
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;
    uint256 public maxSupply;
    address public owner;
    address public marketplaceAddress;
    
    mapping (address => uint256) public balanceOf;
    mapping (address => mapping(address => uint256)) public allowance;

    constructor(string memory _name, string memory _symbol, uint256 _maxSupply) {
        require( bytes(_name).length > 0, "Invalid _name");
        require(bytes(_symbol).length == 3, "Invalid _symbol");
        require(_maxSupply > 0, "Invalid _maxSupply");
        name = _name;
        symbol = _symbol;
        maxSupply = _maxSupply;
        owner = msg.sender;
    }

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
    function transfer(address _to, uint256 _value) external {
        require(_to != address(0), "Invalid _to");
        require(_to != msg.sender, "Invalid recipient, same as remittent");
        require(_value > 0, "Invalid _value" );
        require( balanceOf[msg.sender] >= _value, "Insufficient balance");
        balanceOf[msg.sender]-=_value;
        balanceOf[_to]+=_value;
        emit Transfer(msg.sender, _to, _value);
    }

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
    function transferFrom(address _from, address _to, uint256 _value) external {
        require(_from != address(0), "Invalid _from");
        require(_to != address(0), "Invalid _to");
        require(_to != _from, "Invalid recipient, same as remittent");
        require(_value > 0, "Invalid _value" );
        require( balanceOf[_from] >= _value, "Insufficient balance");
        require(_from == msg.sender || allowance[_from][msg.sender] >= _value, "Insufficent allowance");
        balanceOf[_from]-=_value;
        balanceOf[_to]+=_value;
        emit Transfer(_from, _to, _value);
    }

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
    function approve(address _spender, uint256 _value) external {
        require(allowance[msg.sender][_spender] == 0 || _value == 0, "Invalid allowance amount. Set to zero first");
        require(_spender != address(0), "Invalid _spender");
        require(balanceOf[_spender] >= _value, "Insufficient balance");
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
    }

    /**
     * @notice Emite una nueva cantidad de tokens para el Marketplace
     * @dev Emitir el evento `Transfer` con el parametro `_from` establecida en la dirección cero.
     * @dev Revertir si el msg.sender no es el owner del contrato
     * @dev Revertir si el suministro total superó el suministro máximo. Mensaje: "Total supply exceeds maximum supply"
     */
    function mint(uint256 _amount) external {
        require(msg.sender == owner, "Not the owner");
        require(totalSupply + _amount <= maxSupply, "Total supply exceeds maximum supply");
        totalSupply += _amount;
        balanceOf[marketplaceAddress] += _amount;
        emit Transfer(address(0), marketplaceAddress, _amount);
    }

    /**
     * @notice Asigna el address de marketplace
     * @dev Revertir si el msg.sender no es el owner del contrato
     * @dev Revertir si el _marketplace es el address 0
     */
    function setMarketplaceAddress(address _marketplace) external {
        require(msg.sender == owner, "Not the owner");
        require(_marketplace != address(0), "Invalid _marketplace");
        marketplaceAddress = _marketplace;
    }
}
