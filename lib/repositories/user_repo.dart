import 'package:user_side/data/netword/api_service.dart';
import 'package:user_side/data/netword/api_urls.dart';

class UserRepo {
  EitherResponse signUpUser(Map<String, dynamic> data) {
    const url = '${ApiUrls.baseUrl}/${ApiUrls.signUp}';
    return ApiService.postApi(data, url);
  }

  EitherResponse signupOtp(Map<String, dynamic> otp) {
    const url = '${ApiUrls.baseUrl}/${ApiUrls.otp}';
    return ApiService.postApi(otp, url);
  }

  EitherResponse loginUser(Map<String, String> userData) {
    const url = '${ApiUrls.baseUrl}/${ApiUrls.login}';
    return ApiService.postApi(userData, url);
  }
}
