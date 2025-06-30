import 'package:dio/dio.dart';
import 'package:shoppe/core/package/package_export.dart';

class UserProfileService {
  // * Get user profile details
  static Future<Response?> getUserProfileDetails() async {
    try {
      final response = await ApiRepository.get(
        Endpoints.getEndpoint(EndpointType.UserProfileDetails),
        setBarer: true,
      );

      return response;
    } on DioException catch (e) {
      toast(e.response?.data["error"]);
      return null;
    } catch (e) {
      toast(AppStrings.something_went_wrong);
      printDebug(e.toString());
      return null;
    }
  }

  // * Edit user profile data
  static Future<Response?> editUserProfileData(
    String first_name,
    String last_name,
    String gender,
    String country,
    String state,
    String city,
    String address,
    String dob,
    String pincode,
  ) async {
    try {
      final response = await ApiRepository.put(
        Endpoints.getEndpoint(EndpointType.UpdateUserProfile),
        setBarer: true,
        jsonBody: {
          "first_name": first_name,
          "last_name": last_name,
          "gender": gender,
          "country": country,
          "state": state,
          "city": city,
          "address": address,
          "dob": dob,
          "pin_code": pincode,
        },
      );
      return response;
    } on DioException catch (e) {
      toast(e.response?.data["error"]);
      return null;
    } catch (e) {
      toast(AppStrings.something_went_wrong);
      printDebug(e.toString());
      return null;
    }
  }

  // * Update user profile image

  // * change in app password
  static Future<Response?> changePassword(
    String otp,
    String new_password,
  ) async {
    try {
      final response = await ApiRepository.patch(
        Endpoints.getEndpoint(EndpointType.ChangePassword),
        setBarer: true,
        setTempToken: true,
        jsonBody: {"password": new_password, "otp": otp},
      );

      return response;
    } on DioException catch (e) {
      toast(e.response?.data["error"]);
      return null;
    } catch (e) {
      toast(AppStrings.something_went_wrong);
      printDebug(e.toString());
      return null;
    }
  }

  // * delete user
  static Future<Response?> deleteUser() async {
    try {
      final response = await ApiRepository.delete(
        Endpoints.getEndpoint(EndpointType.DeleteUser),
        setBarer: true,
      );

      return response;
    } on DioException catch (e) {
      toast(e.response?.data["error"]);
      return null;
    } catch (e) {
      toast(AppStrings.something_went_wrong);
      printDebug(e.toString());
      return null;
    }
  }
}
