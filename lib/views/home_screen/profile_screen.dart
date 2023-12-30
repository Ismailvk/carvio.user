import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_side/blocs/user/user_bloc.dart';
import 'package:user_side/data/netword/api_urls.dart';
import 'package:user_side/resources/components/divider.dart';
import 'package:user_side/resources/components/profile_listtle_widget.dart';
import 'package:user_side/resources/constants/app_fonts.dart';
import 'package:user_side/views/settings_screen/settings_screen.dart';

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
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is FetchUserDataSuccessState) {
                  final image = state.userModel.profile;
                  return image == null
                      ? CircleAvatar(
                          radius: 45,
                          child: Image.asset('asset/images/user.png'),
                        )
                      : SizedBox(
                          height: MediaQuery.of(context).size.height / 9.5,
                          width: MediaQuery.of(context).size.width / 4.5,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: Image.network(
                              '${ApiUrls.baseUrl}/$image',
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                }
                return const SizedBox.shrink();
              },
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
          const ListTileWidget(
              imageString: 'asset/svg/user.svg', title: 'Profile'),
          const DivederWidget(),
          const ListTileWidget(
              imageString: 'asset/svg/key.svg', title: 'Privacy'),
          const DivederWidget(),
          const ListTileWidget(
              imageString: 'asset/svg/alert.svg', title: 'Help & info'),
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
