import 'package:flutter_bloc/flutter_bloc.dart';
import 'tic_tac_toe_event.dart';
import 'tic_tac_toe_state.dart';

class TicTacToeBloc extends Bloc<TicTacToeEvent, TicTacToeState> {
  TicTacToeBloc() : super(TicTacToeState.initial()) {
    on<CellTappedEvent>(_onCellTappedEvent);
    on<ResetGameEvent>(_onResetGameEvent);
  }

  void _onCellTappedEvent(CellTappedEvent event, Emitter<TicTacToeState> emit) {
    if (state.board[event.index] != '' || state.winner != null) return;

    final newBoard = List<String>.from(state.board);
    newBoard[event.index] = state.currentPlayer;

    final winResult = _checkWinner(newBoard);

    if (winResult != null) {
      emit(state.copyWith(
        board: newBoard,
        winner: state.currentPlayer,
        winLine: winResult,
      ));
    } else if (!newBoard.contains('')) {
      emit(state.copyWith(board: newBoard, isDraw: true));
    } else {
      emit(state.copyWith(
        board: newBoard,
        currentPlayer: state.currentPlayer == 'X' ? 'O' : 'X',
      ));
    }
  }

  void _onResetGameEvent(ResetGameEvent event, Emitter<TicTacToeState> emit) {
    emit(TicTacToeState.initial());
  }

  List<int>? _checkWinner(List<String> board) {
    final List<List<int>> winPatterns = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8],
      [0, 3, 6], [1, 4, 7], [2, 5, 8],
      [0, 4, 8], [2, 4, 6],
    ];

    for (final pattern in winPatterns) {
      final a = pattern[0], b = pattern[1], c = pattern[2];
      if (board[a] != '' && board[a] == board[b] && board[b] == board[c]) {
        return pattern;
      }
    }
    return null;
  }
}

