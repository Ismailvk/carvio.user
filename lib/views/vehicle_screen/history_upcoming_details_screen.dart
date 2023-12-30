import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:user_side/blocs/payment/payment_bloc.dart';
import 'package:user_side/data/netword/api_urls.dart';
import 'package:user_side/models/booking_model.dart';
import 'package:user_side/resources/components/backbutton_widget.dart';
import 'package:user_side/resources/components/button_widget.dart';
import 'package:user_side/resources/components/divider.dart';
import 'package:user_side/resources/components/row_text_widget.dart';
import 'package:user_side/resources/components/small_car_card_widget.dart';
import 'package:user_side/resources/components/sub_title_widget.dart';
import 'package:user_side/resources/constants/app_color.dart';
import 'package:user_side/resources/constants/app_fonts.dart';
import 'package:user_side/utils/custom_snackbar.dart';
import 'package:user_side/utils/validation.dart';
import 'package:user_side/views/bottom_navbar_screen/bottom_navigation_bar.dart';

class HistoryUpcomingDetailsScreen extends StatefulWidget {
  final BookingModel bookingData;
  const HistoryUpcomingDetailsScreen({super.key, required this.bookingData});

  @override
  State<HistoryUpcomingDetailsScreen> createState() =>
      _HistoryUpcomingDetailsScreenState();
}

class _HistoryUpcomingDetailsScreenState
    extends State<HistoryUpcomingDetailsScreen> {
  int activeIndex = 0;
  TextEditingController refundController = TextEditingController();
  GlobalKey<FormState> refundKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final dpadding = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
                child: CarouselSlider(
                  items: widget.bookingData.vehicle.images
                      .map((e) => Image.network(
                            '${ApiUrls.baseUrl}/$e',
                            fit: BoxFit.fill,
                          ))
                      .toList(),
                  options: CarouselOptions(
                    onPageChanged: (index, reason) =>
                        setState(() => activeIndex = index),
                    viewportFraction: 1,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: dpadding),
                child: const BackButtonWidget(),
              ),
              Positioned(
                bottom: 5,
                left: MediaQuery.of(context).size.width / 2.5,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: AnimatedSmoothIndicator(
                      effect: const WormEffect(
                          activeDotColor: Colors.teal,
                          dotHeight: 7,
                          dotWidth: 7),
                      activeIndex: activeIndex,
                      count: widget.bookingData.vehicle.images.length),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SubTitleWidget(
                    title:
                        "${widget.bookingData.vehicle.brand.toUpperCase()}  ${widget.bookingData.vehicle.name.toUpperCase()}",
                    fontsize: 18),
                Text(widget.bookingData.total.toString(),
                    style: AppFonts.sansitaFontred)
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SmallCarCardWidget(
                  name: widget.bookingData.vehicle.transmission,
                  asset: 'asset/svg/steering-wheel.svg'),
              SmallCarCardWidget(
                  name: widget.bookingData.vehicle.model.toString(),
                  asset: "asset/svg/settings.svg"),
              SmallCarCardWidget(
                  name: widget.bookingData.vehicle.fuel,
                  asset: "asset/svg/petrol.svg"),
              SmallCarCardWidget(
                  name: widget.bookingData.vehicle.location,
                  asset: "asset/svg/location-outline.svg")
            ],
          ),
          const SizedBox(height: 15),
          Rowwidget(heading: 'STATUS', data: widget.bookingData.status),
          Rowwidget(
              heading: 'STARTING DATE', data: widget.bookingData.startDate),
          Rowwidget(heading: 'ENDING DATE', data: widget.bookingData.endDate),
          Rowwidget(
              heading: 'PICKUP LOCATION', data: widget.bookingData.pickup),
          Rowwidget(
              heading: 'DROPOFF LOCATION', data: widget.bookingData.dropoff),
          const DivederWidget(),
          Rowwidget(
              heading: 'GRAND TOTAL',
              data: widget.bookingData.grandTotal.toString()),
          SizedBox(height: MediaQuery.of(context).size.height / 14),
          Container(
              alignment: Alignment.center,
              child: widget.bookingData.status == 'Booked'
                  ? ButtonWidget(
                      title: 'Refund Your Amount',
                      onPress: () => {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: MediaQuery.of(context).size.height / 2.5,
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Write your reason for refund',
                                    style: AppFonts.popinsHeading,
                                  ),
                                  const SizedBox(height: 16.0),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Form(
                                      key: refundKey,
                                      child: TextFormField(
                                        validator: (value) =>
                                            Validation.isEmpty(value, "Reason"),
                                        controller: refundController,
                                        maxLines: 5,
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.all(10.0),
                                          hintText: 'Enter your reason here...',
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  BlocConsumer<PaymentBloc, PaymentState>(
                                    listener: (context, state) {
                                      if (state is PaymentRefundErrorState) {
                                        // ignore: void_checks
                                        return topSnackbar(context,
                                            state.message, AppColors.red);
                                      } else if (state
                                          is PaymentRefundSuccessState) {
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const ScreenParant()),
                                                (route) => false);
                                        // ignore: void_checks
                                        return topSnackbar(
                                            context,
                                            "Successfully refunded your amount",
                                            Colors.green);
                                      }
                                    },
                                    builder: (context, state) {
                                      if (state is PaymentRefundLoadingState) {
                                        return Center(
                                          child: LoadingAnimationWidget.inkDrop(
                                              color: AppColors.primaryColor,
                                              size: 50),
                                        );
                                      }
                                      return ButtonWidget(
                                        title: 'Refund Amount',
                                        onPress: () => refundAmount(),
                                      );
                                    },
                                  )
                                ],
                              ),
                            );
                          },
                        )
                      },
                    )
                  : Text('Refunded the amount', style: AppFonts.popinsGreen))
        ],
      ),
    );
  }

  refundAmount() {
    if (refundKey.currentState!.validate()) {
      context.read<PaymentBloc>().add(PaymentRefundEvent(
          amount: widget.bookingData.grandTotal,
          paymentId: widget.bookingData.id,
          reason: refundController.text));
    }
  }
}
