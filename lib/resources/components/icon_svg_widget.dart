import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconSvg extends StatelessWidget {
  final String name;
  final Color? color;
  const IconSvg({super.key, required this.name, this.color});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(name,
        // ignore: deprecated_member_use
        color: color ?? Colors.grey.shade600,
        height: 18,
        width: 18);
  }
}
