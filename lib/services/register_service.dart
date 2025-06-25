import 'package:dio/dio.dart';
import 'package:shoppe/core/package/package_export.dart';

class RegisterService {
  static Future<Response?> userRegister(
    String first_name,
    String last_name,
    String gender,
    String country,
    String state,
    String city,
    String address,
    String email,
    String phone_number,
    String dob,
    String pincode,
    String password,
  ) async {
    try {
      final response = await ApiRepository.post(
        Endpoints.getEndpoint(EndpointType.UserRegister),
        jsonBody: {
          "first_name": first_name,
          "last_name": last_name,
          "gender": gender,
          "country": country,
          "state": state,
          "city": city,
          "address": address,
          "email": email,
          "phone_number": phone_number,
          "dob": dob,
          "pin_code": pincode,
          "password": password,
        },
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
