//SPDX-License-Identifier:MIT
pragma solidity 0.8.9;

/// @notice This contract receive incoming call from other contract and return his balance
contract BeaconContract {

    /// @notice Address of the owner of the protocole
    address public owner;

    /// @notice Address of the authorised contract operator
    address public authorizedContract;

    /// @notice Store the last address that request the balance
    address public lastCaller;

    /// @notice Initializa the contract with the caller address as owner address
    constructor() {
        
    }

    /// @notice Set the authoriced contract operator
    /// @dev Only the owner can call this functions, otherwise revert with "Not the owner"
    /// @param _address It is the address of caller contract. In case of zero address revert with "Invalid _address"
    function setAuthorizedContract(address _address) external {
        
    }
    
    /// @notice Return the balance of the contract
    /// @dev Must store the address of the caller in lastCaller variable
    function getBalance() external view returns(uint256 _balance) {
        
    }

    /// @notice Set the lastCaller variable with the address of the sender
    /// @dev Only the authorizedContract or the owner can call this functions, otherwise revert with "Not authorized"
    function setLastCaller() external {
        
    }
}

/// @notice This contract call to Beacon Contract to get his balance
contract CallerContract {
    
    /// @notice Call the Beacon contract and retrieve the last address that call the Beacon contract
    /// @param _beaconContract It is an instance of the Beacon contract 
    function getBeaconContractLastCaller(BeaconContract _beaconContract) external view returns(address _lastCaller) {
        
    }

    /// @notice Call the Beacon contract and retrieve his balance
    /// @param _beaconContract It is an instance of the Beacon contract 
    function getBeaconContractBalance(BeaconContract _beaconContract) external view returns(uint256 _balance) {
        
    }

    ///@notice Call the Beacon contract and set lastCaller variable
    /// @param _beaconContract It is an instance of the Beacon contract 
    function setLastCaller(BeaconContract _beaconContract) external {
        
    }
}