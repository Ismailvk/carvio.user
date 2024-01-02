import 'package:flutter/material.dart';
import 'package:user_side/data/netword/api_urls.dart';
import 'package:user_side/resources/components/backbutton_widget.dart';
import 'package:user_side/resources/constants/app_color.dart';
import 'package:user_side/resources/constants/app_fonts.dart';
import 'package:user_side/views/bottom_navbar_screen/bottom_navigation_bar.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

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
                Text('Profile', style: AppFonts.appbarTitle)
              ],
            ),
            globalUserModel?.profile != null
                ? CircleAvatar(
                    radius: 60,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      height: MediaQuery.of(context).size.width / 3,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: Image.network(
                          '${ApiUrls.baseUrl}/${globalUserModel?.profile}',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )
                : CircleAvatar(
                    radius: 60,
                    backgroundColor: AppColors.red,
                    child: Image.asset(
                      'lib/image/user.png',
                      fit: BoxFit.fill,
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                readOnly: true,
                controller: TextEditingController(
                    text: globalUserModel?.name.toUpperCase()),
                style: TextStyle(color: Colors.grey.shade500),
                decoration: const InputDecoration(
                    labelStyle: TextStyle(color: AppColors.primaryColor),
                    label: Text('Full Name :')),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                readOnly: true,
                controller: TextEditingController(text: globalUserModel?.email),
                style: TextStyle(color: Colors.grey.shade500),
                decoration: const InputDecoration(
                    labelStyle: TextStyle(color: AppColors.primaryColor),
                    label: Text('Email :')),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                readOnly: true,
                controller: TextEditingController(
                    text: "+91 ${globalUserModel?.phone.toString()}"),
                style: TextStyle(color: Colors.grey.shade500),
                decoration: const InputDecoration(
                    labelStyle: TextStyle(color: AppColors.primaryColor),
                    label: Text('Phone Number :')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
