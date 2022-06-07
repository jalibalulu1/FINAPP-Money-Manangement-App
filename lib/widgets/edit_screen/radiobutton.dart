// ignore_for_file: unused_element

import 'package:bhandaram/models/category/category_model.dart';
import 'package:flutter/material.dart';

class EditRadioButton extends StatefulWidget {
  const EditRadioButton({Key? key}) : super(key: key);

  @override
  State<EditRadioButton> createState() => _EditRadioButtonState();
}

Categorytype? _selectedCategorytype;

String? _categoryID;

class _EditRadioButtonState extends State<EditRadioButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
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
                  _categoryID = null;

                  setState(() {
                    _selectedCategorytype = Categorytype.Expense;
                  });
                }),
            const Text('Expense')
          ],
        ),
      ],
    );
  }
}
