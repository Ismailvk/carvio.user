import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:user_side/repositories/user_repo.dart';
part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentInitial()) {
    on<PaymentInitialEvent>(paymentinitialEvent);
    on<PaymentSuccessEvent>(paymentSuccessEvent);
    on<PaymentFailedEvent>(paymentFailedEvent);
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
    print('called');
    final response = await UserRepo().bookvehicle(bookingData);
    response.fold((error) {
      print(error.message);
      emit(PaymentErrorState(message: error.message));
    }, (response) {
      print(response);
      emit(PaymentSuccessState());
    });
  }

  FutureOr<void> paymentFailedEvent(
      PaymentFailedEvent event, Emitter<PaymentState> emit) {
    emit(PaymentFailedState());
  }
}
