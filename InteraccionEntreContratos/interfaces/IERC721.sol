//SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

/// @notice Este contrato sigue el estándar para tokens ERC-721
/// @dev El comentario sigue el formato de lenguaje de 'Especificación natural' de Ethereum ('natspec')
/// Referencia: https://docs.soliditylang.org/en/v0.8.16/natspec-format.html
interface IERC721 {
    function name() external returns (string memory);
    function symbol() external returns (string memory);
    function decimals() external returns (uint8);
    function totalSupply() external returns (uint256);
    function maxSupply() external returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function approved(uint256 _tokenId) external view returns (address);
    function operator(address _owner, address _operator) external view returns (bool);
    function tokenURI(uint256 _tokenId) external view returns (string memory);
    function ownerOf(uint256 _tokenId) external view returns (address);

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

    function safeTransfer(address _to, uint256 _tokenId) external;
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
    function safeTransferFrom(address _from, address _to, uint256 _tokenId) external;

    /// @notice Cambia o reafirma la dirección aprobada para administrar un NFT
    /// @dev La dirección cero indica que no hay dirección aprobada.
    /// @dev Revertir si `_tokenId` no es un identificador de NFT válido. Mensaje: "Invalid_tokenId".
    /// @dev Revertir a menos que `msg.sender` sea el propietario actual de NFT o una dirección autorizada del NFT.
    /// Mensaje "Not_authorized".
    /// @dev Emitir el evento "Approval" con los parámetros correspondientes.
    /// @param _approved El nuevo administrador de NFT
    /// @param _tokenId El identificador de NFT a transferir
    function approve(address _approved, uint256 _tokenId) external;

    /// @notice Habilita o deshabilita la aprobación para un tercero "operador" para gestionar todos los activos de `msg.sender`
    /// @dev El contrato debe permitir varios operadores por propietario
    /// @dev Revertir si `_operator` es la dirección cero. Mensaje: "Invalid _operator"
    /// @dev Emitir el evento `ApprovalForAll`.
    /// @param _operator La dirección a agregar como nuevos operadores autorizados NFT
    /// @param _approved True si el operador está aprobado, false para revocar la aprobación
    function setApprovalForAll(address _operator, bool _approved) external;

    /// @notice Consulta si una dirección es un operador autorizado para otra dirección
    /// @param _owner La dirección que posee los NFTs
    /// @param _operator La dirección que actúa en nombre del propietario
    /// @return True si `_operator` es un operador aprobado para `_owner`, false en caso contrario
    function isApprovedForAll(address _owner, address _operator) external view returns (bool);
    
    /// @notice Emite un nuevo NFT
    /// @dev Revertir si `_recipient` es la dirección cero. Mensaje: "Invalid _recipient"
    /// @dev Revertir si `_uri` es una cadena vacía. Las URIs se definen en RFC 3986. La URI puede apuntar a un archivo JSON que
    /// cumpla con el esquema "JSON Metadata de NFT ERC-721".
    /// @dev Revertir si el msg.sender no es el contrato Marketplace. Mensaje: "Not a marketplace"
    /// @param _recipient Es la cuenta del destinatario para el nuevo NFT
    /// @param _uri Es la URI para el nuevo NFT
    function mint(address _recipient, string memory _uri) external;

    /**
     * @notice Asigna el address de marketplace
     * @dev Revertir si el msg.sender no es el owner del contrato
     * @dev Revertir si el _marketplace es el address 0
     */
    function setMarketplaceAddress(address _marketplace) external;

    event Transfer(
        address indexed _from,
        address indexed _to,
        uint256 indexed _tokenId
    );
    event Approval(
        address indexed _owner,
        address indexed _approved,
        uint256 indexed _tokenId
    );
    event ApprovalForAll(
        address indexed _owner,
        address indexed _operator,
        bool _approved
    );
}