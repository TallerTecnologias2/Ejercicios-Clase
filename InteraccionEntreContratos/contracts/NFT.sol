// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
// import "hardhat/console.sol";
import "../interfaces/IERC721.sol";
import "../interfaces/ILockableNFT.sol";

contract NFT is IERC721, ILockableNFT {

    string public name;
    string public symbol;
    uint256 public totalSupply;
    uint256 public maxSupply;
    uint8 public decimals;

    address public owner;
    address public marketplaceAddress;

    mapping(address => uint256) public balanceOf;
    mapping(uint256 => address) public approved;
    mapping(address => mapping(address => bool)) public operators;
    mapping(uint256 => address) public owners;
    mapping(uint256 => string) public tokenURIs;
    mapping(uint256 => LockState) public lockStates;
    

    constructor(string memory _name, string memory _symbol, uint8 _decimals, uint256 _maxSupply) {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        maxSupply = _maxSupply;
        owner = msg.sender;
        totalSupply = 0;
    }

    function name() external returns (string memory){
        return name;
    }
    function symbol() external returns (string memory){
        return symbol;
    }
    function decimals() external returns (uint8){
        return decimals;
    }
    function totalSupply() external returns (uint256){
        return totalSupply;
    }
    function maxSupply() external returns (uint256){
        return maxSupply;
    }
    function balanceOf(address account) external view returns (uint256){
        return balanceOf[account];
    }
    function approved(uint256 _tokenId) external view returns (address){
        return approved[_tokenId];
    }
    function operator(address _owner, address _operator) external view returns (bool){
        return operators[_owner][_operator];
    }
    function tokenURI(uint256 _tokenId) external view returns (string memory){
        return tokenURIs[_tokenId];
    }
    function ownerOf(uint256 _tokenId) external view returns (address){
        return owners[_tokenId];
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

    function safeTransfer(address _to, uint256 _tokenId) external{
        require(_tokenId < totalSupply, "Invalid_tokenId");
        require(_to != address(0), "Invalid_address");
        require(owners[_tokenId] == msg.sender, "Not_the_owner");
        if (msg.sender != owner && !operators[msg.sender][msg.sender]) {
            require(approved[_tokenId] == msg.sender, "Not_authorized");
        }
        owners[_tokenId] = _to;
        balanceOf[msg.sender] -= 1;
        balanceOf[_to] += 1;
        emit Transfer(msg.sender, _to, _tokenId);
        if (isContract(_to)) {
            bytes4 retval = IERC721Receiver(_to).onERC721Received(msg.sender, msg.sender, _tokenId, "");
            require(retval == 0x150b7a02, "Invalid_contract");
        }
    }
    /// @notice Transfiere la propiedad de un NFT desde la dirección '_from' a la dirección '_to'
    /// @dev Revertir si `_tokenId` no es un identificador de NFT válido con "Invalid_tokenId".
    /// @dev Revertir si `_to` es la dirección cero con "Invalid_address".
    /// @dev Revertir si `_from` no es el propietario actual con el mensaje "Not_the_owner".
    /// @dev Revertir a menos que el remitente sea el propietario actual o una dirección autorizada para el NFT, con el mensaje
    /// "Not_authorized".
    /// @dev Cuando la transferencia se completa, esta función verifica si `_to` es un contrato inteligente (tamaño de código > 0),
    /// si es así, llama a `onERC721Received` en `_to` y Revertir si el valor de retorno no es
    /// `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`, mensaje: "Invalid_contract".
    /// @dev Emitir el evento "Transfer" con los parámetros correspondientes.
    /// @param _from El propietario actual del NFT
    /// @param _to La dirección del nuevo propietario
    /// @param _tokenId El identificador de NFT a transferir
    function safeTransferFrom(address _from, address _to, uint256 _tokenId) external{
        require(_tokenId < totalSupply, "Invalid_tokenId");
        require(_to != address(0), "Invalid_address");
        require(owners[_tokenId] == _from, "Not_the_owner");
        require(_from == msg.sender || approved[_tokenId] == _from || operators[_from][msg.sender], "Not_authorized");
        owners[_tokenId] = _to;
        balanceOf[_from] -= 1;
        balanceOf[_to] += 1;
        emit Transfer(_from, _to, _tokenId);
        if (isContract(_to)) {
            bytes4 retval = IERC721Receiver(_to).onERC721Received(_from, _from, _tokenId, "");
            require(retval == 0x150b7a02, "Invalid_contract");
        }
    }

    /// @notice Cambia o reafirma la dirección aprobada para administrar un NFT
    /// @dev La dirección cero indica que no hay dirección aprobada.
    /// @dev Revertir si `_tokenId` no es un identificador de NFT válido. Mensaje: "Invalid_tokenId".
    /// @dev Revertir a menos que `msg.sender` sea el propietario actual de NFT o una dirección autorizada del NFT.
    /// Mensaje "Not_authorized".
    /// @dev Emitir el evento "Approval" con los parámetros correspondientes.
    /// @param _approved El nuevo administrador de NFT
    /// @param _tokenId El identificador de NFT a transferir
    function approve(address _approved, uint256 _tokenId) external{
        require(_tokenId < totalSupply, "Invalid_tokenId");
        require(owners[_tokenId] == msg.sender || operators[owners[_tokenId]][msg.sender], "Not_authorized");
        approved[_tokenId] = _approved;
        emit Approval(msg.sender, _approved, _tokenId);
    }

    /// @notice Habilita o deshabilita la aprobación para un tercero "operador" para gestionar todos los activos de `msg.sender`
    /// @dev El contrato debe permitir varios operadores por propietario
    /// @dev Revertir si `_operator` es la dirección cero. Mensaje: "Invalid _operator"
    /// @dev Emitir el evento `ApprovalForAll`.
    /// @param _operator La dirección a agregar como nuevos operadores autorizados NFT
    /// @param _approved True si el operador está aprobado, false para revocar la aprobación
    function setApprovalForAll(address _operator, bool _approved) external{
        require(_operator != address(0), "Invalid _operator");
        operators[msg.sender][_operator] = _approved;
        emit ApprovalForAll(msg.sender, _operator, _approved);
    }

    /// @notice Consulta si una dirección es un operador autorizado para otra dirección
    /// @param _owner La dirección que posee los NFTs
    /// @param _operator La dirección que actúa en nombre del propietario
    /// @return True si `_operator` es un operador aprobado para `_owner`, false en caso contrario
    function isApprovedForAll(address _owner, address _operator) external view returns (bool){
        return operators[_owner][_operator];
    }
    
    /// @notice Emite un nuevo NFT
    /// @dev Revertir si `_recipient` es la dirección cero. Mensaje: "Invalid _recipient"
    /// @dev Revertir si `_uri` es una cadena vacía. Las URIs se definen en RFC 3986. La URI puede apuntar a un archivo JSON que
    /// cumpla con el esquema "JSON Metadata de NFT ERC-721".
    /// @dev Revertir si el msg.sender no es el contrato Marketplace. Mensaje: "Not a marketplace"
    /// @param _recipient Es la cuenta del destinatario para el nuevo NFT
    /// @param _uri Es la URI para el nuevo NFT
    function mint(address _recipient, string memory _uri) external{
        require(_recipient != address(0), "Invalid _recipient");
        require(bytes(_uri).length > 0, "Invalid _uri");
        require(msg.sender == marketplaceAddress, "Not a marketplace");
        require(totalSupply < maxSupply, "Max supply reached");
        totalSupply += 1;
        balanceOf[_recipient] += 1;
        owners[totalSupply] = _recipient;
        tokenURIs[totalSupply] = _uri;
        emit Transfer(address(0), _recipient, totalSupply);
    }

    /**
     * @notice Asigna el address de marketplace
     * @dev Revertir si el msg.sender no es el owner del contrato
     * @dev Revertir si el _marketplace es el address 0
     */
    function setMarketplaceAddress(address _marketplace) external{
        require(msg.sender == owner, "Not an owner");
        require(_marketplace != address(0), "Marketplace address cannot be 0");
        marketplaceAddress = _marketplace;
    }

    /**
     * @notice Devuelve el estado del NFT.
     */
    function lockInfo(uint256 _tokenId) external view returns (LockState memory){
        return lockStates[_tokenId];
    }   

    /**
     * @notice Fija el estado del NFT.
     * @dev Revertir si el msg.sender no es owner del contrato. Mensaje: "Not an owner"
     */
    function setIsLocked(uint256 _tokenId, bool _isLocked) external{
        require(msg.sender == owner, "Not an owner");
        lockStates[_tokenId] = LockState(_isLocked, msg.sender);
    }

    /**
     * @notice Asigna el address de marketplace
     * @dev Revertir si el msg.sender no es el owner del contrato
     * @dev Revertir si el _marketplace es el address 0
     */
    function setMarketplaceAddress(address _marketplace) external{
        require(msg.sender == owner, "Not an owner");
        require(_marketplace != address(0), "Marketplace address cannot be 0");
        marketplaceAddress = _marketplace;
    }
}