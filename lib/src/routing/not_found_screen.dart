import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:cipher_dove/src/routing/app_router.dart';
import 'package:cipher_dove/src/util/delay.dart';

/// Simple not found screen used for 404 errors (page not found on web)
class NotFoundScreen extends StatefulWidget {
  const NotFoundScreen({super.key});

  @override
  State<NotFoundScreen> createState() => _NotFoundScreenState();
}

class _NotFoundScreenState extends State<NotFoundScreen> {
  @override
  void initState() {
    super.initState();

    // After widget builds, and 2 seconds afterward, user will be redirected to the home page.
    SchedulerBinding.instance.addPostFrameCallback((_) {
      // ignore: use_build_context_synchronously
      delay(true, 3000).then((_) => context.goNamed(AppRoute.home.name));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.black,
                height: 50,
                width: 120,
              ),
              Text(
                '404 - Page not found!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Redirecting to home page...',
              ),
            ],
          ),
        ),
      ),
    );
    // TODO better UI
  }
}
