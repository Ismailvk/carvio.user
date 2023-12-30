part of 'payment_bloc.dart';

sealed class PaymentEvent {}

final class PaymentInitialEvent extends PaymentEvent {
  final int total;
  final String userId;
  final String vehicleId;
  final String pickup;
  final String dropoff;
  final String startDate;
  final String endDate;
  final int grandTotal;

  PaymentInitialEvent(
      {required this.total,
      required this.userId,
      required this.vehicleId,
      required this.pickup,
      required this.dropoff,
      required this.startDate,
      required this.endDate,
      required this.grandTotal});
}

final class CheckBoxClickedEvent extends PaymentEvent {}

final class PaymentRefundEvent extends PaymentEvent {
  final String paymentId;
  final double amount;
  final String reason;

  PaymentRefundEvent(
      {required this.paymentId, required this.amount, required this.reason});
}

final class PaymentStartEvent extends PaymentEvent {}

final class PaymentSuccessEvent extends PaymentEvent {}

final class PaymentFailedEvent extends PaymentEvent {}
