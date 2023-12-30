import 'package:get_it/get_it.dart';
import 'package:user_side/blocs/user/user_bloc.dart';
import 'package:user_side/models/user_model.dart';

final locator = GetIt.instance;

UserModel globalUserModel = locator<UserBloc>().userModel;

void setupLocator() {
  locator.registerLazySingleton(() => UserBloc());
}
