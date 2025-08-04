import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/main.dart';
import '../bloc/tic_tac_toe_bloc.dart';
import '../bloc/tic_tac_toe_event.dart';
import '../bloc/tic_tac_toe_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _showEndDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: secondaryColor,
        titleTextStyle: TextStyle(color: Colors.white),
        title: const Text(
          'Game Over',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        content: Text(
          message,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.read<TicTacToeBloc>().add(ResetGameEvent());
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(11),
              ),
            ),
            child: const Text('Play Again'),
          ),
        ],
      ),
    );
  }
  
  Widget buildCell(TicTacToeState state){
    return GridView.builder(
      shrinkWrap: true,
      itemCount: 9,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemBuilder: (context, index) {
        final mark = state.board[index];
        final isWinningCell = state.winLine.contains(index);
        return GestureDetector(
          onTap: () => context.read<TicTacToeBloc>().add(
            CellTappedEvent(index),
          ),
          child: Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: isWinningCell ? Colors.green : primaryColor,
              // border: Border.all(),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                mark,
                style: TextStyle(
                  fontSize: 36,
                  color: mark == 'X' ? Colors.red : Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,

      appBar: AppBar(
        title: Center(
          child: const Text(
            'Tic Tac Toe',
            style: TextStyle(color: Colors.white),
          ),
        ),
        elevation: 7,
        shadowColor: primaryColor,
        backgroundColor: secondaryColor,
      ),
      body: BlocConsumer<TicTacToeBloc, TicTacToeState>(
        listenWhen: (previous, current) =>
            previous.winner != current.winner ||
            previous.isDraw != current.isDraw,
        listener: (context, state) {
          if (state.winner != null) {
            _showEndDialog(context, 'Player ${state.winner} wins!');
          } else if (state.isDraw) {
            _showEndDialog(context, 'It\'s a Draw!');
          }
        },
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                state.winner != null
                    ? 'Winner: ${state.winner}'
                    : state.isDraw
                    ? 'Draw!'
                    : 'Current Player: ${state.currentPlayer}',
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                margin: EdgeInsets.all(15),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: buildCell(state),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () =>
                    context.read<TicTacToeBloc>().add(ResetGameEvent()),
                child: const Text(
                  'Restart',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
