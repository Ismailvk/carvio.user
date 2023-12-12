import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:user_side/resources/components/button_widget.dart';
import 'package:user_side/resources/components/small_textformfield.dart';
import 'package:user_side/resources/constants/app_color.dart';
import 'package:user_side/views/home_screen/map_screen.dart';

// ignore: must_be_immutable
class AddVehicleScreen extends StatefulWidget {
  const AddVehicleScreen({super.key});

  @override
  State<AddVehicleScreen> createState() => _AddVehicleScreenState();
}

class _AddVehicleScreenState extends State<AddVehicleScreen> {
  List<DateTime?> cancellTapped = [
    DateTime.now(),
    DateTime.now(),
  ];

  List<DateTime?> rangeDatePickerValueWithDefaultValue = [
    DateTime.now(),
    DateTime.now(),
  ];
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  GlobalKey<FormState> calenderKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(right: 15, left: 15, top: 5),
          child: ListView(
            shrinkWrap: true,
            children: [
              const SizedBox(height: 5),
              const SizedBox(height: 15),
              //////calander/////////////////////////////////////////
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: CalendarDatePicker2WithActionButtons(
                  config: CalendarDatePicker2WithActionButtonsConfig(
                    firstDayOfWeek: 1,
                    calendarType: CalendarDatePicker2Type.range,
                    selectedDayTextStyle: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                    selectedDayHighlightColor: AppColors.primaryColor,
                    centerAlignModePicker: true,
                    customModePickerIcon: const SizedBox(),
                  ),
                  onCancelTapped: () {
                    rangeDatePickerValueWithDefaultValue = cancellTapped;
                  },
                  value: rangeDatePickerValueWithDefaultValue,
                  onValueChanged: (dates) {
                    setState(() {
                      rangeDatePickerValueWithDefaultValue = dates;
                      final formateStartDate = DateFormat('yyyy-MM-dd')
                          .format(rangeDatePickerValueWithDefaultValue[0]!);
                      final formateEndDate = DateFormat('yyyy-MM-dd')
                          .format(rangeDatePickerValueWithDefaultValue[1]!);
                      if (formateStartDate.isNotEmpty &&
                          formateEndDate.isNotEmpty) {
                        startDateController.text = formateStartDate;
                        endDateController.text = formateEndDate;
                      }
                    });
                  },
                ),
              ),
              const SizedBox(height: 15),
              Form(
                key: calenderKey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SmallTextFomField(
                        controller: startDateController,
                        hintText: 'Startin Date',
                        label: 'Starting Date'),
                    const SizedBox(width: 10),
                    SmallTextFomField(
                        controller: endDateController,
                        hintText: 'Ending Date',
                        label: 'Ending Date')
                  ],
                ),
              ),
              const SizedBox(height: 15),
              ButtonWidget(
                isColor: true,
                title: 'Choose Your Location',
                onPress: () {
                  calenderValidation();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  calenderValidation() {
    if (calenderKey.currentState!.validate()) {
      String startDate = startDateController.text;
      String endDate = endDateController.text;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => BookingMapScreen(
            startingDate: startDate,
            endingDate: endDate,
          ),
        ),
      );
    }
  }
}
