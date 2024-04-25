//SPDX-License-Identifier:MIT
pragma solidity 0.8.9;

/// @notice Este contrato recibe llamadas entrantes de otro contrato y devuelve su saldo
contract BeaconContract {

    /// @notice Dirección del propietario del protocolo
    address public owner;

    /// @notice Dirección del contratado operador autorizado
    address public authorizedContract;

    /// @notice Almacena la última dirección que solicita el saldo
    address public lastCaller;

    /// @notice Inicializa el contrato con la dirección de la persona que llama como dirección del propietario
    constructor() {
    
    }

    /// @notice Establece el contrato operador autorizado
    /// @dev Solo el propietario del protocolo puede llamar a estas funciones, de lo contrario revertir con "Not the owner"
    /// @param _address Es la dirección del contrato de la persona que llama. En caso de dirección cero revertir con "Invalid _address"
    function setAuthorizedContract(address _address) external {
        
    }
    
    /// @notice Devolver el saldo del contrato
    /// @dev Debe almacenar la dirección de la persona que llama en la variable lastCaller
    function getBalance() external view returns(uint256 _balance) {
        
    }

    /// @notice Establecer la variable lastCaller con la dirección del remitente
    /// @dev Solo el contrato autorizado o el propietario pueden llamar a estas funciones, de lo contrario, revertir 
    /// con "Not authorized"
    function setLastCaller() external {
        
    }
}

/// @notice Este contrato llama a Beacon Contract para obtener su saldo.
contract CallerContract {
    
    /// @notice Llama al contrato Beacon y recupere la última dirección que llamó al contrato Beacon
    /// @param _beaconContract Es un objeto del contrato Beacon 
    function getBeaconContractLastCaller(BeaconContract _beaconContract) external view returns(address _lastCaller) {
        
    }

    /// @notice Llama al contrato Beacon y recupera su saldo
    /// @param _beaconContract Es un objeto del contrato Beacon 
    function getBeaconContractBalance(BeaconContract _beaconContract) external view returns(uint256 _balance) {
        
    }

    ///@notice Llama al contrato Beacon y establece la variable lastCaller
    /// @param _beaconContract Es un ojeto del contrato Beacon 
    function setLastCaller(BeaconContract _beaconContract) external {
        
    }
}