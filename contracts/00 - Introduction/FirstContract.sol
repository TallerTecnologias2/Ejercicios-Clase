//SPDX-License-Identifier:MIT
pragma solidity 0.8.9;

/**
 * @title   Smart Contract tite
 * @author  David Gimenez Gutierrez
 * @notice  High-level description of the content of the contract
 * @dev     Low-level specification for developers     
 * Comments specifications: https://docs.soliditylang.org/en/v0.8.12/natspec-format.html
 */
contract FirstContract {
    
    // One line comment
    /// One line comment with natspec specification
    
    /**
        Multiple 
        line
        comment
    */
    
    /**
        @notice Visibilities
        @param public: Internal and external calls
        @param external: Only external calls and only for functions.
        @param internal: Visible inside the hierarchical of contracts
        @param private: Only internal call inside the same contract
        @dev Default visibility for state variables: internal
        @dev Default visibility for functions: public
    */

    /**
        @notice Variable types
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
    /// @dev Can contain any valid UTF-8 sequence
    string public myUnicodeLiteral = unicode"Hello world 😃";

    /// @notice private variable
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
    /// @dev Like in C, the options are represented by subsequent unsigned integer values starting from 0
    /// @dev The maximum number of elements in an Enum is 256
    enum MyOwnType { 
        Left, 
        Right, 
        Up,
        Down 
    }

    /// @notice Using the enum
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

    /// @notice Using my complex type
    MyComplexType public complexType;
    
    /**
        @notice Constant
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
    
    // functions
    function myFirstFunction(uint x) public pure returns(uint){
        return x * 2;
    }
    
    function mySecondFunction(uint x) public pure returns(uint result){
        result = x * 2;
        return result;  // This can be skipped
    }
    
    function getPrivateVariable() public view returns(uint){
        return privateVariable;
    }

    function deposit() external payable {
        require(msg.value > 0, "Zero value");
    }

    /// @notice Allow value trasnfer to the contract
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