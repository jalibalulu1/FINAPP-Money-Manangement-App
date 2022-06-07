// ignore_for_file: invalid_use_of_protected_member

import 'package:bhandaram/categoryscreen.dart';
import 'package:bhandaram/models/category/category_model.dart';

import 'package:flutter/material.dart';

class RadioButton extends StatelessWidget {
  final String title;
  final Categorytype type;

  const RadioButton({Key? key, required this.title, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
            valueListenable: selectedCategoryNotifier,
            builder: (BuildContext ctx, Categorytype newCategory, Widget? _) {
              return Radio<Categorytype>(
                  value: type,
                  groupValue: newCategory,
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    selectedCategoryNotifier.value = value;
                    // ignore: invalid_use_of_visible_for_testing_member
                    selectedCategoryNotifier.notifyListeners();
                  });
            }),
        Text(title),
      ],
    );
  }
}
