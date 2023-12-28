import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:user_side/blocs/user/user_bloc.dart';
import 'package:user_side/resources/components/backbutton_widget.dart';
import 'package:user_side/resources/components/button_widget.dart';
import 'package:user_side/resources/components/textformfield.dart';
import 'package:user_side/resources/constants/app_color.dart';
import 'package:user_side/resources/constants/app_fonts.dart';
import 'package:user_side/utils/custom_snackbar.dart';
import 'package:user_side/utils/validation.dart';
import 'package:user_side/views/change_password/password_changed_success.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  final GlobalKey<FormState> newPasswordKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BackButtonWidget(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Form(
                  key: newPasswordKey,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      const SizedBox(height: 15),
                      Text('Change Password', style: AppFonts.normal),
                      const SizedBox(height: 10),
                      Text('Enter new password for your sequrity',
                          style: AppFonts.popins),
                      Container(
                        height: MediaQuery.of(context).size.height / 3,
                        alignment: Alignment.topCenter,
                        child: Lottie.asset('asset/lotties/newPassword.json'),
                      ),
                      MyTextField(
                          isSufix: false,
                          validator: (value) => Validation.isPassword(value),
                          controller: oldPasswordController,
                          hintText: 'Old Password',
                          obscureText: false),
                      const SizedBox(height: 10),
                      MyTextField(
                          isSufix: false,
                          validator: (value) => Validation.isPassword(value),
                          controller: newPasswordController,
                          hintText: 'New Password',
                          obscureText: false),
                      const SizedBox(height: 10),
                      MyTextField(
                        isSufix: false,
                        validator: (value) => Validation.isPasswordMatch(
                            newPasswordController.text, confirmController.text),
                        controller: confirmController,
                        hintText: 'Confirm Password',
                        obscureText: false,
                      ),
                      const SizedBox(height: 20),
                      BlocConsumer<UserBloc, UserState>(
                        listener: (context, state) {
                          if (state is ResetPasswordErrorState) {
                            // ignore: void_checks
                            return topSnackbar(
                                context, state.message, AppColors.red);
                          } else if (state is ResetPasswordFailedState) {
                            // ignore: void_checks
                            return topSnackbar(
                                context, state.message, AppColors.red);
                          } else if (state is ResetPasswordSuccessState) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const EmailChangedSuccess()));
                            // ignore: void_checks
                            return topSnackbar(
                                context,
                                'Password Changed Successfully',
                                AppColors.green);
                          }
                        },
                        builder: (context, state) {
                          if (state is ResetPasswordLoadingState) {
                            return Center(
                              child: LoadingAnimationWidget.inkDrop(
                                  color: AppColors.primaryColor, size: 50),
                            );
                          }
                          return Container(
                            alignment: Alignment.topCenter,
                            child: ButtonWidget(
                              title: 'Reset Password',
                              onPress: () => newPassword(context),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  newPassword(BuildContext context) {
    if (newPasswordKey.currentState!.validate()) {
      context.read<UserBloc>().add(ResetPasswordEvent(
            oldPassword: oldPasswordController.text,
            newPassword: newPasswordController.text,
            confirmPassword: confirmController.text,
          ));
    }
  }
}
