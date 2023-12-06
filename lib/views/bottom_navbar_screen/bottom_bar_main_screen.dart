import 'package:flutter/material.dart';
import 'package:user_side/views/bottom_navbar_screen/nav_model.dart';
import 'package:user_side/views/bottom_navbar_screen/navbar.dart';
import 'package:user_side/views/home_screen/add_booking_screen.dart';
import 'package:user_side/views/home_screen/history_screen.dart';
import 'package:user_side/views/home_screen/home_screen.dart';
import 'package:user_side/views/home_screen/profile_screen.dart';

class CoustomNavBar extends StatefulWidget {
  const CoustomNavBar({super.key});
  @override
  State<CoustomNavBar> createState() => _MainScreeeenState();
}

class _MainScreeeenState extends State<CoustomNavBar> {
  final homeNavKey = GlobalKey<NavigatorState>();
  final carNavKey = GlobalKey<NavigatorState>();
  final historyNavKey = GlobalKey<NavigatorState>();
  final profileNavKey = GlobalKey<NavigatorState>();
  int selectTab = 0;
  List<NavModal> items = [];
  @override
  void initState() {
    items = [
      NavModal(page: const HomeScreen(), navKey: homeNavKey),
      NavModal(page: AddVehicleScreen(), navKey: carNavKey),
      NavModal(page: const HistoryScreen(), navKey: historyNavKey),
      NavModal(page: const ProfileScreen(), navKey: profileNavKey),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (items[selectTab].navKey.currentState?.canPop() ?? false) {
          {
            items[selectTab].navKey.currentState?.pop();
            return Future.value(false);
          }
        } else {
          return Future.value(true);
        }
      },
      child: Stack(
        children: [
          Scaffold(
            // extendBody: true,
            body: IndexedStack(
              index: selectTab,
              children: items
                  .map((page) => Navigator(
                        key: page.navKey,
                        onGenerateInitialRoutes: (navigator, initialRoute) {
                          return [
                            MaterialPageRoute(builder: (context) => page.page)
                          ];
                        },
                      ))
                  .toList(),
            ),
            // floatingActionButtonLocation:
            //     FloatingActionButtonLocation.endFloat,
            // floatingActionButton: selectTab == 1
            //     ? Container(
            //         margin: const EdgeInsets.only(bottom: 100),
            //         height: 64,
            //         width: 64,
            //         child: FloatingActionButton(
            //           shape: RoundedRectangleBorder(
            //               side: BorderSide(width: 3, color: deepPurple),
            //               borderRadius: BorderRadius.circular(100)),
            //           onPressed: () => Get.to(AddVehicle()),
            //           backgroundColor: Colors.white,
            //           elevation: 0,
            //           child: const Icon(Icons.add, color: Colors.black),
            //         ),
            //       )
            // : const SizedBox()
          ),
          Positioned(
            bottom: 10,
            left: 10,
            right: 10,
            child: NavBar(
              pageIndex: selectTab,
              ontap: (index) {
                if (index == selectTab) {
                  items[index]
                      .navKey
                      .currentState
                      ?.popUntil((route) => route.isFirst);
                } else {
                  setState(() {
                    selectTab = index;
                  });
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
