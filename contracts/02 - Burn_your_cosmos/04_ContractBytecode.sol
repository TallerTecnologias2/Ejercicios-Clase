//SPDX-License-Identifier:MIT
pragma solidity 0.8.9;

import "hardhat/console.sol";

/// @notice Return the calling contract bytecode.
contract BytecodeContract {

    /// @dev Define an event call 'publishBytecode' that posts a byte variable
    

    /// @notice Return the calling contract bytecode.
    /// @dev If the calling account is not a contract, revert with "Not a contract".
    /// @dev This function can only publish the 'publishBytecode' event every 3 blocks, otherwise revert with 
    /// "Only one call every 3 block is allowed"
    function giveMeMyBytecode() external {
        
    }
}

contract CallingContract {

    /// @notice This variable is used to force a transaction in the blockchain. Do not delete or modify it.
    bool public forceTransaction;

    /// @dev This method is used to force a transaction on the blockchain from the tests. Do not delete or modify it.
    function setForceTransaction() external {
        forceTransaction = !forceTransaction;
    }

    /// @notice Define a function to call to Bytecode contract giveMeMyBytecode method
    /// @param _contractBytecodeAddress It is the address of the Bytecode contract 
    function CallToContract(address _contractBytecodeAddress) external {

    }    
}