import 'package:flutter/material.dart';
import 'package:user_side/models/car_model.dart';
import 'package:user_side/views/top_brand/vehicle_list.dart';

// ignore: must_be_immutable
class TopBrandsWidget extends StatelessWidget {
  List<CarModel>? carmodel;
  TopBrandsWidget({super.key, required this.carmodel});

  @override
  Widget build(BuildContext context) {
    List<String> brandLogos = [
      "asset/images/benz_logo.jpeg",
      "asset/images/bmw_logo.jpeg",
      "asset/images/lambo_logo.jpeg",
      "asset/images/nissan_logo.jpeg",
    ];
    double heigth = MediaQuery.sizeOf(context).height;
    return Container(
      margin: const EdgeInsets.only(left: 12, right: 15),
      height: heigth / 9,
      width: double.infinity,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            List<List<CarModel>> data = [
              carmodel!.where((element) => element.brand == 'benz').toList(),
              carmodel!.where((element) => element.brand == 'bmw').toList(),
              carmodel!
                  .where((element) => element.brand == 'lamborgini')
                  .toList(),
              carmodel!.where((element) => element.brand == 'nissan').toList(),
            ];
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        TopBrandVehicleList(carmodel: data[index])));
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade300, width: 1)),
                width: MediaQuery.sizeOf(context).width / 4.6,
                child: Center(
                  child: Image.asset(brandLogos[index]),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(width: 8),
          itemCount: 4),
    );
  }
}
