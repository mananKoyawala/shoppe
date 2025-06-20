import 'package:dio/dio.dart';
import 'package:shoppe/core/constants/app_strings.dart';
import 'package:shoppe/core/package/PackageConstants.dart';
import 'package:shoppe/repository/api_repository.dart';
import 'package:shoppe/repository/enpoints.dart';

class LoginService {
  static Future<Response?> userLogin(String email, String password) async {
    try {
      final response = await ApiRepository.post(
        Endpoints.getEndpoint(EndpointType.UserLogin),
        jsonBody: {"email": email, "password": password},
      );

      return response;
    } on DioException catch (e) {
      toast(e.response?.data["error"]);
      return e.response;
    } catch (e) {
      toast(AppStrings.something_went_wrong);
      printDebug(e.toString());
      return null;
    }
  }
}
