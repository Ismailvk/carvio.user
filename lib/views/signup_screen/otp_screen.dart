import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_side/blocs/signup_bloc/signup_bloc.dart';
import 'package:user_side/resources/components/button_widget.dart';
import 'package:user_side/resources/components/otp_textfield.dart';
import 'package:user_side/resources/constants/app_color.dart';
import 'package:user_side/views/home_screen/home_screen.dart';

// ignore: must_be_immutable
class SignupOtpScreen extends StatelessWidget {
  SignupOtpScreen({super.key, required this.email});
  final String email;
  TextEditingController pin1 = TextEditingController();
  TextEditingController pin2 = TextEditingController();
  TextEditingController pin3 = TextEditingController();
  TextEditingController pin4 = TextEditingController();
  GlobalKey<FormState> otpKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          shadowColor: Colors.transparent,
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: AppColors.primaryColor),
        ),
        backgroundColor: Colors.white,
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("asset/images/carback3.jpeg"),
                  fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Stack(
              children: [
                Positioned(
                  child: Stack(
                    children: [
                      Positioned(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                                height: MediaQuery.sizeOf(context).height / 6),
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: const Center(
                                child: Icon(
                                  color: Colors.white,
                                  Icons.person,
                                  size: 35,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "one time password  shared to this \nemail address.",
                              style: GoogleFonts.poppins(
                                  color: Colors.black, fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              email,
                              style: GoogleFonts.poppins(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 40),
                            Material(
                              color: Colors.transparent,
                              child: Form(
                                key: otpKey,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    OtpTexfield(
                                        controller: pin1,
                                        validator: (otp) => validOtp(otp!)),
                                    OtpTexfield(
                                        controller: pin2,
                                        validator: (otp) => validOtp(otp!)),
                                    OtpTexfield(
                                        controller: pin3,
                                        validator: (otp) => validOtp(otp!)),
                                    OtpTexfield(
                                        controller: pin4,
                                        validator: (otp) => validOtp(otp!)),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            BlocListener<SignupBloc, SignupState>(
                              listener: (context, state) {
                                if (state is OtpErrorState) {
                                  IconSnackBar.show(
                                      direction: DismissDirection.up,
                                      context: context,
                                      snackBarType: SnackBarType.fail,
                                      label: '${state.message} !!');
                                }
                                if (state is OtpSuccessState) {
                                  IconSnackBar.show(
                                      direction: DismissDirection.up,
                                      context: context,
                                      snackBarType: SnackBarType.save,
                                      label: 'Account created successfully !!');
                                }
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HomeScreen()),
                                    (route) => false);
                              },
                              child: ButtonWidget(
                                title: 'Submit',
                                onPress: () => signUp(context),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? validOtp(String otp) {
    if (pin1.text.isEmpty &&
        pin2.text.isEmpty &&
        pin3.text.isEmpty &&
        pin4.text.isEmpty) {
      return '';
    }
    return null;
  }

  signUp(BuildContext context) {
    if (otpKey.currentState!.validate()) {
      context.read<SignupBloc>().add(OtpButtonClickedEvent(
          pin1: pin1.text, pin2: pin2.text, pin3: pin3.text, pin4: pin4.text));
    }
  }
}
