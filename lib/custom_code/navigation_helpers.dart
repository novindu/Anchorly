import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '/flutter_flow/flutter_flow_theme.dart';
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
      tooltip: 'Dashboard',
      onPressed: () => navigateHome(context),
      icon: const Icon(Icons.home_rounded),
    );
  }
}

/// Full-width sticky footer — always visible at page bottom.
class DashboardBottomBar extends StatelessWidget {
  const DashboardBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.secondaryBackground,
        border: Border(
          top: BorderSide(color: theme.alternate, width: 1),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 16),
          child: SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton.icon(
              onPressed: () => navigateHome(context),
              icon: const Icon(Icons.dashboard_rounded, size: 20),
              label: Text(
                'Dashboard',
                style: GoogleFonts.sourceSans3(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primary,
                foregroundColor: theme.onPrimary,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}