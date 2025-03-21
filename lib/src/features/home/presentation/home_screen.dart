import 'package:cipher_dove/src/features/home/presentation/components/home_appbar.dart';
import 'package:cipher_dove/src/features/home/presentation/components/home_textfield.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../common_widgets/generic_title.dart';
import '../../../constants/_constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GAP_H8,
            const GenericTitle(icon: Icons.input_outlined, title: "Input"),
            GAP_H8,
            const HomeTextfield(hintText: "Type here...", maxLines: 5),
            GAP_H24,
            ToggleSwitch(
              initialLabelIndex: 0,
              cornerRadius: 20.0,
              activeFgColor: Colors.white,
              inactiveBgColor: Colors.grey,
              inactiveFgColor: Colors.white,
              totalSwitches: 2,
              activeBgColors: [
                [Colors.black45, Colors.black26],
                [Colors.yellow, Colors.orange]
              ],
              animate: true,
              curve: Curves.bounceInOut,
              onToggle: (index) {
                print('switched to: $index');
              },
            ),
            GAP_H24,
            const GenericTitle(icon: Icons.output_outlined, title: "Output"),
            GAP_H8,
            const HomeTextfield(hintText: "Result here", maxLines: 5),
          ],
        ),
      ),
    );
  }
}
