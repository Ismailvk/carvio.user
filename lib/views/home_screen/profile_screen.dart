import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_side/blocs/user/user_bloc.dart';
import 'package:user_side/data/netword/api_urls.dart';
import 'package:user_side/resources/components/divider.dart';
import 'package:user_side/resources/components/profile_listtle_widget.dart';
import 'package:user_side/resources/constants/app_fonts.dart';
import 'package:user_side/views/bottom_navbar_screen/bottom_navigation_bar.dart';
import 'package:user_side/views/profile_screen/profile_screen.dart';
import 'package:user_side/views/settings_screen/settings_screen.dart';
import 'package:user_side/views/wallet_screen/wallet_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Profile', style: AppFonts.appbarTitle),
          elevation: 0,
          centerTitle: true),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 10),
            alignment: Alignment.topCenter,
            child: globalUserModel?.profile != null
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
                    child: Image.asset('asset/images/user copy.png',
                        fit: BoxFit.fill),
                  ),
          ),
          const SizedBox(height: 5),
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is FetchUserDataSuccessState) {
                final data = state.userModel;
                return Text(data.name.toUpperCase(),
                    style: AppFonts.sansitaFont);
              }
              return const SizedBox.shrink();
            },
          ),
          const SizedBox(height: 5),
          GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const MyProfileScreen())),
            child: const ListTileWidget(
                imageString: 'asset/svg/user.svg', title: 'Profile'),
          ),
          const DivederWidget(),
          const ListTileWidget(
              imageString: 'asset/svg/key.svg', title: 'Privacy'),
          const DivederWidget(),
          const ListTileWidget(
              imageString: 'asset/svg/alert.svg', title: 'Help & info'),
          const DivederWidget(),
          GestureDetector(
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const WalletScreen())),
            child: const ListTileWidget(
                imageString: 'asset/svg/wallet-fill.svg', title: 'Wallet'),
          ),
          const DivederWidget(),
          GestureDetector(
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const SettingScreen())),
            child: const ListTileWidget(
                imageString: 'asset/svg/settings.svg', title: 'Settings'),
          ),
        ],
      ),
    );
  }
}
