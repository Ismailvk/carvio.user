part of 'user_bloc.dart';

abstract class UserEvent {}

final class FetchUserDataEvent extends UserEvent {
  final String token;

  FetchUserDataEvent({required this.token});
}
