import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:user_side/resources/constants/app_color.dart';
import 'package:user_side/resources/constants/app_fonts.dart';
import 'package:user_side/views/vehicle_screen/upcoming_booking.dart';
import 'package:user_side/views/vehicle_screen/completed_booking.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _VehicleListScreenState();
}

class _VehicleListScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'History',
          style: AppFonts.appbarSansitaFont,
        ),
      ),
      body: SafeArea(
        child: ContainedTabBarView(
          tabBarProperties: const TabBarProperties(
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: AppColors.darkGreen,
            labelColor: Colors.black,
            indicatorWeight: 5,
            padding: EdgeInsets.symmetric(horizontal: 10),
            unselectedLabelColor: Colors.grey,
          ),
          tabs: [
            Text('Completed Booking', style: AppFonts.sansitaFont),
            Text('Upcoming Booking', style: AppFonts.sansitaFont),
          ],
          views: [
            const CompletedBooking(),
            UpcomingBooking(),
          ],
        ),
      ),
    );
  }
}
