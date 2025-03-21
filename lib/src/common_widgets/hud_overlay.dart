// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hud_overlay.g.dart';

// Typical use case of the HUD overlay.
// SchedulerBinding.instance.addPostFrameCallback((_) {
//   operation();
//   ref.read(showHudOverlayProvider.notifier).show();
//   Timer(Duration(seconds: 5), () {
//     ref.read(showHudOverlayProvider.notifier).hide();
//   });
// });
@Riverpod(keepAlive: true)
class ShowHudOverlay extends _$ShowHudOverlay {
  @override
  bool build() => false;
  void show() => state = true;
  void hide() => state = false;
}

/// A Head-Up display overlay that aims to be lightweight by utilizing state management with riverpod, and lightweight
/// fade-in animation. This widget should be wrapped on top of a widget that needs to show the HUD overlay.
class HudOverlay extends StatelessWidget {
  const HudOverlay({
    super.key,
    required this.child,
  });

  final Widget child;

  // Not using get, to be easily configured if there's a need for parameter passing.
  Widget _showOverlayBackground() {
    return Center(
      child: Container(color: Colors.black.withAlpha(120)),
    );
  }

  // TODO Change this as needed.
  Widget _showOverlayContent() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // The content of the widget
        child,
        // Use StatefulBuilder as a Lightweight component.
        StatefulBuilder(
          builder: (context, setState) {
            /// Triggers the sizedBox widget return.
            bool shouldRender = false;

            return Consumer(
              builder: (context, ref, child) {
                final show = ref.watch(showHudOverlayProvider);
                const duration = Duration(milliseconds: 800);

                // Returns nothing when animation ends and show is false.
                if (!show && !shouldRender) return SizedBox.shrink();

                return IgnorePointer(
                  child: AnimatedOpacity(
                    opacity: (show) ? 1 : 0,
                    onEnd: () {
                      shouldRender = show;
                      if (!shouldRender) setState(() {});
                    },
                    duration: duration,
                    child: Stack(
                      children: [
                        _showOverlayBackground(),
                        _showOverlayContent(),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
