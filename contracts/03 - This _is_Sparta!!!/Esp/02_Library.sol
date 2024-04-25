//SPDX-License-Identifier:MIT
pragma solidity 0.8.9;

/**
 * @notice Este es un contrato de librería como servicio
 */
contract Library {

    /// @dev Campos:
    /// copies (ejemplares): Número de ejemplares de un mismo libro
    /// ISBN: Sigla de la expresión inglesa international standard book number, 'número estándar internacional de libro', número de identificación internacional asignado a los libros.
    /// title (título): Título del libro
    /// author (autor): matriz de nombres de autor
    /// authorAccount (cuentas de autor): nombre del autor => dirección del autor
    struct Book {
        uint256 copies;
        uint256 ISBN;
        string title;
        string[] author;
        mapping(string => address) authorAccount;
    }

    /// @dev Campos
    /// ISBN: Sigla de la expresión inglesa international standard book number, 'número estándar internacional de libro', número de identificación internacional asignado a los libros.
    /// title (título): Título del libro
    /// author (autor): Matriz de nombres de autor
    struct Book_Metadata {
        uint256 ISBN;
        string title;
        string[] author;
    }

    /// @dev ISBN => Book
    mapping(uint256 => Book) public book;

    /// @dev AuthorName => ISBN
    mapping(string => uint256[]) public bookByAuthor;

    /// @notice Agrega un nuevo libro a la biblioteca.
    /// @dev Almacena toda la información del libro en el mapeo del libro.
    /// @dev Si el libro ya está almacenado en el mpping de la biblioteca, aumente su conteo pero no lo ingrese nuevamente
    /// @param _book contiene los metadatos del nuevo libro
    /// @param _authorAddress Es una matriz con una dirección para cada autor del libro, ordenados en el mismo orden
    /// como la matriz de autores en los metadatos del libro
    function addBook(Book_Metadata memory _book, address[] memory _authorAddress) external {
        
    }

    /// @notice Devuelve todos los títulos de libros para el autor indicado
    /// @dev Devuelve un array de cadenas con el nombre de todos los títulos de un autor sin repeticiones
    /// @param _authorName Nombre del autor a buscar
    function getAllBookTitlesByAuthor(string memory _authorName) external view returns(string[] memory _bookTitle) {
        
    }

    /// @notice Actualiza los autores de un libro y sus direcciones
    /// @dev Elimina toda la información de los autores del libro antes de la operación de actualización
    /// @param _isbn ISBN del libro a actualizar. Revertir si el isbn no está almacenado en la biblioteca con el mensaje "ISBN not registered"
    /// @param _authorName contiene la lista de nombres de autores de libros
    /// @param _authorAddress contiene la lista de direcciones del autor del libro
    function updateAuthor(uint256 _isbn, string[] memory _authorName, address[] memory _authorAddress) external {
        
    }
}