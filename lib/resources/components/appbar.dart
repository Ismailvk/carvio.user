import 'package:flutter/material.dart';
import 'package:user_side/resources/components/hind_widget.dart';

class AppbarBckbutton extends StatelessWidget {
  final String text;
  const AppbarBckbutton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(90),
      child: SafeArea(
        child: ListTile(
          titleAlignment: ListTileTitleAlignment.center,
          leading: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
            ),
          ),
          title: HindTextWidget(
              isBold: true,
              text: text,
              size: 20,
              color: Colors.black,
              left: 50,
              top: 0),
        ),
      ),
    );
  }
}
