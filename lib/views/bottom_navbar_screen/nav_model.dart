import 'package:flutter/material.dart';

class NavModal {
  final Widget page;
  final GlobalKey<NavigatorState> navKey;
  NavModal({required this.page, required this.navKey});
}
