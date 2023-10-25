//SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

/// @notice Este contrato sigue el estándar para tokens fungibles ERC-20
/// @dev El comentario sigue el formato de lenguaje de 'Especificación natural' de Ethereum ('natspec')
/// Referencia: https://docs.soliditylang.org/en/v0.8.16/natspec-format.html
contract ERC20 {

    /// VARIABLES DE ESTADO
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;
    uint256 public maxSupply;
    uint256 public price;

    address owner;

    /// MAPPINGS DE ESTADO
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    /// EVENTOS
    /// @notice Emit cuando se transfieren tokens
    /// @dev En la creación de nuevos tokens, emitir con la dirección `_from` establecida en la dirección cero
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
   
    /// @notice Emitir en toda llamada exitosa al método `approve`
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

    /// @notice Emitir en toda llamada exitosa al método `burn`
    event Burn(address indexed _from, address indexed _commandedBy, uint256 _value);

    /**
     * @notice Inicializar el estado del contrato
     * @dev Revertir si `_name` está vacío. Mensaje: "Invalid _name"
     * @dev Revertir si `_symbol` no tiene 3 caracteres. Mensaje: "Invalid _symbol"
     * @param _name El nombre del token
     * @param _symbol El símbolo del token
     * @param _maxSupply El suministro máximo del token. Cero para emisión ilimitada
     */
    constructor(string memory _name, string memory _symbol, uint256 _maxSupply) payable {
        // require( bytes(_name).length > 0, "Invalid _name");
        // require( keccak256(bytes(_name)) != keccak256(bytes("")));
        require(bytes(_symbol).length == 3, "Invalid _symbol");
        name = _name;
        symbol = _symbol;
        maxSupply = _maxSupply;
        owner = msg.sender;
        price = 1;
    }

    /// FUNCIONES EXTERNAS

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
     * @notice Emite una nueva cantidad de tokens a cambio de ethers al precio `price` del contrato
     * @dev Emitir el evento `Transfer` con el par'ametro `_from` establecida en la dirección cero.
     * @dev Revertir si msg.value es cero. Mensaje: "Invalid ether amount"
     * @dev Revertir si `_recipient` es la dirección cero. Mensaje: "Invalid _recipient"
     * @dev Revertir si el suministro total superó el suministro máximo. Mensaje: "Total supply exceeds maximum supply"
     * @param _recipient Es la cuenta receptora de los nuevos tokens
     */
    function mint(address _recipient) external payable {
        require(msg.value != 0, "Invalid ether amount");
        require(_recipient != address(0), "Invalid _recipient");
        require(totalSupply+msg.value <= maxSupply, "Total supply exceeds maximum supply");
        uint256 newTokens = msg.value / price;
        totalSupply+=newTokens;
        balanceOf[_recipient]+=newTokens;
        emit Transfer(address(0), _recipient, newTokens);
    }

    /**
     * @notice Reembolsa ethers a la cuenta '_from' a cambio de quemar una cantidad de tokens de la cuenta '_from',
     * @dev con una paridad de 1 a 1
     * @dev En caso de 'exito emitir el evento `Burn`.
     * @dev Revertir si `_from` es la dirección cero. Mensaje: "Invalid _from"
     * @dev Revertir si `_value` es cero. Mensaje: "Invalid _value"
     * @dev Revertir si la cuenta `_from` no tiene tokens suficientes para quemar. Mensaje: "Insufficient balance"
     * @dev Revertir si el remitente no puede gastar el saldo de la cuenta `_from`. Mensaje: "Insufficent allowance"
     * @param _from Es la dirección de la cuenta desde la cual se quemarán los tokens
     * @param _value Es la cantidad de tokens que se quemarán
     */
    function burn(address _from, uint256 _value) external {
        require(_from != address(0), "Invalid _from");
        require(_value != 0, "Invalid _value");
        require(balanceOf[_from] >= _value, "Insufficient balance");
        require(_from == msg.sender || allowance[_from][msg.sender] >= _value, "Insufficent allowance");

        totalSupply-=_value;
        balanceOf[_from]-=_value;
        payable(_from).transfer(_value);
        
        emit Burn(_from, msg.sender, _value);
    }

    function setPrice(uint256 _value) external {
        require(msg.sender != owner, "Not the Owner");
        require(_value >= 0, "Invalid Value");
        
        price = _value;
    }
}