import 'package:user_side/data/netword/api_service.dart';
import 'package:user_side/data/netword/api_urls.dart';
import 'package:user_side/data/shared_preference/shared_prefence.dart';

class UserRepo {
  final token = SharedPref.instance.getToke();

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

  EitherResponse putAvailableVehicle(Map<String, String> checkingData) {
    const url = '${ApiUrls.baseUrl}/${ApiUrls.putAvailableVehicles}';
    return ApiService.putApi(checkingData, url, token);
  }

  EitherResponse getAvailableVehicles() {
    const url = '${ApiUrls.baseUrl}/${ApiUrls.getAvailableVehcles}';
    return ApiService.getApi(url, token);
  }
}
