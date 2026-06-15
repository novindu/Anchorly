import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/index.dart';

/// goNamed replaces the stack — pop() often does nothing. Always offer a way home.
void navigateBackOrHome(BuildContext context) {
  if (context.canPop()) {
    context.pop();
  } else {
    context.goNamed(FamilyDashboardWidget.routeName);
  }
}

void navigateHome(BuildContext context) {
  context.goNamed(FamilyDashboardWidget.routeName);
}

/// Compact home control for page headers.
class HomeNavButton extends StatelessWidget {
  const HomeNavButton({super.key, this.showLabel = false});

  final bool showLabel;

  @override
  Widget build(BuildContext context) {
    if (showLabel) {
      return TextButton.icon(
        onPressed: () => navigateHome(context),
        icon: const Icon(Icons.home_rounded, size: 18),
        label: const Text('Home'),
      );
    }
    return IconButton(
      tooltip: 'Home',
      onPressed: () => navigateHome(context),
      icon: const Icon(Icons.home_rounded),
    );
  }
}