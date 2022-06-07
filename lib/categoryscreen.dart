// ignore_for_file: unused_import, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:bhandaram/db/category/category_db.dart';
import 'package:bhandaram/models/category/category_model.dart';
import 'package:bhandaram/widgets/category_screen/expense_category.dart';
import 'package:bhandaram/widgets/category_screen/income_category_list.dart';
import 'package:bhandaram/widgets/category_screen/radiobutton.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

ValueNotifier<Categorytype> selectedCategoryNotifier =
    ValueNotifier(Categorytype.Income);

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    CategoryDB().refreshUI();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //  CategoryDB().refreshUI();
    //FocusManager.instance.primaryFocus?.unfocus();
    return SafeArea(
        child: Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xa84cc0a1), Color(0x4c7ab2c4)],
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(30),
              width: MediaQuery.of(context).size.width,
              height: 90,
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
                  "Add your Category",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.60,
                  ),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 4,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/moneysaving.png'),
                    fit: BoxFit.cover,
                  ),
                  shape: BoxShape.rectangle),
            ),
            TabBar(
              labelColor: const Color.fromARGB(255, 37, 138, 164),
              indicatorColor: const Color.fromARGB(255, 37, 138, 164),
              unselectedLabelColor: Colors.grey,
              labelStyle:
                  const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              tabs: const [
                Tab(
                  text: 'Income',
                ),
                Tab(
                  text: 'Expense',
                )
              ],
              controller: _tabController,
            ),
            Expanded(
              child: TabBarView(controller: _tabController, children: const [
                IncomeCategoryList(),
                ExpenseCategoryList(),
              ]),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showCategoryAddPopup(context);
          },
          child: const Icon(Icons.add),
          backgroundColor: const Color.fromARGB(255, 37, 138, 164)),
    ));
  }

  Future<void> showCategoryAddPopup(BuildContext context) async {
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
                    }
                    // ignore: duplicate_ignore
                    else {
                      final _type = selectedCategoryNotifier.value;
                      final _category = CategoryModel(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          name: _name,
                          type: _type);
                      await CategoryDB.instance.insertCategory(_category);

                      CategoryDB.instance.incomeCategoryListListener
                          .notifyListeners();
                      CategoryDB.instance.expenseCategoryListListener
                          .notifyListeners();
                      Navigator.of(ctx).pop();
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
