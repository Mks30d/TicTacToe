class TicTacToeState {
  final List<String> board;
  final String currentPlayer;
  final String? winner;
  final bool isDraw;
  final List<int> winLine;

  TicTacToeState({
    required this.board,
    required this.currentPlayer,
    this.winner,
    this.isDraw = false,
    this.winLine = const [],
  });

  factory TicTacToeState.initial() {
    return TicTacToeState(board: List.filled(9, ''), currentPlayer: 'X');
  }

  TicTacToeState copyWith({
    List<String>? board,
    String? currentPlayer,
    String? winner,
    bool? isDraw,
    List<int>? winLine,
  }) {
    return TicTacToeState(
      board: board ?? this.board,
      currentPlayer: currentPlayer ?? this.currentPlayer,
      winner: winner,
      isDraw: isDraw ?? false,
      winLine: winLine ?? [],
    );
  }
}
