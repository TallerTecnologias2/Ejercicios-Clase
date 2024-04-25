//SPDX-License-Identifier:MIT
pragma solidity 0.8.9;

/**
 * @title   Título del Smart Contract
 * @author  David Gimenez Gutierrez
 * @notice  Descripción de alto nivel del contenido del contrato
 * @dev     Descripción de bajo nivel del contenido del contrato
 * Especificación de comentarios: https://docs.soliditylang.org/en/v0.8.12/natspec-format.html
 */
contract FirstContract {
    
    // Comentario de una línea
    /// Comentario de ua línea siguiendo la especificación natspec
    
    /**
        Comentario
        de 
        varias
        líneas
    */
    
    /**
        @notice Visibilidades
        @param public: Llamadas internas y externas
        @param external: Solo llamadas externas de funciones.
        @param internal: Visible desde dentro de la jerarquía de herencia de contrato
        @param private: Solo llamadas internas desde el mimsmo contrato
        @dev Visibilidad por defecto para variables de estado: internal
        @dev Visibilidad por defecto para funciones: public
    */

    /**
        @notice tipos de Variables
    */

    /// @dev default false
    bool public trueOrFalse = false;

    /// @dev default 0
    int256 public signedInteger = -1;
    uint256 public unsignedInteger = 1;
    
    /// @dev payable address
    address payable public payableAddress;
    /// @dev non payable address
    address public nonPayableAddress;
    
    /// @notice non payable to payable address
    address payable public nowIsPayable = payable(nonPayableAddress);
    
    /// @notice String literal
    string public myStringLiteral = "Hello world";

    /// @notice String Unicode literal
    /// @dev Puede contener cadenas UTF-8 válidas
    string public myUnicodeLiteral = unicode"Hello world 😃";

    /// @notice Variable privada
    uint256 private privateVariable;

    /**
        @notice Reference Types
        @dev Array, structs and mappings
    */

    // Arrays
    uint256[4] public arrayOf4Positions;
    uint256[] public arrayDynamicSize;
    uint[][4] public matrixOf4DynamicSizeArray;
    
    /**
        @notice Custom types
    */

    /// @notice enum type
    /// @dev Al igual que en C, las opciones están representadas por valores enteros sin signo posteriores a partir de 0
    /// @dev El número máximo de elementos en un Enum es 256
    enum MyOwnType { 
        Left, 
        Right, 
        Up,
        Down 
    }

    /// @notice usando el enum
    MyOwnType public direction;
    
    /**
        @notice Complex types
    */

    struct MyComplexType {
        uint index; 
        string name;
        address account;
        MyOwnType movment;
    }

    /// @notice Usnaod el complex type
    MyComplexType public complexType;
    
    /**
        @notice Constantes
    */

    MyOwnType constant public defaultChoice = MyOwnType.Up;
    uint256 immutable public immutableVariable;
    
    /**
        @notice Mapping types
        @dev mapping(KeyType => ValueType) VariableName
    */
    mapping (uint256 => MyComplexType) public people;
    mapping(address => uint256) public balance;
    mapping (address => mapping (address => uint256)) public matrix;
    
    
    /**
        @notice Events
    */
    event Received(address, uint);

    /**
        @notice Data location
        @dev Memory, storage and calldata (args)
    */
    
    // constructor
    constructor(bool _boolValue, uint _index, string memory _name) {
        nonPayableAddress = msg.sender;
        payableAddress = payable(msg.sender);

        trueOrFalse = _boolValue;

        MyComplexType memory newPerson = MyComplexType({
            index: _index,
            name: _name,
            account: msg.sender,
            movment: MyOwnType.Right
        });

        complexType = newPerson;
        newPerson.movment = MyOwnType.Down;
        
        unsignedInteger++;
        people[unsignedInteger] = newPerson;

        direction = MyOwnType.Right;
        immutableVariable = 1;
    }
    
    /**
        @notice Modifiers
        @dev pure, view, payable
    */
    
    // Funciones
    function myFirstFunction(uint x) public pure returns(uint){
        return x * 2;
    }
    
    function mySecondFunction(uint x) public pure returns(uint result){
        result = x * 2;
        return result;  // Esto se puede omitir
    }
    
    function getPrivateVariable() public view returns(uint){
        return privateVariable;
    }

    function deposit() external payable {
        require(msg.value > 0, "Zero value");
    }

    /// @notice Permitir transferencia de valor al contrato
    receive() external payable {
        emit Received(msg.sender, msg.value);
    }
    
    function WithdrawEthers() public {
        payableAddress.transfer(address(this).balance);
    }

    fallback() external {
        revert("404");
    }
    
}