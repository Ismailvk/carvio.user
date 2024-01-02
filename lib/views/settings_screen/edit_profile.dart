import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:user_side/blocs/profile_edit/profile_edit_bloc.dart';
import 'package:user_side/blocs/profile_edit/profile_edit_event.dart';
import 'package:user_side/blocs/profile_edit/profile_edit_state.dart';
import 'package:user_side/data/netword/api_urls.dart';
import 'package:user_side/resources/components/backbutton_widget.dart';
import 'package:user_side/resources/components/button_widget.dart';
import 'package:user_side/resources/components/textformfield.dart';
import 'package:user_side/resources/constants/app_color.dart';
import 'package:user_side/resources/constants/app_fonts.dart';
import 'package:user_side/utils/custom_snackbar.dart';
import 'package:user_side/utils/validation.dart';
import 'package:user_side/views/bottom_navbar_screen/bottom_navigation_bar.dart';

// ignore: must_be_immutable
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  GlobalKey<FormState> profileKey = GlobalKey<FormState>();

  String? imagePath;
  File? profileImage;
  @override
  void initState() {
    super.initState();
    nameController.text = globalUserModel?.name ?? '';
    phoneController.text =
        globalUserModel?.phone.toString() ?? 0000000000.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Form(
          key: profileKey,
          child: Column(
            children: [
              Row(
                children: [
                  const BackButtonWidget(),
                  SizedBox(width: MediaQuery.of(context).size.width / 4.2),
                  Text('Edit Profile', style: AppFonts.appbarTitle)
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 12),
              BlocBuilder<ProfileEditBloc, ProfileEditState>(
                builder: (context, state) {
                  if (state is ProfileImageAddedState) {
                    profileImage = state.imagePath;
                    imagePath = state.imagePath.path;
                  }
                  return Stack(
                    children: [
                      globalUserModel?.profile != null
                          ? CircleAvatar(
                              radius: 60,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width / 3,
                                height: MediaQuery.of(context).size.width / 3,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(60),
                                  child: imagePath != null
                                      ? CircleAvatar(
                                          backgroundImage:
                                              FileImage(File(imagePath!)),
                                          radius: 80,
                                        )
                                      : Image.network(
                                          '${ApiUrls.baseUrl}/${globalUserModel?.profile}',
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                            )
                          : CircleAvatar(
                              radius: 60,
                              child: Image.asset('asset/images/user copy.png',
                                  fit: BoxFit.fill),
                            ),
                      Positioned(
                        bottom: -2,
                        right: -15,
                        child: RawMaterialButton(
                          onPressed: () {
                            context
                                .read<ProfileEditBloc>()
                                .add(ImageAddedClicked());
                          },
                          elevation: 2.0,
                          fillColor: const Color(0xFFF5F6F9),
                          padding: const EdgeInsets.all(9),
                          shape: const CircleBorder(),
                          child: const Icon(Icons.camera_alt_outlined,
                              color: Colors.blue),
                        ),
                      )
                    ],
                  );
                },
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: MyTextField(
                    isSufix: false,
                    validator: (value) => Validation.isEmpty(value, "Name"),
                    controller: nameController,
                    hintText: 'Name',
                    obscureText: false),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: MyTextField(
                    isSufix: false,
                    validator: (value) => Validation.isEmpty(value, "Name"),
                    controller: TextEditingController(
                        text: '+91 ${phoneController.text}'),
                    hintText: 'Name',
                    obscureText: false),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: BlocConsumer<ProfileEditBloc, ProfileEditState>(
                  listener: (context, state) {
                    if (state is ProfileUpdateFailedState) {
                      topSnackbar(context, state.message, AppColors.red);
                    } else if (state is ProfileUpdateSuccsessState) {
                      print(state);
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const ScreenParant()),
                          (route) => false);
                      topSnackbar(
                          context, "Profile Updated Succsess", AppColors.green);
                    }
                  },
                  builder: (context, state) {
                    if (state is ProfileUpdateLoadingState) {
                      return Center(
                        child: LoadingAnimationWidget.inkDrop(
                            color: AppColors.primaryColor, size: 50),
                      );
                    }
                    return ButtonWidget(
                      title: 'Submit',
                      onPress: () {
                        if (profileImage == null) {
                          return topSnackbar(context,
                              "Select your profile picture", Colors.orange);
                        }
                        profileUpdate(context, profileImage!);
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      )),
    );
  }

  profileUpdate(BuildContext context, File image) {
    if (profileKey.currentState!.validate()) {
      Map<String, dynamic> data = {
        "phone": phoneController.text,
        "name": nameController.text
      };
      context
          .read<ProfileEditBloc>()
          .add(SubmitClicked(imagepath: image, data: data));
    }
  }
}
