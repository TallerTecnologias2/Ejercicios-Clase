//SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

/// @notice This is an example of a smart contract with calculator functionalities
/// @dev Comment follow the Ethereum ´Natural Specification´ language format (´natspec´)
/// Referencia: https://docs.soliditylang.org/en/v0.8.16/natspec-format.html
contract Calculator {

    /// STATE VARIABLES
    address public owner;

    /// MODIFIERS

    /// @dev Define a modifier called "isOutOfRange" that takes two non-negative numbers as a parameter and reverts in case
    /// that both are above 1000000000000, with message "Value out of range"
    

    /// @dev Define a modifier called "isBEqualOrLessThenA" that takes two non-negative numbers as a parameter and reverts in
    /// case the second number is greater than the first, with the message "Subtrahend can't be greater than minuend"
    

    /// @notice Initialize the state of the contract
    /// @dev Set the owner of the contract as the deployer account
    constructor() {
        
    }

    /**
     * @notice Returns the addition of two unsigned integers
     * @dev Parameter values ​​must be equal or lower than 1.000.000.000.000. 
     * Otherwise revert with error "addition - Out of range value".
     * @param _a It is a uint256 number equal or lower than 1.000.000.000.000.
     * @param _b It is a uint256 number equal or lower than 1.000.000.000.000.
     * @return _result It is a uint256 number.
     */
    function addition(uint256 _a, uint256 _b) external pure returns(uint256 _result) {
        
    }

    /**
     * @notice Returns the subtraction of two unsigned integers.
     * @dev Parameter values ​​must be equal or lower than 1.000.000.000.000. 
     * Otherwise revert with error "subtraction - Out of range value".
     * @param _a It is a uint256 number equal or lower than 1.000.000.000.000.
     * @param _b It is a uint256 number equal or lower than the value of parameter _a. 
     * Otherwise revert with error "subtraction - Subtrahend can't be greater than minuend"
     * @return _result It is a uint256 number.
     */
    function subtraction(uint256 _a, uint256 _b) external pure returns(uint256 _result) {
        
    }

    /**
     * @notice Returns the multiplication of two unsigned integers
     * @dev Parameter values ​​must be equal or lower than 1.000.000.000.000.
     * Otherwise revert with error "multiplication - Out of range value"
     * @param _a It is a uint256 number equal or lower than 1.000.000.000.000.
     * @param _b It is a uint256 number equal or lower than 1.000.000.000.000.
     * @return _result It is a uint256 number.
     */
    function multiplication(uint256 _a, uint256 _b) external pure returns(uint256 _result) {
        
    }

    /**
     * @notice Returns the division of two unsigned integers
     * @dev Parameter values ​​must be equal or lower than 1.000.000.000.000. 
     * Otherwise revert with error "division - Out of range value"
     * @param _a It is a uint256 number equal or lower than 1.000.000.000.000.
     * @param _b It is a uint256 number greater than 0. 
     * Otherwise revert with error "division - Dividend can't be zero"
     * @return _result It is a uint256 number.
     */
    function division(uint _a, uint _b) external pure returns(uint256 _result) {
        
    }
}
