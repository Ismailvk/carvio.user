part of 'payment_bloc.dart';

sealed class PaymentState {}

final class PaymentInitial extends PaymentState {}

final class PaymentSuccessState extends PaymentState {}

final class PaymentErrorState extends PaymentState {
  final String message;

  PaymentErrorState({required this.message});
}

final class PaymentFailedState extends PaymentState {}
