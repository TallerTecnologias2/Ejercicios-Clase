// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
import "hardhat/console.sol";
import "../interfaces/IMarketplace.sol";
import "../interfaces/IERC20.sol";

contract Marketplace is IMarketplace {
    uint256 public price;
    address public owner;
    address public tokenAddress;
    IERC20 tokenContract;
    uint256 collectedFees;

    constructor(uint256 _price, address _tokenAddress) {
        owner = msg.sender;
        price = _price;
        tokenAddress = _tokenAddress;
        tokenContract = IERC20(tokenAddress);
    }

    /**
     * @notice Transfiere la cantidad `amount` de tokens a la dirección `msg.sender`.
     * @dev En caso de éxito debe disparar el evento `TokenBought`.
     * @dev Revertir si `_amount` es cero. Mensaje: "Invalid amount"
     * @dev Revertir si msg.value no alcanza para pagar por la cantidad `_amount` al precio actual. Mensaje: "Insufficient ETH"
     * @dev Revertir si el contrato no posee suficientes tokens. Mensaje: "Contract doesn't have enough tokens"
     * @param _amount Es la cantidad de tokens a comprar.
     */
    function buyToken(uint256 _amount) external payable {
        require(_amount != 0, "Invalid amount");
        uint256 amountToPay = _amount * price;
        require(msg.value >= amountToPay, "Insufficient ETH");
        require(tokenContract.balanceOf(address(this)) >= _amount,  "Contract doesn't have enough tokens");
        tokenContract.transfer(msg.sender, _amount);
        emit TokenBought(msg.sender, _amount);
    }

    /**
     * @notice Transfiere la cantidad `amount` de tokens del msg.sender al contrato y devuelve el valor en ETH a 1/3 del precio.
     * @dev En caso de éxito debe disparar el evento `TokenSold`.
     * @dev Revertir si `_amount` es cero. Mensaje: "Invalid amount"
     * @dev Revertir si contrato el no tiene suficiente allowance del token. Mensaje: "Insufficient allowance"
     * @param _amount Es la cantidad de tokens a comprar.
     */
    function sellToken(uint256 _amount) external {
        require(_amount > 0, "Invalid amount");
        require(tokenContract.allowance(msg.sender, address(this)) > _amount, "Insufficient allowance");

        tokenContract.transferFrom(msg.sender, address(this), _amount);
        uint256 amountToTransfer = _amount * price / 3;
        collectedFees += amountToTransfer * 2;
        payable(msg.sender).transfer(amountToTransfer);
        emit TokenSold(msg.sender, _amount);
    }

    /**
     * @notice Fija el precio del token para compra.
     * @dev Revertir si `_price` es cero. Mensaje: "Invalid _price"
     * @dev Revertir si msg.sender no es el owner del contrato. Mensaje: "Not the owner"
     * @param _price Es el nuevo precio del contrato
     */
    function setPrice(uint256 _price) external {
        require(msg.sender == owner, "Not the owner");
        require(_price > 0, "Invalid _price");

        price = _price;
    }

    /**
     * @notice Envia las comisiones obtenidas (la diferencia entre compra venta) al owner
     * @dev Revertir si msg.sender no es el owner del contrato. Mensaje: "Not the owner"
     */
    function collectFees() external {
        require(msg.sender == owner, "Not the owner");
        payable(msg.sender).transfer(collectedFees);
    }
}
