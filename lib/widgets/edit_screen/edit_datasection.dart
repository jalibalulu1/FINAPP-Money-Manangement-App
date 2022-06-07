// ignore_for_file: must_be_immutable, unnecessary_null_comparison
import 'package:auto_size_text/auto_size_text.dart';
import 'package:bhandaram/db/category/category_db.dart';
import 'package:bhandaram/db/transactions/transaction_db.dart';
import 'package:bhandaram/models/category/category_model.dart';
import 'package:bhandaram/models/transactions/transaction_model.dart';
import 'package:bhandaram/widgets/homescreen/view_all.dart';
import 'package:flutter/material.dart';

class EditDataSection extends StatefulWidget {
  final double amount;
  final DateTime date;
  final Categorytype type;
  final CategoryModel category;
  String? id;
  static const routeName = 'add-transaction';
  EditDataSection(
      {Key? key,
      required this.date,
      required this.type,
      required this.category,
      required this.id,
      required this.amount})
      : super(key: key);

  @override
  State<EditDataSection> createState() => _EditDataSectionState();
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
String? amounts;
late String id;

class _EditDataSectionState extends State<EditDataSection> {
  @override
  void initState() {
    _selectedCategorytype = widget.type;
    _selectedCategoryModel = widget.category;

    selectedDate = widget.date;
    amounts = widget.amount.toString();

    id = widget.id!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xa84cc0a1), Color(0x4c7ab2c4)],
                  ),
                ),
                child: ListView(children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 90,
                    padding: const EdgeInsets.all(30),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xff43cea2), Color(0x4c185a9d)],
                      ),
                    ),
                    child: const SizedBox(
                      child: Text(
                        "Edit your Transaction",
                        textAlign: TextAlign.center,
                        // ignore: unnecessary_const
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.60,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
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
                                  child: TextField(
                                    onChanged: ((value) {
                                      amounts = value;
                                    }),
                                    decoration: InputDecoration(
                                      label: Text('$amounts'),
                                      labelStyle: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 34, 33, 33),
                                          fontSize: 18),
                                      enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black, width: 1.0)),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 1.0),
                                      ),
                                    ),
                                    keyboardType: TextInputType.number,
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
                                    color: const Color.fromARGB(
                                        255, 109, 149, 208),
                                  ),
                                  child: TextButton(
                                      onPressed: () {
                                        _selectDate(
                                            context); // To select the date when pressed on the textbutton
                                      },
                                      child: Text(
                                        "${selectedDate.day} ${months[selectedDate.month - 1]}",
                                        style: const TextStyle(
                                            fontSize: 14,
                                            color:
                                                Color.fromARGB(255, 0, 0, 0)),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Radio(
                                        value: Categorytype.Income,
                                        groupValue: _selectedCategorytype,
                                        onChanged: (newValue) {
                                          _categoryID = null;
                                          setState(() {
                                            _selectedCategorytype =
                                                Categorytype.Income;
                                          });
                                        }),
                                    const Text('Income')
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Radio(
                                        value: Categorytype.Expense,
                                        groupValue: _selectedCategorytype,
                                        onChanged: (newValue) {
                                          _categoryID = null;

                                          setState(() {
                                            _selectedCategorytype =
                                                Categorytype.Expense;
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
                                    items: (_selectedCategorytype ==
                                                Categorytype.Income
                                            ? CategoryDB.instance
                                                .incomeCategoryListListener
                                            : CategoryDB.instance
                                                .expenseCategoryListListener)
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
                                    })
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: SizedBox(
                                height: 50,
                                width: 220,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                        const Color.fromRGBO(12, 143, 186, 100),
                                      ),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18),
                                            side: const BorderSide(
                                                color: Colors.white)),
                                      )),
                                  onPressed: () {
                                    updateTransaction(context, amounts!);
                                  },
                                  child: const AutoSizeText(
                                    'Update Transactions',
                                    minFontSize: 8,
                                    maxFontSize: 20,
                                    maxLines: 1,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ))
                ]))));
  }

  _selectDate(BuildContext ctx) async {
    final DateTime? selected = await showDatePicker(
      context: ctx,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2080),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
      });
    }
  }
}

Future<void> updateTransaction(BuildContext context, String amt) async {
  // if (_amountText==null) {
  //   return;
  // }
  // final _parsedAmount = double.tryParse(_amountText);
  // if (_parsedAmount == null) {
  //   return;
  // }
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
      amount: double.tryParse(amt)!,
      date: selectedDate,
      type: _selectedCategorytype!,
      category: _selectedCategoryModel!,
      id: id);
  await TransactionDB.instance.updateTransaction(_model);
  _categoryID = null;
  selectedItem = 'All';
  Navigator.of(context).pop();
}
