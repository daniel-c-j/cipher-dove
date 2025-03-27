import 'package:cipher_dove/src/core/_core.dart';
import 'package:flutter_test/flutter_test.dart';

import 'src/features/home/home_robot.dart';

class Robot {
  Robot(this.tester) : home = HomeRobot(tester);

  final WidgetTester tester;
  final HomeRobot home;

  Future<void> pumpApp() async {
    const appStartup = AppStartup();
    final container = await appStartup.initializeProviderContainer();
    final root = await appStartup.createRootWidget(container: container);

    // * Entry point of the app
    await tester.pumpWidget(root);
    await tester.pumpAndSettle();
  }
}
