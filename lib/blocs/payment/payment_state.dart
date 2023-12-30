part of 'payment_bloc.dart';

sealed class PaymentState {}

final class PaymentInitial extends PaymentState {}

final class PaymentSuccessState extends PaymentState {}

final class PaymentErrorState extends PaymentState {
  final String message;

  PaymentErrorState({required this.message});
}

final class PaymentFailedState extends PaymentState {}

// Payment Refund

final class PaymentRefundLoadingState extends PaymentState {}

final class PaymentRefundSuccessState extends PaymentState {}

final class PaymentRefundErrorState extends PaymentState {
  final String message;

  PaymentRefundErrorState({required this.message});
}

final class PaymentRefundFailedState extends PaymentState {}
