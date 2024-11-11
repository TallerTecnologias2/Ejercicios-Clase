// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
// import "hardhat/console.sol";
import "../interfaces/IMarketplace.sol";
import "./OwnableContract.sol";
import "../interfaces/IOwnersContract.sol";

contract Marketplace is IMarketplace, OwnableContract {
    
    uint256 private price;
    address private nftAddress;

    


    constructor(address _ownersContract, uint256 _price, address _nftAddress ) OwnableContract(_ownersContract) {
        price = _price;
        nftAddress = _nftAddress;
    }


    function price() external returns (uint256){
        return price;
    }
    function ownersAddress() external returns (address){
        return ownersContract;
    }
    function nftAddress() external returns (address){
        return nftAddress;
    }

    /**
     * @notice Permite comprar un NFT.
     * @dev En caso de éxito debe disparar el evento `NFTBought`.
     * @dev Revertir si msg.value no alcanza para pagar por el NFT al precio actual. Mensaje: "Insufficient ETH"
     * @return Es el identificador del NFT comprado.
     */
    function buyNFT() external payable returns (uint256) {
        require(msg.value >= price, "Insufficient ETH");
        emit NFTBought(1);
        return 1;
    }

}