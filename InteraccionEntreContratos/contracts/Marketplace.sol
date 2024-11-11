// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
// import "hardhat/console.sol";
import "../interfaces/IMarketplace.sol";
import "./OwnableContract.sol";
import "../interfaces/IOwnersContract.sol";

contract Marketplace is IMarketplace, OwnableContract {
    
    constructor(address _ownersContract) OwnableContract(_ownersContract) {

    }

    
    function price() external returns (uint256){
        return 0;
    }
    function ownersAddress() external returns (address){
        return this.ownersContract;
    }
    function nftAddress() external returns (address);

    /**
     * @notice Permite comprar un NFT.
     * @dev En caso de éxito debe disparar el evento `NFTBought`.
     * @dev Revertir si msg.value no alcanza para pagar por el NFT al precio actual. Mensaje: "Insufficient ETH"
     * @return Es el identificador del NFT comprado.
     */
    function buyNFT() external payable returns (uint256);

}