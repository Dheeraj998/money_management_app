import 'package:flutter/material.dart';
import 'package:money_management/db/category/category_db.dart';
import 'package:money_management/db/transaction/transaction_db.dart';
import 'package:money_management/models/category/category_model.dart';
import 'package:money_management/models/transaction/transaction_model.dart';

class AddTransactionScreen extends StatefulWidget {
  static const routeName = 'add-transaction';
  const AddTransactionScreen({Key? key}) : super(key: key);

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  DateTime? _selectedDate;
  CategoryType? _selectedCategoryType;
  CategoryModel? _selectedcategorymodel;
  String? _categoryID;
  final _purposeTextEditingController = TextEditingController();
  final _amountTextEditingController = TextEditingController();

  @override
  void initState() {
    _selectedCategoryType = CategoryType.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextFormField(
              controller: _purposeTextEditingController,
              decoration: InputDecoration(hintText: 'Purpose'),
            ),
            TextFormField(
              controller: _amountTextEditingController,
              decoration: InputDecoration(hintText: 'Amount'),
            ),
            TextButton.icon(
              onPressed: () async {
                final _selectedDateTemp = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now().subtract(
                    Duration(days: 30),
                  ),
                  lastDate: DateTime.now(),
                );
                if (_selectedDateTemp == null) {
                  return;
                } else {
                  print(_selectedDateTemp.toString());
                  setState(() {
                    _selectedDate = _selectedDateTemp;
                  });
                }
              },
              icon: Icon(Icons.calendar_today),
              label: Text(_selectedDate == null
                  ? 'select date'
                  : _selectedDate.toString()),
            ),
            Row(
              children: [
                Row(
                  children: [
                    Radio(
                        value: CategoryType.income,
                        groupValue: _selectedCategoryType,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedCategoryType = CategoryType.income;
                            _categoryID = null;
                          });
                        }),
                    Text('income'),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                        value: CategoryType.expense,
                        groupValue: _selectedCategoryType,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedCategoryType = CategoryType.expense;
                            _categoryID = null;
                          });
                        }),
                    Text('Expense'),
                  ],
                ),
              ],
            ),
            DropdownButton<String>(
              hint: Text('select category'),
              value: _categoryID,
              items: (_selectedCategoryType == CategoryType.income
                      ? CategoryDb.instance.incomeCategoryListListener
                      : CategoryDb.instance.incomeCategoryListListener)
                  .value
                  .map((e) {
                return DropdownMenuItem(
                  value: e.id,
                  child: Text(e.name),
                  onTap: () {
                    _selectedcategorymodel = e;
                  },
                );
              }).toList(),
              onChanged: (selectedvalue) {
                setState(() {
                  _categoryID = selectedvalue;
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                addTransaction();
              },
              child: Text('Add'),
            ),
          ],
        ),
      ),
    ));
  }

  Future<void> addTransaction() async {
    final _purposeText = _purposeTextEditingController.text;
    final _amountText = _amountTextEditingController.text;
    if (_purposeText.isEmpty) {
      return;
    }
    if (_amountText.isEmpty) {
      return;
    }
    if (_categoryID == null) {
      return;
    }
    if (_selectedDate == null) {
      return;
    }
    final _parsedAmount = double.tryParse(_amountText);
    if (_parsedAmount == null) {
      return;
    }
    if (_selectedcategorymodel == null) {
      return;
    }
    final _model = TransactionModel(
        purpose: _purposeText,
        amount: _parsedAmount,
        date: _selectedDate!,
        type: _selectedCategoryType!,
        category: _selectedcategorymodel!);
    await TransactionDB.instance.addTransactions(_model);
    Navigator.of(context).pop();
    TransactionDB.instance.refresh();
  }
}
