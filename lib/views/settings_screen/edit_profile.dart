import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:user_side/blocs/user_data/user_data_bloc.dart';
import 'package:user_side/data/netword/api_urls.dart';
import 'package:user_side/resources/components/backbutton_widget.dart';
import 'package:user_side/resources/components/button_widget.dart';
import 'package:user_side/resources/components/textformfield.dart';
import 'package:user_side/resources/constants/app_color.dart';
import 'package:user_side/resources/constants/app_fonts.dart';
import 'package:user_side/utils/validation.dart';
import 'package:user_side/views/bottom_navbar_screen/bottom_navigation_bar.dart';

import '../../utils/imagepicker_service.dart';

// ignore: must_be_immutable
class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  GlobalKey<FormState> profileKey = GlobalKey<FormState>();
  String? imagePath;

  File? profileImage;

  // @override
  @override
  Widget build(BuildContext context) {
    var user = context.read<UserDataBloc>().user;
    nameController.text = user.name;
    phoneController.text = user.phone.toString();
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
              StatefulBuilder(builder: (context, setState) {
                return Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        height: MediaQuery.of(context).size.width / 3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: imagePath != null
                              ? CircleAvatar(
                                  backgroundImage: FileImage(File(imagePath!)),
                                  radius: 80,
                                )
                              : Image.network(
                                  '${ApiUrls.baseUrl}/${user.profile}',
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -2,
                      right: -15,
                      child: RawMaterialButton(
                        onPressed: () async {
                          final pickedimage = await ImagePickService()
                              .pickCropImage(
                                  cropAspectRatio: const CropAspectRatio(
                                      ratioX: 1, ratioY: 1),
                                  imageSource: ImageSource.gallery);
                          if (pickedimage != null) {
                            File imagePicked = File(pickedimage.path);
                            imagePath = imagePicked.path;
                            setState(() {});
                          }
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
              }),
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
              const SizedBox(height: 10),
              BlocConsumer<UserDataBloc, UserDataState>(
                listener: (context, state) {
                  if (state is GetUserDataSuccessState) {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const ScreenParant()),
                        (route) => false);
                  }
                },
                builder: (context, state) {
                  if (state is GetUserDataLoadingState) {
                    return Center(
                      child: LoadingAnimationWidget.inkDrop(
                          color: AppColors.primaryColor, size: 50),
                    );
                  }
                  return ButtonWidget(
                      title: 'Submit',
                      onPress: () {
                        profileUpdate(context, File(imagePath!));
                      });
                },
              )
            ],
          ),
        ),
      )),
    );
  }

  profileUpdate(BuildContext context, File? image) {
    if (profileKey.currentState!.validate()) {
      Map<String, dynamic> data = {
        "phone": phoneController.text,
        "name": nameController.text
      };
      context
          .read<UserDataBloc>()
          .add(UpdateUserEvent(imagePath: image, data: data));
    }
  }
}
