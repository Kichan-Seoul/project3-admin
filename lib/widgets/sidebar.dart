import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  final int selectedIndex;
  final void Function(int) onDestinationSelected;

  const Sidebar({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      labelType: NavigationRailLabelType.all,
      destinations: const [
        NavigationRailDestination(
          icon: Icon(Icons.dashboard),
          label: Text('대시보드'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.people),
          label: Text('유저관리'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.local_shipping),
          label: Text('화물관리'),
        ),
      ],
    );
  }
}