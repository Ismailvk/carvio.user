import 'package:flutter/material.dart';
import 'package:user_side/resources/constants/app_color.dart';

// ignore: must_be_immutable
class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final bool isSufix;
  TextInputType? number;
  final FormFieldValidator<String?>? validator;

  MyTextField({
    super.key,
    this.number,
    required this.isSufix,
    required this.validator,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minWidth: 100,
      ),
      child: TextFormField(
        validator: validator,
        keyboardType: number ?? TextInputType.text,
        controller: controller,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            suffixIcon: isSufix
                ? GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      Icons.visibility,
                      color: Colors.black,
                    ),
                  )
                : const SizedBox(),
            border: const OutlineInputBorder(
                borderSide: BorderSide(width: 5, color: AppColors.red)),
            label:
                Text(hintText, style: const TextStyle(color: AppColors.black)),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            fillColor: Colors.grey.shade200,
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[500])),
        // obscureText: obscuretext.value,
      ),
    );
  }
}
