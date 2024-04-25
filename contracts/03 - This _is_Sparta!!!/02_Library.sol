//SPDX-License-Identifier:MIT
pragma solidity 0.8.9;

/**
 * @notice This is bookstore-as-a-service contract for a bookstore
 */
contract Library {

    /// @dev Fields:
    /// copies: Number of copies of the same book
    /// ISBN: International Standard Book Number
    /// Title: Title of the book
    /// author: Author names array
    /// authorAccount: authorName => authorAddress
    struct Book {
        uint256 copies;
        uint256 ISBN;
        string title;
        string[] author;
        mapping(string => address) authorAccount;
    }

    /// @dev Fields
    /// ISBN: International Standard Book Number
    /// Title: Title of the book
    /// author: Author names array
    struct Book_Metadata {
        uint256 ISBN;
        string title;
        string[] author;
    }

    /// @dev ISBN => Book
    mapping(uint256 => Book) public book;

    /// @dev AuthorName => ISBN
    mapping(string => uint256[]) public bookByAuthor;

    /// @notice Add a new book to the library.
    /// @dev Store all the book information in the book mapping.
    /// @dev If the book is already stored in the library mapping, increase its count but do not re-store it
    /// @param _book contains the metadata of the new book
    /// @param _authorAddress It is an array with an address for each author of the book, sorted in the same order 
    /// as the authors array in the book's metadata 
    function addBook(Book_Metadata memory _book, address[] memory _authorAddress) external {
        
    }

    /// @notice Return all book titles for indicated author
    /// @dev Returns an array of strings with the name of all the titles of an author without repetitions
    /// @param _authorName Author name to search 
    function getAllBookTitlesByAuthor(string memory _authorName) external view returns(string[] memory _bookTitle) {
        
    }

    /// @notice Update the autors of a book and his addresses
    /// @dev Delete all the authors information of the book before update operation
    /// @param _isbn ISBN of the bok to update. Revert if the isbn is not stored in the library with message "ISBN not registered"
    /// @param _authorName contains the list of book author names
    /// @param _authorAddress contains the list of book author address
    function updateAuthor(uint256 _isbn, string[] memory _authorName, address[] memory _authorAddress) external {
        
    }
}