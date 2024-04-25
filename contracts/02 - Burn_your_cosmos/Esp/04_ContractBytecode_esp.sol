//SPDX-License-Identifier:MIT
pragma solidity 0.8.9;

import "hardhat/console.sol";

/// @notice Devolve el bytecode del contrato llamador.
contract BytecodeContract {

    /// @dev Defina un evento llamado 'publishBytecode' que publique una variable de byte
    

    /// @notice Devuelve el bytecode del contrato llamador.
    /// @dev Si la cuenta que llama no es un contrato, revertir con "Not a contract".
    /// @dev Esta función solo puede disparar el evento 'publishBytecode' cada 3 bloques, de lo contrario, revertir con
    /// "Only one call every 3 block is allowed"
    function giveMeMyBytecode() external {
        
    }
}

contract CallingContract {

    /// @notice Esta variable se utiliza para forzar una transacción en la cadena de bloques. No la borre ni la modifique.
    bool public forceTransaction;

    /// @dev Este método se utiliza para forzar una transacción en la cadena de bloques a partir de las pruebas. No lo borre ni lo modifique.
    function setForceTransaction() external {
        forceTransaction = !forceTransaction;
    }

    /// @notice Defina una función que llame al método giveMeMyBytecode del contrato Bytecode
    /// @param _contractBytecodeAddress Es la dirección del contrato Bytecode
    function CallToContract(address _contractBytecodeAddress) external {

    }    
}