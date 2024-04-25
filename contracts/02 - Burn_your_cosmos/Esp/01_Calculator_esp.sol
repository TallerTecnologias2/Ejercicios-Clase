//SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

/// @notice Este es un ejemplo de un contrato inteligente con funcionalidades de calculadora
/// @dev Los comenta siguen el estandar de Ethereum ´Natural Specification´ language format (´natspec´)
/// Referencia: https://docs.soliditylang.org/en/v0.8.16/natspec-format.html
contract Calculator {

    /// VARIABLES DE ESTADO
    address public owner;

    /// MODIFIERS

    /// @dev Defina un modificador llamado "isOutOfRange" que tome dos números no negativos como parámetro y revierta en caso
    /// que ambos están por encima de 1000000000000, con mensaje "Value out of range"
    

    /// @dev Defina un modificador llamado "isBEqualOrLessThenA" que tome dos números no negativos como parámetro y revierta en
    /// caso que el segundo número sea mayor que el primero, con el mensaje"Subtrahend can't be greater than minuend"
    

    /// @notice Inicializa el estado del contrato
    /// @dev Establecer el propietario del contrato como la cuenta del implementador
    constructor() {
        
    }

    /**
     * @notice Devuelve la suma de dos enteros sin signo
     * @dev Los valores de los parámetros deben ser iguales o inferiores a 1.000.000.000.000.
     * De lo contrario revierte con el error "addition - Out of range value".
     * @param _a Es un número uint256 igual o menor a 1.000.000.000.000.
     * @param _b Es un número uint256 igual o menor a 1.000.000.000.000.
     * @return _result Es un número uint256.
     */
    function addition(uint256 _a, uint256 _b) external pure returns(uint256 _result) {
        
    }

    /**
     * @notice Devuelve la resta de dos enteros sin signo.
     * @dev Los valores de los parámetros deben ser iguales o inferiores a 1.000.000.000.000.
     * Caso contrario revierte con error "subtraction - Out of range value".
     * @param _a Es un número uint256 igual o menor a 1.000.000.000.000.
     * @param _b Es un número uint256 igual o menor que el valor del parámetro _a.
     * De lo contrario, revierte con el error "subtraction - Subtrahend can't be greater than minuend"
     * @return _result Es un número uint256.
     */
    function subtraction(uint256 _a, uint256 _b) external pure returns(uint256 _result) {
        
    }

    /**
     * @notice Devuelve la multiplicación de dos enteros sin signo
     * @dev Los valores de los parámetros deben ser iguales o inferiores a 1.000.000.000.000.
     * De lo contrario revierte con el error "multiplication - Out of range value"
     * @param _a Es un número uint256 igual o menor a 1.000.000.000.000.
     * @param _b Es un número uint256 igual o menor a 1.000.000.000.000.
     * @return _result Es un número uint256.
     */
    function multiplication(uint256 _a, uint256 _b) external pure returns(uint256 _result) {
        
    }

    /**
     * @notice Devuelve la división de dos enteros sin signo
     * @dev Los valores de los parámetros deben ser iguales o inferiores a 1.000.000.000.000.
     * De lo contrario revierte con el error "division - Out of range value"
     * @param _a Es un número uint256 igual o menor a 1.000.000.000.000.
     * @param _b Es un número uint256 mayor que 0.
     * De lo contrario, revierte con el error "division - Dividend can't be zero"
     * @return _result Es un número uint256.
     */
    function division(uint _a, uint _b) external pure returns(uint256 _result) {
        
    }
}
