// ignore_for_file: prefer_const_constructors, invalid_use_of_visible_for_testing_member

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bhandaram/bottomnavigation.dart';
import 'package:bhandaram/categoryscreen.dart';
import 'package:bhandaram/db/category/category_db.dart';
import 'package:bhandaram/db/transactions/transaction_db.dart';
import 'package:bhandaram/models/category/category_model.dart';
import 'package:bhandaram/models/transactions/transaction_model.dart';
import 'package:bhandaram/widgets/category_screen/radiobutton.dart';
import 'package:flutter/material.dart';

class DataAddingSection extends StatefulWidget {
  const DataAddingSection({Key? key}) : super(key: key);
  @override
  State<DataAddingSection> createState() => _DataAddingSectionState();
}

DateTime selectedDate = DateTime.now();
List<String> months = [
  "Jan",
  "Feb",
  "Mar",
  "Apr",
  "May",
  "Jun",
  "Jul",
  "Aug",
  "Sep",
  "Oct",
  "Nov",
  "Dec"
];
Categorytype? _selectedCategorytype;
CategoryModel? _selectedCategoryModel;
String? _categoryID;

final _amountTextEditingController = TextEditingController();

class _DataAddingSectionState extends State<DataAddingSection> {
  @override
  void initState() {
    _selectedCategorytype = Categorytype.Income;
    CategoryDB.instance.refreshUI(); //new added text
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 1.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(41),
        border: Border.all(
          color: Colors.white,
          width: 1,
        ),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0x725590b1), Color(0x7c62b7b1)],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(38.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.account_balance_wallet_outlined,
                  color: Colors.black,
                  size: 32,
                ),
                const SizedBox(
                  width: 12.0,
                ),
                Expanded(
                  child: TextFormField(
                    controller: _amountTextEditingController,
                    decoration: const InputDecoration(
                      label: Text('Amount'),
                      labelStyle: TextStyle(
                          color: Color.fromARGB(255, 34, 33, 33), fontSize: 18),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 1.0)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                      ),
                    ),
                    // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Icon(
                  Icons.date_range_outlined,
                  size: 32,
                ),
                const SizedBox(
                  width: 15,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(255, 109, 149, 208),
                  ),
                  child: TextButton(
                      onPressed: () {
                        _selectDate(
                            context); // To select the date when pressed on the textbutton
                      },
                      child: Text(
                        "${selectedDate.day} ${months[selectedDate.month - 1]}",
                        style: const TextStyle(
                            fontSize: 14, color: Color.fromARGB(255, 0, 0, 0)),
                      )),
                )
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Radio(
                        value: Categorytype.Income,
                        groupValue: _selectedCategorytype,
                        onChanged: (newValue) {
                          _categoryID = null;
                          //  print('income :$_categoryID');
                          setState(() {
                            _selectedCategorytype = Categorytype.Income;
                          });
                        }),
                    const Text('Income')
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Radio(
                        value: Categorytype.Expense,
                        groupValue: _selectedCategorytype,
                        onChanged: (newValue) {
                          //  print('expense :$_categoryID');
                          _categoryID = null;
                          // print('afterexpense $_categoryID');
                          setState(() {
                            _selectedCategorytype = Categorytype.Expense;
                          });
                        }),
                    const Text('Expense')
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 0,
            ),
            Row(
              children: [
                const Icon(
                  Icons.category_outlined,
                  size: 32,
                ),
                const SizedBox(
                  width: 12,
                ),
                DropdownButton<String>(
                    hint: const Text(
                      'Select Category',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    value: _categoryID,
                    items: (_selectedCategorytype == Categorytype.Income
                            ? CategoryDB.instance.incomeCategoryListListener
                            : CategoryDB.instance.expenseCategoryListListener)
                        .value
                        .map((e) {
                      return DropdownMenuItem(
                        value: e.id,
                        child: Text(e.name),
                        onTap: () {
                          _selectedCategoryModel = e;
                        },
                      );
                    }).toList(),
                    onChanged: (selectedValue) {
                      _categoryID = null;

                      setState(() {
                        _categoryID = selectedValue;
                      });
                    }),
                Container(
                  padding: EdgeInsets.all(10),
                  child: IconButton(
                    onPressed: () {
                      showCategoryAddPopupPage(context);
                    },
                    icon: Icon(Icons.add),
                    color: Color.fromARGB(255, 35, 90, 148),
                    iconSize: 27,
                  ),
                )
              ],
            ),
            // const SizedBox(
            //   height: 10,
            // ),
            Center(
              child: SizedBox(
                height: 50,
                width: 220,
                child: ElevatedButton(
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      backgroundColor: MaterialStateProperty.all(
                        const Color.fromRGBO(12, 143, 186, 100),
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                            side: const BorderSide(color: Colors.white)),
                      )),
                  onPressed: () {
                    addTransaction(context);
                  },
                  child: const AutoSizeText(
                    'Add Transactions',
                    textAlign: TextAlign.center,
                    maxFontSize: 20,
                    minFontSize: 14,
                    maxLines: 1,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _selectDate(BuildContext ctx) async {
    final DateTime? selected = await showDatePicker(
      context: ctx,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime.now(),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
      });
    }
  }

  Future<void> showCategoryAddPopupPage(BuildContext context) async {
    final _formKey = GlobalKey<FormState>();
    final _nameEditingController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          title: const Text("Add Category"),
          titlePadding: const EdgeInsets.only(left: 80, top: 20),
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                maxLength: 13,
                key: _formKey,
                controller: _nameEditingController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.white, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'Category Name ',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(0),
              child: Row(
                children: const [
                  RadioButton(title: 'Income', type: Categorytype.Income),
                  RadioButton(title: 'Expense', type: Categorytype.Expense),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                  onPressed: () async {
                    final _name = _nameEditingController.text;
                    if (_name.isEmpty) {
                      return;
                    } else {
                      final _type = selectedCategoryNotifier.value;
                      final _category = CategoryModel(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          name: _name,
                          type: _type);
                      await CategoryDB.instance.insertCategory(_category);

                      // ignore: invalid_use_of_protected_member
                      CategoryDB.instance.incomeCategoryListListener
                          // ignore: invalid_use_of_protected_member
                          .notifyListeners();
                      // ignore: invalid_use_of_protected_member
                      CategoryDB.instance.expenseCategoryListListener
                          // ignore: invalid_use_of_protected_member
                          .notifyListeners();
                      Navigator.of(context).pop();
                      setState(() {});
                      // CategoryDB.instance.refreshUI();

                    }
                  },
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(color: Colors.white),
                    primary: const Color.fromRGBO(12, 143, 186, 100),
                    textStyle: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                  child: const Text('Add')),
            )
          ],
          backgroundColor: const Color.fromARGB(255, 153, 188, 215),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28.0),
          ),
        );
      },
    );
  }
}

Future<void> addTransaction(context) async {
  final _amountText = _amountTextEditingController.text;
  if (_amountText.isEmpty) {
    return;
  }
  final _parsedAmount = double.tryParse(_amountText);
  if (_parsedAmount == null) {
    return;
  }
  // ignore: unnecessary_null_comparison
  if (selectedDate == null) {
    return;
  }
  if (_categoryID == null) {
    return;
  }
  if (_selectedCategoryModel == null) {
    return;
  }
  final _model = TransactionModel(
      amount: _parsedAmount,
      date: selectedDate,
      type: _selectedCategorytype!,
      category: _selectedCategoryModel!,
      id: DateTime.now().microsecondsSinceEpoch.toString());
  await TransactionDB.instance.addTransaction(_model);

  _amountTextEditingController.clear();
  selectedDate = DateTime.now();

  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      duration: Duration(seconds: 1),
      backgroundColor: Colors.green,
      content: Padding(
        padding: EdgeInsets.all(10.0),
        child: Text(
          "You have added the transaction",
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
      )));
  Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => BottomNavigation()));
  _categoryID = null;
}
