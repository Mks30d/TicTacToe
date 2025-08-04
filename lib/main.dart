import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/ui/home_screen.dart';
import 'bloc/tic_tac_toe_bloc.dart';

Color primaryColor = Color(0xff232C46);
Color secondaryColor = Color(0xff404F6C);
Color whiteColor = Color(0xffffffff);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      // theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => TicTacToeBloc(),
        child: const HomeScreen(),
      ),
    );
  }
}

