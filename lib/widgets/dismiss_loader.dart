import 'package:flutter/material.dart';
import 'package:shoppe/core/constants/loader.dart';

class DismissLoader extends StatelessWidget {
  const DismissLoader({
    super.key,
    required this.child,
    this.onBack = _emptyCallback,
  });
  final Widget child;
  final VoidCallback onBack;

  static void _emptyCallback() {}
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        AppLoader.dismissLoader();
        onBack();
      },
      child: child,
    );
  }
}
