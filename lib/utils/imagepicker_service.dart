import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickService {
  Future<XFile?> pickCropImage(
      {required CropAspectRatio cropAspectRatio,
      required ImageSource imageSource}) async {
    // For pick image
    XFile? pickImage = await ImagePicker().pickImage(source: imageSource);
    if (pickImage == null) return null;

    // To crop the picked image
    CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickImage.path,
        aspectRatio: cropAspectRatio,
        compressQuality: 90,
        compressFormat: ImageCompressFormat.jpg);
    if (croppedFile == null) return null;

    return XFile(croppedFile.path);
  }
}
