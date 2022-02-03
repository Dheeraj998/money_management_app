import 'package:flutter/material.dart';

import 'package:money_management/screens/home/home_screen.dart';

class MoneyManagementBottomNavigation extends StatelessWidget {
  const MoneyManagementBottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: HomeScreen.selectedIndexNotifier,
      builder: (BuildContext ctx, int updatedIndex, Widget? _) {
        return BottomNavigationBar(
            currentIndex: updatedIndex,
            onTap: (newIndex) {
              HomeScreen.selectedIndexNotifier.value = newIndex;
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: 'Transaction'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.category), label: 'category'),
            ]);
      },
    );
  }
}
