import 'package:flutter/material.dart';

// ignore: must_be_immutable
class OtpTexfield extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  final FormFieldValidator<String?>? validator;

  OtpTexfield({super.key, required this.controller, required this.validator});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 50,
      child: TextFormField(
        validator: validator,
        controller: controller,
        autofocus: true,
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            errorStyle: const TextStyle(fontSize: 0.01),
            isDense: true,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            counterText: ""),
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
