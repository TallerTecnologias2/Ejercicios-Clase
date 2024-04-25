 //SPDX-License-Identifier:MIT
pragma solidity 0.8.9;

/**
 * @notice ¡Juguemos a piedra, papel o tijera en la cadena de bloques!
 */
contract Rock_Paper_Scissor {

    /// @notice Cree tres eventos
    
    /// @notice GameCreated: Este evento se llama después de crear un juego.
    /// @dev Debe contener la dirección del creador del juego, un entero único sin signo gameNumber,
    /// y un entero sin signo para el tamaño de apuesta.
    
    
    /// @notice GameStarted: Este evento se llama después de que los participante se unen al juego. Deben coincidir
    /// en el tamaño de la apuesta.
    /// @dev El evento incluirá una matriz que contiene las direcciones de los dos jugadores (el creador y el participante)
    /// así como el gameNumber.
    

    /// @notice GameComplete: Este evento se llama después de que ambos jugadores hayan hecho sus movimiento y el resultado del juego
    /// se ha decidido.
    /// @dev Contendrá la dirección del ganador (o la dirección cero en caso de empate) así como el número del juego.
    

    /// @notice Estados del juego
    enum Status {
        created,
        open,
        closed,
        finished
    }

    /// @notice Defina un tipo de datos para los movimientos 'piedra', 'papel', 'tijera' a partir del índice 1
    enum Movement {
        none
    }

    // Variables de estado
    uint256 gameNumber;

    /// @notice Definir una estructura de datos llamada 'Game' con la información necesaria para cada juego
    /// @dev Puede eliminar el campo field1;
    struct Game {
        address field1;
    }

    // State mapping
    mapping(uint256 => Game) public game;

    /// @notice Este es un método de pago que permite la creación de un nuevo juego.
    /// @dev El creador apostará una cantidad de éteres para el juego, de lo contrario revierte con "You must make a bet"
    /// @dev Cuando se gane el juego, el ganador recibirá todas las apuestas.
    /// @dev Al final de esta operación, el estado del juego debe ser "created"
    /// @dev Este método llamará al evento GameCreated en caso de éxito. 
    /// @param _contender Dirección del contendiente permitido para el juego. La dirección debe ser diferente a la dirección cero
    /// de lo contrario revertir con "Invalid address"
    function createGame(address _contender) external payable {
        
    }

    /// @notice Este es un método de pago que permite unirse a un juego existente.
    /// @dev El contendiente para unirse al juego debe enviar ether directamente al contrato para igualar la apuesta del creador 
    /// del juego, de lo contrario revertir con "Invalid bet". Si se envía más ethers, el ether adicional debe reembolsarse y 
    /// transferirse de vuelta a la dirección del contendiente.
    /// @dev Si el remitente no es el contendiente incluido en la lista blanca, revierte con "Not authorized". 
    /// @dev El concursante solo debe poder unirse al juego una vez y bajo el estado de "created", de lo contrario revertir con
    /// "Game contenders are full".
    /// @dev Al final de la operación, el estado del juego debe ser "open"
    /// @dev Este método llamará al evento GameStarted en caso de éxito.
    /// @param _gameNumber Es el número del juego a unirse. Si no es válido, revertir con "Invalid _gameNumber" 
    function joinGame(uint256 _gameNumber) external payable {
        
    }

    /// @notice Este método permite que ambos jugadores en el juego hagan su movimiento
    /// @dev Este método solo se puede llamar bajo el estado "abierto", de lo contrario, revierte con "Game not open"
    /// @dev Este método solo se puede llamar una vez por jugador, de lo contrario, revierte con "Your move is already set"
    /// @dev Una vez que ambos jugadores hayan completado su movimiento, el juego debe cambiar al estado "closed". ahora ambos
    /// jugadores deben llamar al método revelarMove para revelar sus movimientos
    /// @param _gameNumber Es el número del juego a unirse. Si no es válido, revertir con "Invalid _gameNumber"
    /// @param _movement Es un hash del número índice del movimiento y un número aleatorio salt
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

    /// @notice Siga las reglas tradicionales del juego para determinar quién ha ganado
    /// @dev Esta función solo se puede llamar una vez que el juego está en estado "closed", es decir, después de que ambos 
    /// concursantes hayan hecho sus movimientos, de lo contrario revierte con "Game not closed"
    /// @dev Esta función solo se puede llamar una vez por jugador, de lo contrario, revierte con "Your already reveal your movement"
    /// @dev Usa los parámetros _movement y _salt para validar el hash recibido en la función makeMove para el correspondiente
    /// jugador. En caso de inconsistencia revertir con "Invalid movement"
    /// @dev Si uno de los concursantes revela con éxito su movimiento, el otro concursante tendrá 3 bloques para revelar
    /// su movimiento o el primer competidor puede solicitar ser declarado ganador.
    /// @dev El monto de ambas apuestas debe transferirse a la dirección del ganador. En caso de empate, el ganador
    /// debe especificarse como la dirección cero (dirección (0)) y ambas apuestas deben devolverse equitativamente a los jugadores.
    /// @dev Una vez que se ha establecido el resultado del juego, el estado del juego debe establecerse en "terminado". En este 
    /// estado, no se pueden realizar más operaciones en el juego.
    /// @dev Debe llamarse al evento GameComplete con la dirección del ganador.
    /// @param _gameNumber Es el número del juego a unirse. Si no es válido, revertir con "Invalid _gameNumber"
    /// @param _movement Es uno de los movimientos válidos en la lista de movimientos entre 1 y 3. De lo contrario, revertir con
    /// "Invalid movement"
    /// @param _salt Es un número salt usado para hashear del movimiento. Es un número no negativo.
    function revealMove(uint256 _gameNumber, Movement _movement, uint256 _salt) external {
        
    }
}