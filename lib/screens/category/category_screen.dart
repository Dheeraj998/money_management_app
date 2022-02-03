import 'package:flutter/material.dart';

import 'package:money_management/db/category/category_db.dart';
import 'package:money_management/screens/category/expense_category_list.dart';
import 'package:money_management/screens/category/income_category_list.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    CategoryDb().refreshUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TabBar(
              controller: tabController,
              tabs: const [
                Tab(
                  text: 'INCOME',
                ),
                Tab(
                  text: 'EXPENSE',
                ),
              ],
            ),
            Expanded(
              child: TabBarView(controller: tabController, children: const [
                IncomeCategoryList(),
                ExpenseCategoryList(),
              ]),
            )
          ],
        ),
      ),
    );
  }
}


// class MyStatefulWidget extends StatefulWidget {
//   const MyStatefulWidget({Key? key}) : super(key: key);

//   @override
//   State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
// }

// /// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
// class _MyStatefulWidgetState extends State<MyStatefulWidget>
//     with TickerProviderStateMixin {
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('TabBar Widget'),
//         bottom: TabBar(
//           controller: _tabController,
//           tabs: const <Widget>[
//             Tab(
//               icon: Icon(Icons.cloud_outlined),
//             ),
//             Tab(
//               icon: Icon(Icons.beach_access_sharp),
//             ),
//             Tab(
//               icon: Icon(Icons.brightness_5_sharp),
//             ),
//           ],
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: const <Widget>[
//           Center(
//             child: Text("It's cloudy here"),
//           ),
//           Center(
//             child: Text("It's rainy here"),
//           ),
//           Center(
//             child: Text("It's sunny here"),
//           ),
//         ],
//       ),
//     );
//   }
// }
