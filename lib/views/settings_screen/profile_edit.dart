// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';


// // ignore: must_be_immutable
// class ProfileEditScreen extends StatelessWidget {
//   ProfileEditScreen({super.key});

//   TextEditingController nameController = TextEditingController();
//   TextEditingController phoneController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   File? imagePath;
//   @override
//   Widget build(BuildContext context) {
//     nameController.text = hostModelData!.name.toString();
//     phoneController.text = hostModelData!.phone.toString();
//     emailController.text = hostModelData!.email.toString();
//     return Scaffold(
//       appBar: AppBar(
//           leading: IconButton(
//               onPressed: () {
                
//                 Navigator.of(context).pushAndRemoveUntil(
//                     MaterialPageRoute(
//                         builder: (context) => ScreenParant(index: 2)),
//                     (route) => false);
//               },
//               icon: const Icon(Icons.arrow_back)),
//           backgroundColor: appbarColorH,
//           centerTitle: true,
//           elevation: 0,
//           title: Text("PROFILE EDIT", style: GoogleFonts.poppins())),
//       body: Padding(
//         padding: const EdgeInsets.all(10),
//         child: SingleChildScrollView(
//           child: Column(children: [
//             BlocBuilder<ProfileEditBloc, ProfileEditState>(
//               builder: (context, state) {
//                 if (state is ProfileImageAddedState) {
//                   imagePath = state.imagePath;
//                 }
//                 return GestureDetector(
//                   onTap: () {
//                     context.read<ProfileEditBloc>().add(ImageAddedClicked());
//                   },
//                   child: Hero(
//                       tag: "profilePhoto",
//                       child: CircleAvatar(
//                           radius: 85,
//                           backgroundColor: appbarColorH,
//                           child: imagePath != null
//                               ? CircleAvatar(
//                                   backgroundImage:
//                                       FileImage(File(imagePath!.path)),
//                                   radius: 80,
//                                 )
//                               : hostModelData!.profile.isNotEmpty
//                                   ? CircleAvatar(
//                                       radius: 80,
//                                       backgroundImage: NetworkImage(
//                                           '${HostUrl.baseUrl}/${hostModelData!.profile}'),
//                                     )
//                                   : CircleAvatar(
//                                       radius: 80,
//                                       backgroundImage: AssetImage(
//                                         image.profilePhotodemo,
//                                       ),
//                                     ))),
//                 );
//               },
//             ),
//             const SizedBox(height: 10),
//             CustomTextfield(
//                 hint: "NAME", isSufix: false, controller: nameController),
//             const SizedBox(height: 10),
//             CustomTextfield(
//                 keybordtype: TextInputType.number,
//                 hint: "PHONE",
//                 isSufix: true,
//                 controller: phoneController),
//             const SizedBox(height: 10),
//             BlocConsumer<ProfileEditBloc, ProfileEditState>(
//               listener: (context, state) {
//                 if (state is SubmitSuccsessState) {
//                   ScaffoldMessenger.of(context).showSnackBar(customSnackbar(
//                       context, true, "Profile Added Succsesfull"));
//                 } else if (state is SubmitFailedState) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                       customSnackbar(context, false, "Profile Added Failed"));
//                 }
//               },
//               builder: (context, state) {
//                 return MyLoadingButton(
//                   isLoading: state is SubmitLoadingState,
//                   title: "Update",
//                   onTap: () {
//                     if (imagePath != null) {
//                       updateButtonClicked(nameController.text,
//                           phoneController.text, imagePath!, context);
//                     } else {
//                       ScaffoldMessenger.of(context).showSnackBar(customSnackbar(
//                           context, false, "Add Your Profile Photo"));
//                     }
//                   },
//                 );
//               },
//             )
//           ]),
//         ),
//       ),
//     );
//   }

//   updateButtonClicked(
//       String name, String phone, File image, BuildContext context) {
//     if (name.isNotEmpty && phone.isNotEmpty) {
//       context.read<ProfileEditBloc>().add(SubmitClicked(image: image));
//     } else {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(customSnackbar(context, false, "Something Wrong"));
//     }
//   }
// }