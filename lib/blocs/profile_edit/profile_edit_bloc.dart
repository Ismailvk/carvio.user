// import 'dart:async';
// import 'dart:io';
// import 'package:bloc/bloc.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:user_side/blocs/profile_edit/profile_edit_event.dart';
// import 'package:user_side/blocs/profile_edit/profile_edit_state.dart';
// import 'package:user_side/data/netword/api_service.dart';
// import 'package:user_side/utils/imagepicker_service.dart';

// class ProfileEditBloc extends Bloc<ProfileEditEvent, ProfileEditState> {
//   ProfileEditBloc() : super(ProfileEditInitial()) {
//     on<ImageAddedClicked>(imageAddedClicked);
//     on<SubmitClicked>(submitClicked);
//   }

//   FutureOr<void> imageAddedClicked(
//       ImageAddedClicked event, Emitter<ProfileEditState> emit) async {
//     final pickedimage = await ImagePickService().pickCropImage(
//         cropAspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
//         imageSource: ImageSource.gallery);
//     if (pickedimage != null) {
//       File imagePicked = File(pickedimage.path);
//       // hostModelData?.profile = pickedimage as File;
//       emit(ProfileImageAddedState(imagePath: imagePicked));
//     }
//   }

//   FutureOr<void> submitClicked(
//       SubmitClicked event, Emitter<ProfileEditState> emit) async {
//     emit(ProfileUpdateLoadingState());
//     final response = await ApiService().dataUpdate(event.data);
//     print(response.statusCode);
//     final response1 = await ApiService().profileUpdate(event.imagepath);
//     print(response1.statusCode);
//     if (response1.statusCode == 200) {
//       emit(ProfileUpdateSuccsessState());
//     } else {
//       emit(ProfileUpdateFailedState(message: "Somthing Went Wrong"));
//     }
//     final responsBody = await response1.stream.bytesToString();
//     print(responsBody);
//   }
// }
