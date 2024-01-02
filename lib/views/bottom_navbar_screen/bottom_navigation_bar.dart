import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_side/blocs/user/user_bloc.dart';
import 'package:user_side/data/shared_preference/shared_prefence.dart';
import 'package:user_side/models/user_model.dart';
import 'package:user_side/resources/constants/app_color.dart';
import 'package:user_side/views/home_screen/add_booking_screen.dart';
import 'package:user_side/views/home_screen/history_screen.dart';
import 'package:user_side/views/home_screen/home_screen.dart';
import 'package:user_side/views/home_screen/profile_screen.dart';

UserModel? globalUserModel;

// ignore: must_be_immutable
class ScreenParant extends StatefulWidget {
  const ScreenParant({super.key});

  @override
  State<ScreenParant> createState() => _ScreenParantState();
}

class _ScreenParantState extends State<ScreenParant> {
  int currentPage = 0;
  List<Widget> pages = [
    const HomeScreen(),
    const AddVehicleScreen(),
    const HistoryScreen(),
    const ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: pages[currentPage],
        ),
        Positioned(
          bottom: 10,
          left: 10,
          right: 10,
          child: NavBar(
            pageIndex: currentPage,
            ontap: (index) {
              final token = SharedPref.instance.getToke();
              if (index == 0) {
                context.read<UserBloc>().add(FetchBookingDataEvent());
              } else if (index == 2) {
                context.read<UserBloc>().add(FetchBookingDataEvent());
              } else if (index == 3) {
                context.read<UserBloc>().add(FetchUserDataEvent(token: token!));
              }
              setState(() {
                currentPage = index;
              });
            },
          ),
        )
      ],
    );
  }
}

class NavBar extends StatelessWidget {
  final int pageIndex;
  final Function(int) ontap;
  const NavBar({super.key, required this.pageIndex, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.primaryColor,
        ),
        height: 60,
        child: Row(
          children: [
            navItem(Icons.home, pageIndex == 0, ontap: () => ontap(0)),
            navItem(Icons.directions_car, pageIndex == 1,
                ontap: () => ontap(1)),
            navItem(Icons.history, pageIndex == 2, ontap: () => ontap(2)),
            navItem(Icons.person, pageIndex == 3, ontap: () => ontap(3)),
          ],
        ),
      ),
    );
  }

  Widget navItem(IconData icon, bool selected, {Function()? ontap}) {
    return Expanded(
        child: InkWell(
      onTap: ontap,
      child: Icon(icon,
          color: selected
              ? const Color.fromARGB(255, 255, 255, 255)
              : Colors.white.withOpacity(0.5)),
    ));
  }
}
