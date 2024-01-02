import 'package:flutter/material.dart';
import 'package:user_side/resources/constants/app_color.dart';
import 'package:user_side/resources/constants/app_fonts.dart';

class ActivEVehicleWidget extends StatelessWidget {
  const ActivEVehicleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double heigth = MediaQuery.sizeOf(context).height;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.lightGrey,
              border: Border.all(color: Colors.grey.shade300, width: 1)),
          height: heigth / 2.99,
          child: Column(children: [
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.black,
                    image: const DecorationImage(
                        image: NetworkImage(
                            "https://s2.dmcdn.net/v/PeZ891X-EzhhDOMdY/x1080"),
                        fit: BoxFit.cover)),
                height: heigth / 4.5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  height: heigth / 12,
                  width: MediaQuery.sizeOf(context).width / 1.7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("BMW", style: AppFonts.sansitaFont),
                      Text("₹ 2000", style: AppFonts.sansitaFontred),
                    ],
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 10, left: 20),
                    child: const Row(children: [
                      Icon(Icons.circle, color: Colors.green, size: 15),
                      SizedBox(width: 5),
                      Text("ACTIVE ")
                    ]))
              ],
            )
          ])),
    );
  }
}
