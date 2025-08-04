// part of 'tic_tac_toe_bloc.dart';
//
// @immutable
// sealed class TicTacToeEvent {}

abstract class TicTacToeEvent {}

class CellTappedEvent extends TicTacToeEvent {
  final int index;
  CellTappedEvent(this.index);
}

class ResetGameEvent extends TicTacToeEvent {}
