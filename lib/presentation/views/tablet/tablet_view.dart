import 'package:flutter/material.dart';
import '../desktop/desktop_view.dart';

class TabletView extends StatelessWidget {
  const TabletView({super.key});

  @override
  Widget build(BuildContext context) {
    // For Tablet, we can reuse the DesktopView structure but perhaps with different proportions or slightly tweaked UI
    // The prompt specified Tablet (600 to 1024) follows the rail/split structure.
    return const DesktopView();
  }
}
