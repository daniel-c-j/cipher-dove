import 'package:cipher_dove/src/features/cipher/presentation/components/cipher_action_switch.dart';
import 'package:cipher_dove/src/features/cipher/presentation/components/algorithm_selected.dart';
import 'package:cipher_dove/src/features/cipher/presentation/components/process_button.dart';
import 'package:cipher_dove/src/features/home/presentation/components/home_appbar.dart';
import 'package:cipher_dove/src/features/home/presentation/components/home_screen_input.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';

import '../../../constants/_constants.dart';
import 'components/home_screen_output.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: HomeAppBar(),
      body: DoubleBackToCloseApp(
        snackBar: SnackBar(
          content: Text("Tap again to exit."),
          dismissDirection: DismissDirection.horizontal,
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GAP_H8,
              HomeScreenInput(),
              GAP_H32,
              CipherActionSwitch(),
              GAP_H12,
              Row(children: [AlgorithmSelected(), Spacer(), ProcessButton()]),
              GAP_H32,
              HomeScreenOutput(),
              GAP_H8,
            ],
          ),
        ),
      ),
    );
  }
}
