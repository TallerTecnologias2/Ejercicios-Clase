// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

interface IMarketplace {
    function price() external returns (uint256);
    function ownersAddress() external returns (address);
    function nftAddress() external returns (address);

    mapping(uint256 => bool) public lockedNFTs; 
    mapping(uint256 => uint256) public nftPrices;

    /**
     * @notice Permite comprar un NFT.
     * @dev En caso de éxito debe disparar el evento `NFTBought`.
     * @dev Revertir si msg.value no alcanza para pagar por el NFT al precio actual. Mensaje: "Insufficient ETH"
     * @return Es el identificador del NFT comprado.
     */
    function buyNFT() external payable returns (uint256){
        require(msg.value >= price, "Insufficient ETH");

        IERC721 nftContract = IERC721(nftAddress);
        nftContract.safeTransferFrom(address(this), msg.sender, 1);

        emit NFTBought(msg.sender, msg.value);
        return nftContract._tokenId;
    }

    /**
     * @notice Transfiere el NFT del msg.sender al contrato y devuelve el valor en ETH a 1/3 del precio al dueño del NFT.
     * @dev Debe revertir si el NFT está bloqueado. Mensaje: "NFT is locked"
     * @dev En caso de éxito debe disparar el evento `NFTSold`.
     * @dev Revertir si el contrato no tiene permisos para transferir el NFT. Mensaje: "No permissions"
     * @param _tokenId Es el identificador del NFT a vender.
     */
    function sellNFT(uint256 _tokenId) external{
        require(!lockedNFTs[_tokenId], "NFT is locked");

        IERC721 nftContract = IERC721(nftAddress);
        nftContract.safeTransferFrom(msg.sender, address(this), _tokenId);

        uint256 price = nftPrices[_tokenId];
        uint256 fee = price / 3;
        payable(ownersContract).transfer(fee);

        emit NFTSold(msg.sender, price);
    }

    /**
     * @notice Bloquea un NFT para que no pueda ser vendido.
     * @dev Debe revertir si el NFT está bloqueado. Mensaje: "NFT is locked"
     * @dev Debe revertir si el msg.sender no es el dueño del NFT. Mensaje: "Not the owner"
     * @param _tokenId Es el identificador del NFT a bloquear.
     */
    function lockNFT(uint256 _tokenId) external{
        require(!lockedNFTs[_tokenId], "NFT is locked");

        IERC721 nftContract = IERC721(nftAddress);
        require(nftContract.ownerOf(_tokenId) == msg.sender, "Not the owner");

        lockedNFTs[_tokenId] = true;
    }

    /**
     * @notice Desbloquea un NFT para que pueda ser vendido.
     * @dev Debe revertir si el NFT no está bloqueado. Mensaje: "NFT is not locked"
     * @dev Debe revertir si el msg.sender no es el dueño del NFT. Mensaje: "Not the owner"
     * @param _tokenId Es el identificador del NFT a desbloquear.
     */
    function unlockNFT(uint256 _tokenId) external{
        require(lockedNFTs[_tokenId], "NFT is not locked");

        IERC721 nftContract = IERC721(nftAddress);
        require(nftContract.ownerOf(_tokenId) == msg.sender, "Not the owner");

        lockedNFTs[_tokenId] = false;
    }

    /**
     * @notice Fija el precio del NFT para compra.
     * @dev Revertir si `_price` es cero. Mensaje: "Invalid _price"
     * @dev Revertir si msg.sender no es owner del contrato. Mensaje: "Not an owner"
     * @param _price Es el nuevo precio del contrato
     */
    function setPrice(uint256 _price) external{
        require(_price != 0, "Invalid _price");
        require(msg.sender == ownersContract, "Not an owner");

        price = _price;
    }

    /**
     * @notice Envia las comisiones obtenidas (la diferencia entre compra-venta) al owner
     * @dev Revertir si msg.sender no es owner del contrato. Mensaje: "Not an owner"
     */
    function collectFees() external{
        require(msg.sender == ownersContract, "Not an owner");

        payable(ownersContract).transfer(address(this).balance);
    }

    event NFTBought(address indexed buyer, uint256 amount);
    event NFTSold(address indexed sellet, uint256 amount);
}