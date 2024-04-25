//SPDX-License-Identifier:MIT
pragma solidity 0.8.9;

contract Katas {

    /**
     * @notice Cree una función llamada "countBy" con dos argumentos que devolverán una matriz de los primeros n múltiplos de x.
     * @dev El número dado y el número de veces a contar deben ser ambos números positivos mayores que 0.
     * De lo contrario, revertir con "Invalid input".
     * @return _result Debe ser una matriz de números.
     * @dev Ejemplos:
     * countBy(1,10) => debería devolver [1,2,3,4,5,6,7,8,9,10]
     * countBy(2,5) => debería devolver [2,4,6,8,10]
     */
    function countBy(uint256 _x, uint256 _n) external pure returns(uint256[] memory _result) {
        
    }

    /**
     * @notice Cree una función llamada "isFactor" que devuelva verdadero si un número _factor es un factor de un número _base,
     * y devolver false en caso contrario.
     * @dev Los factores son números que se pueden multiplicar para obtener otro número.
     * Por ejemplo: 2 y 3 son factores de 6 porque: 2 * 3 = 6
     * @dev Puedes encontrar un factor dividiendo números. Si el resto es 0, entonces el número es un factor.
     * Use el operador mod (%) para verificar si hay un resto. Por ejemplo 2 no es factor de 7 porque: 7 % 2 = 1
     * @param _base Es un número no negativo
     * @param _factor Debe ser un número positivo, de lo contrario revierte con "Invalid _factor"
     */
    function isFactor(uint256 _base, uint256 _factor) public pure returns (bool) {
        
    }

    /**
     * @notice Cree una función llamada "centuryOf", que reciba un año y devuelva el siglo en el que se encuentra.
     * @dev El primer siglo abarca desde el año 1 hasta el año 100 inclusive, el segundo siglo va desde el año
     * 101 hasta el año 200 inclusive, etc.
     * @dev Ejemplos: 1705 => 18; 1900 => 19; 1601 => 17; 2000 => 20; 2001 => 21
     * @param _year Debe ser un número entre 1 y el año actual, de lo contrario revierte con "Invalid _year".
     */
    function centuryOf(uint256 _year) external view returns(uint256 _century) {
        
    }

    /**
     * @notice Cree una función llamada "repeatMe", que acepte un número entero _n y una cadena _s como parámetros,
     * y devuelve una cadena de _s repetida exactamente _n veces.
     * @dev Ejemplos: 6, "I" => "IIIIII"; 5, "Hola" => "HolaHolaHolaHolaHola"
     * @param _n Es un número no negativo
     * @param _s No puede ser una cadena vacía, de lo contrario revierte con "Invalid string"
     */
    function repeatMe(uint256 _n, string memory _s) external pure returns(string memory _result) {
        
    }

     /**
     * @notice Crea una función llamada "trianglesGeometry", que recibe el valor en grados del ángulo _a y del ángulo _b
     * de un triángulo, y devuelve el valor del ángulo exterior del ángulo _a.
     * @dev Para esta tarea, tenga en cuenta el teorema fundamental del triángulo que dice que la suma de los ángulos de
     * cualquier triángulo suman 180 grados. Y el Teorema del Ángulo Exterior establece que un ángulo exterior de un 
     * triángulo es igual a la suma de sus ángulos interiores remotos.
     * Un ángulo exterior de un triángulo es un ángulo que es un par lineal (y por lo tanto suplementario) de un ángulo interior.
     * La medida de un ángulo exterior de un triángulo es igual a la suma de las medidas de los dos ángulos interiores que
     * no son adyacentes a él.
     * @dev La suma de _a y _b debe ser menor que 180, de lo contrario revierte con "Invalid angles";
     * @dev Use este enlace como referencia: https://en.wikipedia.org/wiki/Triangle
     * @param _a Es un número positivo, de lo contrario revierte con "Invalid angle _a"
     * @param _b Es un número positivo, de lo contrario revierte con "Invalid angle _b"
     */
    function trianglesGeometry(uint256 _a, uint256 _b) external pure returns(uint256 _result) {
        
    }

    /**
     * @notice Cree una función llamada "maxCombination", que reciba tres enteros a, b, c, y devuelva el número más grande
     * obtenido después de insertar los siguientes operadores y paréntesis: +, *, ()
     * @dev Pruebe todas las combinaciones de a,b,c con [*+()] sin intercambiar los operandos y devuelva el número máximo obtenido
     * @dev Ejemplos con entradas 1, 2, 3:
     * 1 * (2 + 3) = 5
     * 1 * 2 * 3 = 6
     * 1 + 2 * 3 = 7
     * (1 + 2) * 3 = 9
     * Vuelta 9
     * @dev Los números están en el rango 1  ≤  a, b, c  ≤  10, de lo contrario revierte con "Invalid inputs"
     * @dev Puedes usar la misma operación más de una vez
     * @dev No es necesario colocar todos los signos y paréntesis.
     * @dev Puede ocurrir repetición en números, como (1, 1, 1).
     * @dev No puede intercambiar los operadores. Por ejemplo, en el ejemplo dado, no puede obtener la expresión (1 + 3) * 2 = 8.
     */
    function maxCombination(uint256 _a, uint256 _b, uint256 _c) external pure returns(uint256 _result) {
        
    }
}