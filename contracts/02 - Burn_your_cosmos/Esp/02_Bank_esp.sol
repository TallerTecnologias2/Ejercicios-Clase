//SPDX-License-Identifier:MIT
pragma solidity 0.8.9;

/**
 * @notice Complete los métodos del próximo contrato que simula las funcionalidades básicas de un banco tradicional
 * pero para los ethers de criptomonedas
 */
contract Bank {

    /// @dev Defina un mapping llamado "balanceOf" para mantener el saldo de la cuenta de cada usuario
    /// @dev Dirección de la cuenta => saldo de la cuenta
    

    /// @dev Define un modificador llamado "isValidAmount" que recibe un entero positivo como parámetro y revierte en caso
    /// que el valor es cero o mayor que el saldo de la cuenta del remitente de la transacción, con el mensaje "Invalid _amount"
    

    /// @dev Define un modificador llamado "isValidAddress" que recibe una dirección como parámetro y revierte en caso de que sea la 
    /// dirección cero con el mensaje "Invalid _address"
    

    /// @notice Permite el depósito de una cantidad de éteres a la cuenta del remitente.
    /// @dev Si el remitente no existe, abra una cuenta y cargue el depósito
    /// @dev El monto a depositar debe ser mayor a cero. De lo contrario, revertir con "Invalid _amount"
    function deposit() external payable {
        
    }

    /// @notice Permite el retiro de una cantidad previamente depositada
    /// @param _amount Debe ser mayor que cero y menor o igual que el saldo de la cuenta del remitente.
    /// De lo contrario, revertir con "Invalid _amount"
    function withdraw(uint256 _amount) external {
        
    }

    /// @notice Permite transferir una cantidad de ethers de una cuenta existente a otra cuenta.
    /// @dev Si la cuenta del destinatario no existe, créala y asigna el saldo correspondiente
    /// @param _to Debe ser una dirección distinta de la dirección cero, de lo contrario, revertir con "Invalid recipient address"
    /// @param _amount Debe ser mayor que cero y menor o igual al saldo del remitente,
    /// de lo contrario revertir con "Invalid amount"
    function transfer(address _to, uint256 _amount) external {
        
    }

    /// @notice Definir una función que permita a cualquier cliente del banco conocer el saldo de cualquier cuenta registrada.
    /// @dev Si el remitente de la solicitud no es cliente del banco, revertir con el mensaje "Not a client"
    /// @param _account Es la cuenta para consultar el saldo. Debe ser una dirección distinta de cero y pertenecer a un cliente 
    /// del banco de lo contrario revertir con el mensaje "Invalid _address"
    function getBalance(address _account) external view returns(uint256) {
        
    }
}