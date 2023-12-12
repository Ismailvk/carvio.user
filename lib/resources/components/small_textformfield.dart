import 'package:flutter/material.dart';
import 'package:user_side/resources/constants/app_color.dart';

// ignore: must_be_immutable
class SmallTextFomField extends StatelessWidget {
  TextEditingController controller;
  String label;
  String hintText;

  SmallTextFomField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2.3,
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
        readOnly: true,
        controller: controller,
        decoration: InputDecoration(
            hintText: hintText,
            label: Text(label),
            disabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.primaryColor)),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.primaryColor)),
            border: const OutlineInputBorder()),
      ),
    );
  }
}
