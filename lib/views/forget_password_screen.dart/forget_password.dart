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
import 'package:user_side/views/forget_password_screen.dart/found_email.dart';
import 'package:user_side/views/login_screen/login_screen.dart';

// ignore: must_be_immutable
class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});
  GlobalKey<FormState> forgetPassKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            Lottie.asset('asset/lotties/forgetPassword.json'),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text('Forget Password', style: AppFonts.sansitaFont),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 5),
              child: Text('Enter your registered email below',
                  style: AppFonts.popins),
            ),
            const SizedBox(height: 50),
            Form(
              key: forgetPassKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: MyTextField(
                    isSufix: false,
                    validator: (value) => Validation.isEmail(value),
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Center(
                child: GestureDetector(
                  onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginScreen())),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: 'Remember your password ? ',
                            style: AppFonts.popins),
                        const TextSpan(
                          text: 'Login',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 80),
            BlocConsumer<ForgetPasswordBloc, ForgetPasswordState>(
              listener: (context, state) {
                if (state is ForgetPasswordCheckingSuccessState) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          FoundEmailScreen(userId: state.userId),
                    ),
                  );
                }
                if (state is ForgetPasswordCheckingErrorState) {
                  topSnackbar(context, state.message, AppColors.red);
                }
              },
              builder: (context, state) {
                if (state is ForgetPasswordCheckingLoadingState) {
                  return Center(
                    child: LoadingAnimationWidget.inkDrop(
                        color: AppColors.primaryColor, size: 50),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ButtonWidget(
                    title: 'Submit',
                    onPress: () => sendEmail(context),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  sendEmail(BuildContext context) {
    if (forgetPassKey.currentState!.validate()) {
      final String email = emailController.text.trim();
      context
          .read<ForgetPasswordBloc>()
          .add(ForgetPasswordCheckingEvent(email: email));
    }
  }
}
