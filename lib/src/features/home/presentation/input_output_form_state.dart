import 'package:cipher_dove/src/util/notifier_mounted.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'input_output_form_state.g.dart';

@riverpod
class InputTextFormState extends _$InputTextFormState with NotifierMounted {
  @override
  TextEditingController build() {
    ref.onDispose(() {
      state.dispose();
      setUnmounted();
    });

    return TextEditingController();
  }
}

@riverpod
class InputPasswordTextFormState extends _$InputPasswordTextFormState with NotifierMounted {
  @override
  TextEditingController build() {
    ref.onDispose(() {
      state.dispose();
      setUnmounted();
    });

    return TextEditingController();
  }
}

@Riverpod(keepAlive: true)
class OutputTextFormState extends _$OutputTextFormState with NotifierMounted {
  @override
  TextEditingController build() {
    ref.onDispose(() {
      state.dispose();
      setUnmounted();
    });

    return TextEditingController();
  }

  void text(String newState) {
    if (!mounted) return;
    state = TextEditingController(text: newState);
  }

  void clear() {
    if (!mounted) return;
    state = TextEditingController(text: "");
  }
}
