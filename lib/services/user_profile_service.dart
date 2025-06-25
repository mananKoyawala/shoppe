import 'package:dio/dio.dart';
import 'package:shoppe/core/package/package_export.dart';

class UserProfileService {
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
}
