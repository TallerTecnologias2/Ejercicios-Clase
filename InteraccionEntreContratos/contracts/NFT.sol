// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
// import "hardhat/console.sol";
import "../interfaces/IERC721.sol";
import "../interfaces/ILockableNFT.sol";

contract NFT is IERC721, ILockableNFT {
    /// STATE VARIABLES
    /// @notice Name of the collection
    string public name;
    /// @notice Symbol of the collection 
    string public symbol;
    /// @notice Current supply of the collection
    uint256 public totalSupply;

    address owner;
    address marketplaceAddress;

    /// STATE MAPPINGS
    /// @notice Cuenta los NFTS asignados a la direccion
    /// @dev owner address => NFT balance count
    mapping(address => uint256) public balanceOf;
    /// @notice Encuentra el dueño de un NFT
    /// @dev tokenId => address owner
    mapping(uint256 => address) public ownerOf;
    /// @notice Obtiene la direccion aprobada para un NFT
    /// @dev tokenId => approved address
    mapping(uint256 => address) public approved;
    /// @notice Revisa si una direccion es operador para otra direccion
    /// @dev owner address => operator address => approval status
    mapping(address => mapping(address => bool)) public operator;
    /// @notice Un identificador de recurso uniforme (URI - Uniform Resource Identifier).
    /// @dev Cumple el estandar RFC 3986. Puede apuntar a un JSON
    /// conforma al estandar "ERC721 Metadata Schema".
    /// @dev tokenId => URI of the asset
    mapping(uint256 => string) public tokenURI; 
    //function tokenURI(uint256 tokenId) returns (string) 

    /// EVENTS
    /// @notice Trigger when NFTs are transferred, created (`from` == 0) and destroyed
    ///  (`to` == 0). Exception: during contract creation.
    event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);

    /// @notice Trigger on any successful call to `approve` method. When approved address for
    /// an NFT is changed or reaffirmed
    event Approval(address indexed _owner, address indexed _approved, uint256 indexed _tokenId);

    /// @notice Trigger when an operator is enabled or disabled for an owner.
    event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);

    modifier isApproved( uint256 _tokenId) {
        address tokenOwner = ownerOf[_tokenId];
        require(tokenOwner == msg.sender || approved[_tokenId] == msg.sender || operator[tokenOwner][msg.sender] == true, "Not approved");
        _;
    }

    modifier isValidToken(uint256 _tokenId) {
        require(_tokenId != 0 && _tokenId <= totalSupply, "Invalid _tokenId");
        _;
    }

    /// @notice Initialize the state of the contract.
    /// @dev Throw if `_name` is empty
    /// @dev Throw if `_symbol` is not 3 characters long
    /// @param _name The name of the NFT collection
    /// @param _symbol The symbol of the NFT collection
    constructor(string memory _name, string memory _symbol) {
        require(bytes(_name).length != 0, "Invalid _name");
        require(bytes(_symbol).length == 3, "Invalid _symbol");

        name = _name;
        symbol = _symbol;
        owner = msg.sender;
    }

    /// EXTERNAL FUNCTIONS
    /**
     * @notice Asigna el address de marketplace
     * @dev Revertir si el msg.sender no es el owner del contrato
     * @dev Revertir si el _marketplace es el address 0
     */
    function setMarketplaceAddress(address _marketplace) external {
        require(msg.sender == owner, "Not the owner");
        marketplaceAddress = _marketplace;
    }

    /// @notice Transfiere la propiedad de un NFT desde la dirección del remitente a la dirección '_to'
    /// @dev Revertir si `_tokenId` no es un identificador de NFT válido con "Invalid_tokenId".
    /// @dev Revertir si `_to` es la dirección cero con "Invalid_address".
    /// @dev Revertir si el remitente no es el propietario actual con el mensaje "Not_the_owner".
    /// @dev Cuando la transferencia se completa, esta función verifica si `_to` es un contrato inteligente (tamaño de código > 0),
    /// si es así, llama a `onERC721Received` en `_to` y Revertir si el valor de retorno no es
    /// `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`, mensaje: "Invalid_contract".
    /// @dev Emitir el evento "Transfer" con los parámetros correspondientes.
    /// @param _to La dirección del nuevo propietario
    /// @param _tokenId El identificador de NFT a transferir
    function safeTransfer(address _to, uint256 _tokenId) external {
        safeTransferFrom(msg.sender, _to, _tokenId);
    }

    /// @notice Transfers the ownership of an NFT from one address to another address
    /// @dev Throws if `msg.sender` is not the current owner, an authorized operator, or the approved address for the NFT
    /// @dev Throw if `_from` is not the owner of the NFT
    /// @dev Throw if `_to` is zero address.
    /// @dev Throw if `_tokenId` is invalid, AKA zero or grather then totalSupply
    /// @dev Throws if `_to` is not capable of receiving NFTs. When transfer is complete, this function checks if `_to` is 
    /// a smart contract (code size > 0). If so, it calls `onERC721Received` on `_to` and throws if the return value is not
    ///  `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`.
    /// @dev Emit the `Transfer` event.
    /// @param _from The address of the current owner of the NFT
    /// @param _to The address of the new owner of the NFT
    /// @param _tokenId The token identifier of the NFT to transfer
    function safeTransferFrom(address _from, address _to, uint256 _tokenId) public {
        if (_to.code.length > 0) {
            bytes4 expectedResult = bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"));
            ERC721Receiver receiver = ERC721Receiver(_to);
            try receiver.onERC721Received(_from, _to, _tokenId, bytes("")) returns (bytes4 result) {
                require(expectedResult == result, "Invalid ERC721 Receiver");
            } catch {
                revert("Invalid ERC721 Receiver");
            }   
        }

        transferFrom(_from, _to, _tokenId);
    }

    /// @notice Transfers the ownership of an NFT from one address to another address
    /// @dev THE CALLER IS RESPONSIBLE TO CONFIRM THAT `_to` IS CAPABLE OF RECEIVING NFTS OR ELSE THEY MAY BE PERMANENTLY LOST
    /// @dev Throws if `msg.sender` is not the current owner, an authorized operator, or the approved address for the NFT
    /// @dev Throw if `_from` is not the owner of the NFT
    /// @dev Throw if `_to` is zero address.
    /// @dev Throw if `_tokenId` is invalid, AKA zero or grather then totalSupply
    /// @dev Emit the `Transfer` event.
    /// @param _from The address of the current owner of the NFT
    /// @param _to The address of the new owner of the NFT
    /// @param _tokenId The token identifier of the NFT to transfer
    function transferFrom(address _from, address _to, uint256 _tokenId) public isApproved(_tokenId) isValidToken(_tokenId) {
        address tokenOwner = ownerOf[_tokenId];
        require(tokenOwner == _from, "Invalid _from");
        require(address(0) != _to, "Invalid _to");

        balanceOf[_from] -= 1;
        balanceOf[_to] += 1;
        ownerOf[_tokenId] = _to;
        //approved[_tokenId] = address(0);
        delete approved[_tokenId];

        emit Transfer(_from, _to, _tokenId);
    }

    /// @notice Change or reaffirm the approved address for an NFT. An approved address can operate an NFT as
    /// if was the owner.
    /// @dev Set to zero address to indicates that there is no approved address
    /// @dev Throw if msg.sender is not the current owner, an authorized operator, or the approved address for the NFT
    /// @dev Throw if `_tokenId` is invalid, AKA zero or grather then totalSupply
    /// @dev Emit the `Approval` event.
    /// @param _approved The address of the new approved NFT controller
    /// @param _tokenId The token identifier to approve
    function approve(address _approved, uint256 _tokenId) external isApproved(_tokenId) isValidToken(_tokenId) {
        address tokenOwner = ownerOf[_tokenId];

        approved[_tokenId] = _approved;

        emit Approval(tokenOwner, _approved, _tokenId);
    }

    /// @notice Get the approved address for a single NFT
    /// @dev Throw if `_tokenId` is invalid, AKA zero or grather then totalSupply
    /// @param _tokenId The NFT to find the approved address for
    /// @return The approved address for this NFT, or the zero address if there is none
    function getApproved(uint256 _tokenId) external view isValidToken(_tokenId) returns (address){
        return approved[_tokenId];
    }

    /// @notice Enable or disable approval for a third party "operator" to manage all of `msg.sender`'s assets
    /// @dev The contract MUST allow multiple operators per owner
    /// @dev Throw if `_operator` is zero address
    /// @dev Emit the `ApprovalForAll` event.
    /// @param _operator The address to add as a new NFT authorized operators
    /// @param _approved True if the operator is approved, false to revoke approval
    function setApprovalForAll(address _operator, bool _approved) external {
        require(_operator != address(0), "Invalid _operator");

        operator[msg.sender][_operator] = _approved;

        emit ApprovalForAll(msg.sender, _operator, _approved);
    }

    /// @notice Query if an address is an authorized operator for another address
    /// @param _owner The address that owns the NFTs
    /// @param _operator The address that acts on behalf of the owner
    /// @return True if `_operator` is an approved operator for `_owner`, false otherwise
    function isApprovedForAll(address _owner, address _operator) external view returns (bool){
        return operator[_owner][_operator];
    }

    /// @notice Issues a new token of the collection
    /// @dev Throw if `_recipient` is zero address
    /// @dev Throw if `_uri` is empty. URIs are defined in RFC 3986. The URI may point to a JSON file that conforms
    /// to the "ERC721 Metadata JSON Schema".
    /// @param _recipient It is the recipient account for the new NFT
    /// @param _uri It is the uri for the new NFT
    function mint(address _recipient, string memory _uri) external {
        require(_recipient != address(0), "Invalid _recipient");
        require(bytes(_uri).length > 0, "Invalid _uri");

        totalSupply += 1;
        uint256 newToken = totalSupply;
        ownerOf[newToken] = _recipient;
        balanceOf[_recipient] += 1;
        tokenURI[newToken] = _uri;

        emit Transfer(address(0), _recipient, newToken);
    }

    /// @notice Burn an NFT. Remove it from the collection
    /// @dev This operation does not decrease the 'totalSupply' variable
    /// @dev Throw if msg.sender is not the current owner, an authorized operator, or the approved address for the NFT
    /// @dev Throw if `_tokenId` is invalid, AKA zero or grather then totalSupply
    /// @param _tokenId The identifier of the token to burn
    function burn(uint256 _tokenId) external isApproved(_tokenId) isValidToken(_tokenId) {
        address previousOwner = ownerOf[_tokenId];

        balanceOf[previousOwner] -= 1;
        delete ownerOf[_tokenId];
        delete approved[_tokenId];
        delete tokenURI[_tokenId];

        emit Transfer(previousOwner, address(0), _tokenId);
    }

    mapping(uint256 => LockState) myLockInfo;
    function lockInfo(uint256 _tokenId) external view returns (LockState memory) {
        return myLockInfo[_tokenId];
    }

    /**
     * @notice Fija el estado del NFT.
     * @dev Revertir si el msg.sender no es owner del contrato. Mensaje: "Not an owner"
     */
    function setIsLocked(uint256 _tokenId, bool _isLocked) external {
        myLockInfo[_tokenId] = LockState(_isLocked, msg.sender);
    }
}

interface ERC721Receiver {
    function onERC721Received(address from, address to, uint256 tokenId, bytes calldata data) external returns (bytes4);
}