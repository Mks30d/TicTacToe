abstract class TicTacToeEvent {}

class CellTappedEvent extends TicTacToeEvent {
  final int index;
  CellTappedEvent(this.index);
}

class ResetGameEvent extends TicTacToeEvent {}
