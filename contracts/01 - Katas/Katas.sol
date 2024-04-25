//SPDX-License-Identifier:MIT
pragma solidity 0.8.9;

contract Katas {

    /**
     * @notice Create a function called "countBy" with two arguments that will return an array of the first n multiples of x.
     * @dev The given number and the number of times to count, must be both positive numbers greater than 0. 
     * Otherwise revert with "Invalid input". 
     * @return _result Must be an array of numbers.
     * @dev Examples: 
     * countBy(1,10) => should return [1,2,3,4,5,6,7,8,9,10]
     * countBy(2,5)  => should return [2,4,6,8,10] 
     */
    function countBy(uint256 _x, uint256 _n) external pure returns(uint256[] memory _result) {
        
    }

    /**
     * @notice Create a function called "isFactor" that return true if a number _factor it is a factor of a number _base, 
     * and return false otherwise.
     * @dev Factors are numbers you can multiply together to get another number.
     * For example: 2 and 3 are factors of 6 because: 2 * 3 = 6
     * @dev You can find a factor by dividing numbers. If the remainder is 0 then the number is a factor.
     * Use the mod operator (%) to check for a remainder. For example 2 is not a factor of 7 because: 7 % 2 = 1
     * @param _base It is a non-negative number
     * @param _factor Must be a positive number, otherwise revert with "Invalid _factor"
     */
    function isFactor(uint256 _base, uint256 _factor) public pure returns (bool) {
        
    }

    /**
     * @notice Create a function called "centuryOf", that receive a year and return the century it is in.
     * @dev The first century spans from the year 1 up to and including the year 100, the second century go from the year 
     * 101 up to and including the year 200, etc.
     * @dev Examples:  1705 => 18; 1900 => 19; 1601 => 17; 2000 => 20; 2001 => 21
     * @param _year Must be a number between 1 and current year, otherwise revert with "Invalid _year".
     */
    function centuryOf(uint256 _year) external view returns(uint256 _century) {
        
    }

    /**
     * @notice Create a function called "repeatMe", that accepts an integer _n and a string _s as parameters, 
     * and returns a string of _s repeated exactly _n times.
     * @dev Examples:  6, "I" => "IIIIII"; 5, "Hello" => "HelloHelloHelloHelloHello"
     * @param _n It is a non-negative number
     * @param _s It can't be empty string, otherwise revert with "Invalid string"
     */
    function repeatMe(uint256 _n, string memory _s) external pure returns(string memory _result) {
        
    }

    /**
     * @notice Create a function called "trianglesGeometry", which receives the value in degrees of angle _a and angle _b
     * of a triangle, and returns the value of the exterior angle of angle _a.
     * @dev For this task, take into account the fundamental theorem of the triangle that says that the sum of the internal 
     * angles of any triangle adds up to 180 degrees
     * And the Exterior Angle Theorem establishes that an exterior angle of a triangle is equal to the sum of its remote 
     * interior angles.
     * An exterior angle of a triangle is an angle that is a linear pair (and hence supplementary) to an interior angle.
     * The measure of an exterior angle of a triangle is equal to the sum of the measures of the two interior angles that 
     * are not adjacent to it.
     * @dev The addition of _a and _b must be less than 180, otherwise revert with "Invalid angles";
     * @dev Use this link as reference: https://en.wikipedia.org/wiki/Triangle
     * @param _a It is a positive number, oterwise revert with "Invalid angle _a"
     * @param _b It is a positive number, oterwise revert with "Invalid angle _b"
     */
    function trianglesGeometry(uint256 _a, uint256 _b) external pure returns(uint256 _result) {
        
    }

    /**
     * @notice Create a function called "maxCombination", that receive three integers a ,b ,c, return the largest number 
     * obtained after inserting the following operators and brackets: +, *, ()
     * @dev Try every combination of a,b,c with [*+()] without swap the operands, and return the maximum obtained number
     * @dev Examples with inputs 1, 2, 3:
     *      1 * (2 + 3) = 5
     *      1 * 2 * 3 = 6
     *      1 + 2 * 3 = 7
     *      (1 + 2) * 3 = 9
     *      Return 9
     * @dev Numbers are in the range 1  ≤  a, b, c  ≤  10, otherwise revert with "Invalid inputs"
     * @dev You can use the same operation more than once
     * @dev It's not necessary to place all the signs and brackets.
     * @dev Repetition in numbers may occur, like (1, 1, 1).
     * @dev You cannot swap the operands. For instance, in the given example you cannot get expression (1 + 3) * 2 = 8.
     */
    function maxCombination(uint256 _a, uint256 _b, uint256 _c) external pure returns(uint256 _result) {
        
    }
}