import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:user_side/repositories/user_repo.dart';
import 'package:user_side/views/bottom_navbar_screen/bottom_navigation_bar.dart';
part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentInitial()) {
    on<PaymentInitialEvent>(paymentinitialEvent);
    on<PaymentSuccessEvent>(paymentSuccessEvent);
    on<PaymentFailedEvent>(paymentFailedEvent);
    on<PaymentRefundEvent>(paymentRefundEvent);
  }
  Map<String, dynamic> bookingData = {};

  final _razorpay = Razorpay();

  FutureOr<void> paymentinitialEvent(
      PaymentInitialEvent event, Emitter<PaymentState> emit) {
    bookingData['userId'] = event.userId;
    bookingData['vehicleId'] = event.vehicleId;
    bookingData['pickup'] = event.pickup;
    bookingData['dropoff'] = event.dropoff;
    bookingData['startDate'] = event.startDate;
    bookingData['endDate'] = event.endDate;
    bookingData['total'] = event.total;
    bookingData['grandTotal'] = event.grandTotal;
    if (event.grandTotal == 0) {}

    var options = {
      'key': 'rzp_test_0railK3kmonZvZ',
      'amount': event.grandTotal * 100,
      'name': 'Acme Corp.',
      'description': 'Fine T-Shirt',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'}
    };
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    _razorpay.open(options);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    bookingData['razorId'] = response.paymentId;
    add(PaymentSuccessEvent());
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    add(PaymentFailedEvent());
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }

  FutureOr<void> paymentSuccessEvent(
      PaymentSuccessEvent event, Emitter<PaymentState> emit) async {
    final response = await UserRepo().bookvehicle(bookingData);
    response.fold((error) {
      emit(PaymentErrorState(message: error.message));
    }, (response) {
      emit(PaymentSuccessState());
    });
  }

  FutureOr<void> paymentFailedEvent(
      PaymentFailedEvent event, Emitter<PaymentState> emit) {
    emit(PaymentFailedState());
  }

  Future<FutureOr<void>> paymentRefundEvent(
      PaymentRefundEvent event, Emitter<PaymentState> emit) async {
    final refundData = {'reason': event.reason, 'amount': event.amount};
    final response = await UserRepo().refundAmount(refundData, event.paymentId);
    response.fold((error) {
      emit(PaymentRefundErrorState(message: error.message));
    }, (response) {
      if (response['message'] == "Success") {
        int amount = globalUserModel?.wallet ?? 0;
        print('*************');
        print(amount);
        globalUserModel?.wallet = amount + event.amount.toInt();
        print(globalUserModel?.wallet);
        emit(PaymentRefundSuccessState());
      } else {
        emit(PaymentRefundFailedState());
      }
    });
  }
}
