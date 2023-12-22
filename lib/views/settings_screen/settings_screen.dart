import 'package:flutter/material.dart';
import 'package:user_side/resources/components/backbutton_widget.dart';
import 'package:user_side/resources/components/divider.dart';
import 'package:user_side/resources/components/profile_listtle_widget.dart';
import 'package:user_side/resources/constants/app_fonts.dart';
import 'package:user_side/utils/show_dialogue.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Row(
            children: [
              const BackButtonWidget(),
              SizedBox(width: MediaQuery.of(context).size.width / 4),
              Text('Settings', style: AppFonts.appbarTitle)
            ],
          ),
          const SizedBox(height: 10),
          const ListTileWidget(
              imageString: 'asset/svg/user.svg', title: 'Edit Profile'),
          const DivederWidget(),
          const ListTileWidget(
              imageString: 'asset/svg/key.svg', title: 'Cange Password'),
          const DivederWidget(),
          GestureDetector(
            onTap: () => ShowDialogue.dialogue(context, Colors.red, 'Logout',
                'Do you want logout', () => null),
            child: const ListTileWidget(
              imageString: 'asset/svg/alert.svg',
              title: 'Logout',
              islogout: true,
            ),
          ),
        ],
      )),
    );
  }
}
