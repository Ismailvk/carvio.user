// import 'dart:async';
// import 'dart:io';
// import 'package:user_side/data/shared_preference/shared_prefence.dart';



// class ProfileEditBloc extends Bloc<ProfileEditEvent, ProfileEditState> {
//   ProfileEditBloc() : super(ProfileEditInitial()) {
//     on<ImageAddedClicked>(imageAddedClicked);
//     on<SubmitClicked>(submitClicked);
//   }

//   FutureOr<void> imageAddedClicked(
//       ImageAddedClicked event, Emitter<ProfileEditState> emit) async {
// CroppedFile? croppedFile = await ImageCropper().cropImage(
//           sourcePath: image.path,
//           aspectRatio: cropAspectRatio,
//           compressQuality: 90,
//           compressFormat: ImageCompressFormat.jpg);
//       if (croppedFile == null) return null;
//       pickedImage.value = File(croppedFile.path);
   
//     if (pickedimage != null) {
//       File imagePicked = File(pickedimage.path);
//       // hostModelData?.profile = pickedimage as File;
//       emit(ProfileImageAddedState(imagePath: imagePicked));
//     }
//   }

//   FutureOr<void> submitClicked(
//       SubmitClicked event, Emitter<ProfileEditState> emit) async {
//     emit(ProfileUpdateLoadingState());
//     final response = await ApiServices.instance.dataUpdate(event.data);
//     print(response.statusCode);
//     final response1 = await ApiServices.instance.profileUpdate(event.imagepath);
//     final responsBody = await response1.stream.bytesToString();
//     print(responsBody);
//     final token = SharedPref.instance.getToke();
//     if (token != null) {
//       // final response = await UserDataRepo().userData(token);
//       // final data = jsonDecode(response.body);
//       // if (data != null) {
//       //   // final data1 = UserModal.fromJson(data);
//       //   // logedUser = data1;
//       // }
//       emit(ProfileUpdateSuccsessState());
//     } else {
//       emit(ProfileUpdateFailedState(message: "Somthing Wrong"));
//     }
//   }
// }