import 'package:flutter/material.dart';
import 'package:money_management/db/category/category_db.dart';
import 'package:money_management/models/category/category_model.dart';
import 'package:money_management/screens/add%20transaction/add_transaction_screen.dart';
import 'package:money_management/screens/category/category_add_popup.dart';
import 'package:money_management/screens/category/category_screen.dart';
import 'package:money_management/screens/home/widgets/bottomNavigation.dart';
import 'package:money_management/screens/transactions/transaction_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);
  final _pages = [
    TransactionScreen(),
    CategoryScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: selectedIndexNotifier,
          builder: (BuildContext ctx, int updatedIndex, Widget? _) {
            return _pages[updatedIndex];
          },
        ),
      ),
      bottomNavigationBar: const MoneyManagementBottomNavigation(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          if (selectedIndexNotifier.value == 0) {
            print('add transaction');
            Navigator.of(context).pushNamed(AddTransactionScreen.routeName);
          } else {
            print('add category');
            // final _sample = CategoryModel(
            //     id: DateTime.now().millisecondsSinceEpoch.toString(),
            //     name: 'name',
            //     type: CategoryType.income);
            // CategoryDb().insertCategory(_sample);
            showCategoryAddPopup(context);
          }
        },
      ),
    );
  }
}
