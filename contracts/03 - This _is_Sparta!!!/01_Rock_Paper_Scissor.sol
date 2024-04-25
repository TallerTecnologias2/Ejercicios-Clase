 //SPDX-License-Identifier:MIT
pragma solidity 0.8.9;

/**
 * @notice Let's play Rock, Paper, Scissors on the blockchain! 
 */
contract Rock_Paper_Scissor {

    /// @notice Create three events
    
    /// @notice GameCreated - This event is called after a game is created. 
    /// @dev It must contain the address of the creator of the game, a unique unsigned integer gameNumber, 
    /// and the usigned integer size of the bet. 
    
    
    /// @notice GameStarted - This event is called after the valid participant joins the game. They will need to match
    /// the size of the bet.
    /// @dev The event will include an array containing the addresses of the two players (the creator and the participant) 
    /// as well as the gameNumber.
    

    /// @notice GameComplete - This event is called after both players have made their move and the outcome of the game has 
    /// been decided. 
    /// @dev It will contain the address of the winner (or the zero address in the event of a tie) as well as the gameNumber.
    

    /// @notice Game status
    enum Status {
        created,
        open,
        closed,
        finished
    }

    /// @notice Define a data type for the movements 'rock', 'paper', 'scissors' starting from index 1
    enum Movement {
        none
    }

    // State variables
    uint256 gameNumber;

    /// @notice Define a data structure called 'Game' with the necessary information for each game
    /// @dev You can remove field1;
    struct Game {
        address field1;
    }

    // State mapping
    mapping(uint256 => Game) public game;

    /// @notice This is a payable method that allows the creation of a new game. 
    /// @dev The creator will bet an amount of ethers for the game, otherwise revert with "You must make a bet"
    /// @dev When the game is won the winner will receive all bets
    /// @dev At the end of the operation the status for the game must be "created"
    /// @dev This method will call the GameCreated event if successful. 
    /// @param _contender Address of the allowed contender for the game. The address must be different that zero address
    /// otherwise revers with "Invalid address"
    function createGame(address _contender) external payable {
        
    }

    /// @notice This is a payable method that allows joining an existing game. 
    /// @dev Contender to join the game must send ether directly to the contract to match the bet of the game creator, otherwise 
    /// revert with "Invalid bet". If more ether is sent, the additional ether should be refunded and transferred back to the 
    /// contender's address. 
    /// @dev If the sender is not the whitelisted contender, revert with "Not authorized". 
    /// @dev The contestant should only be able to join the game once and under the status of "created", otherwise revert with
    /// "Game contenders are full".
    /// @dev At the end of the operation the status for the game must be "open"
    /// @dev This method will call the GameStarted event if successful.
    /// @param _gameNumber It is the number of the game to join. If is invalid revert with "Invalid _gameNumber" 
    function joinGame(uint256 _gameNumber) external payable {
        
    }

    /// @notice This method allows both players in the game to make their move
    /// @dev This method can only be called under the status of "open", otherwise revert with "Game not open"
    /// @dev This method can only be called once per player, otherwise revert with "Your move is already set"
    /// @dev Once both players have completed their move the game has to change to the status of "closed". Now both
    /// players must call the revealMove method 
    /// to reveal their moves
    /// @param _gameNumber It is the number of the game to join. If is invalid revert with "Invalid _gameNumber" 
    /// @param _movement It is a hash of the index number of the movement and a salt random number 
    function makeMove(uint256 _gameNumber, bytes32 _movement) external {
        
    }

    /// @notice Follow the traditional rules of the game to determine who has won
    /// @dev This function can only be called once the game is under the state of "closed", aka after both contestants have
    /// made their moves, otherwise revert with "Game not closed"
    /// @dev This function can only be called once per player, otherwise revert with "Your already reveal your movement"
    /// @dev Use _movement and _salt parameters to validate the hash received in the makeMove function for the corresponding
    /// player. In case of inconsistency revert with "Invalid movement"
    /// @dev If one of the contestants successfully reveals their move, the other contestant will have 3 blocks to reveal 
    /// their move or the first contestant may request to be declared the winner.
    /// @dev The amount of both bets should be transferred to the winner address. In the event of a tie, the winner 
    /// should be specified as the zero address (address(0)) and both bets should be evenly returned to the players.
    /// @dev Once the outcome of the game has been established, the game state should be set to "finished". In this state, 
    /// no more operations can be carried out on the game.
    /// @dev Event GameComplete should be called with the address of the winner.
    /// @param _gameNumber It is the number of the game to join. If is invalid revert with "Invalid _gameNumber" 
    /// @param _movement It is one of the valid movement in the movement list between 1 and 3. Otherwise revert with
    /// "Invalid movement"
    /// @param _salt It is the salt used to hash the movement. It is a non negative number.
    function revealMove(uint256 _gameNumber, Movement _movement, uint256 _salt) external {
        
    }
}