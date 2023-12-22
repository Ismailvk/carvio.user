import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:user_side/blocs/forget_password/forget_password_bloc.dart';
import 'package:user_side/resources/components/button_widget.dart';
import 'package:user_side/resources/components/textformfield.dart';
import 'package:user_side/resources/constants/app_color.dart';
import 'package:user_side/resources/constants/app_fonts.dart';
import 'package:user_side/utils/custom_snackbar.dart';
import 'package:user_side/utils/validation.dart';
import 'package:user_side/views/login_screen/login_screen.dart';

class NewPasswordScreen extends StatelessWidget {
  final String userId;
  NewPasswordScreen({super.key, required this.userId});
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  final GlobalKey<FormState> newPasswordKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Form(
            key: newPasswordKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                const SizedBox(height: 15),
                Text('Create New Password', style: AppFonts.normal),
                const SizedBox(height: 10),
                Text('Enter different password with the previous',
                    style: AppFonts.popins),
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  alignment: Alignment.topCenter,
                  child: Lottie.asset('asset/lotties/newPassword.json'),
                ),
                MyTextField(
                    isSufix: false,
                    validator: (value) => Validation.isPassword(value),
                    controller: passwordController,
                    hintText: 'New Password',
                    obscureText: false),
                const SizedBox(height: 10),
                MyTextField(
                  isSufix: false,
                  validator: (value) => Validation.isPasswordMatch(
                      passwordController.text, confirmController.text),
                  controller: confirmController,
                  hintText: 'Confirm Password',
                  obscureText: false,
                ),
                const SizedBox(height: 50),
                Container(
                  alignment: Alignment.topCenter,
                  child: BlocConsumer<ForgetPasswordBloc, ForgetPasswordState>(
                    listener: (context, state) {
                      if (state is ResetPasswordErrorState) {
                        // ignore: void_checks
                        return topSnackbar(
                            context, state.message, AppColors.red);
                      } else if (state is ResetPasswordSuccessState) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                            (route) => false);
                        // ignore: void_checks
                        return topSnackbar(
                            context,
                            'Pssword Changed Successfully, Please Login',
                            AppColors.primaryColor);
                      }
                    },
                    builder: (context, state) {
                      if (state is ResetPasswordLoadingState) {
                        return Center(
                          child: LoadingAnimationWidget.inkDrop(
                              color: AppColors.primaryColor, size: 50),
                        );
                      }
                      return ButtonWidget(
                        title: 'Reset Password',
                        onPress: () => newPassword(context),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  newPassword(BuildContext context) {
    if (newPasswordKey.currentState!.validate()) {
      final data = {
        'newpass': passwordController.text.trim(),
        'confirmpass': confirmController.text.trim()
      };
      context
          .read<ForgetPasswordBloc>()
          .add(ResetPasswordEvent(newPasswordData: data, userId: userId));
    }
  }
}
