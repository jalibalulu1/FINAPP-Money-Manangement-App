// ignore_for_file: unused_element

import 'package:bhandaram/db/category/category_db.dart';
import 'package:bhandaram/models/category/category_model.dart';
import 'package:flutter/material.dart';

class EditDropDown extends StatefulWidget {
  const EditDropDown({Key? key}) : super(key: key);

  @override
  State<EditDropDown> createState() => _EditDropDownState();
}

CategoryModel? _selectedCategoryModel;
String? _categoryID;
Categorytype? _selectedCategorytype;

class _EditDropDownState extends State<EditDropDown> {
  @override
  Widget build(BuildContext context) {
    return Row(
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
            })
      ],
    );
  }
}
