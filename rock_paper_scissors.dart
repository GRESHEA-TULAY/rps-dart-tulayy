
import 'dart:io';

final List<String> validMoves = <String>[
  'rock',
  'paper',
  'scissors',
];

/// Gets the player's name or uses a default name.
String getPlayerName(String defaultName) {
  stdout.write('Enter $defaultName name: ');
  String? input = stdin.readLineSync();

  String playerName = input?.trim() ?? '';

  if (playerName.isEmpty) {
    playerName = defaultName;
    print('No name entered. Using "$playerName".');
  }

  return playerName;
}

/// Returns a valid lowercase move or null if invalid.
String? validateMove(String? input) {
  String move = input?.trim().toLowerCase() ?? '';

  if (validMoves.contains(move)) {
    return move;
  }

  return null;
}

/// Repeats the prompt until the player enters a valid move.
String getMove(String playerName) {
  while (true) {
    stdout.write(
      '$playerName, enter your move (rock/paper/scissors): ',
    );

    String? input = stdin.readLineSync();
    String? move = validateMove(input);

    if (move != null) {
      return move;
    }

    print('Invalid move. Please type rock, paper, or scissors.');
  }
}

/// Returns the winning player's name or null for a draw.
String? decideWinner(
  String playerOneMove,
  String playerTwoMove,
  String playerOneName,
  String playerTwoName,
) {
  if (playerOneMove == playerTwoMove) {
    return null;
  }

  switch (playerOneMove) {
    case 'rock':
      return playerTwoMove == 'scissors'
          ? playerOneName
          : playerTwoName;
    case 'paper':
      return playerTwoMove == 'rock'
          ? playerOneName
          : playerTwoName;
    case 'scissors':
      return playerTwoMove == 'paper'
          ? playerOneName
          : playerTwoName;
    default:
      return null;
  }
}

/// Runs the game, updates scores, and displays the final result.
void main() {
  print('===== ROCK, PAPER, SCISSORS =====');

  String playerOneName = getPlayerName('Player 1');
  String playerTwoName = getPlayerName('Player 2');

  int playerOneScore = 0;
  int playerTwoScore = 0;
  int roundNumber = 1;
  String playAgain;

  do {
    print('\n--- Round $roundNumber ---');

    String playerOneMove = getMove(playerOneName);

    for (int line = 0; line < 30; line++) {
      print('');
    }

    String playerTwoMove = getMove(playerTwoName);

    print(
      '$playerOneName chose $playerOneMove. '
      '$playerTwoName chose $playerTwoMove.',
    );

    String? winner = decideWinner(
      playerOneMove,
      playerTwoMove,
      playerOneName,
      playerTwoName,
    );

    if (winner == null) {
      print('Result: ${winner ?? "It\'s a draw!"}');
    } else {
      print('Result: $winner wins the round!');

      if (winner == playerOneName) {
        playerOneScore++;
      } else {
        playerTwoScore++;
      }
    }

    print(
      'Score -> $playerOneName: $playerOneScore | '
      '$playerTwoName: $playerTwoScore',
    );

    stdout.write('Play again? (y/n): ');
    String? answer = stdin.readLineSync();
    playAgain = (answer ?? 'n').trim().toLowerCase();

    roundNumber++;
  } while (playAgain != 'n');

  print('\n===== FINAL SCORE =====');
  print(
    '$playerOneName: $playerOneScore | '
    '$playerTwoName: $playerTwoScore',
  );

  if (playerOneScore > playerTwoScore) {
    print('Overall winner: $playerOneName');
  } else if (playerTwoScore > playerOneScore) {
    print('Overall winner: $playerTwoName');
  } else {
    print('Overall result: It\'s a draw!');
  }
}
