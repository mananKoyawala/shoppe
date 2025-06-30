import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
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
  static Future<Response?> uploadUserProfileImage(File imageFile) async {
    try {
      if (imageFile.path.isEmpty) {
        throw Exception("Image file path is empty");
      }

      String? mime = getMimeType(imageFile.path);
      final parts = mime!.split('/');
      final contentType = MediaType(parts[0], parts[1]);

      String fileName = imageFile.path.split('/').last;
      FormData formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(
          imageFile.path,
          filename: fileName,
          contentType: contentType,
        ),
      });

      final response = await ApiRepository.post(
        Endpoints.getEndpoint(EndpointType.UpdateUserProfileImage),
        setBarer: true,
        formDataBody: formData,
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

String? getMimeType(String path) {
  if (path.endsWith(".png")) return "image/png";
  if (path.endsWith(".jpg") || path.endsWith(".jpeg")) return "image/jpeg";
  return null;
}
