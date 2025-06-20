import 'package:dio/dio.dart';
import 'package:shoppe/core/package/package_export.dart';

class VerifyOtpService {
  static Future<Response?> verifyOTP(String otp) async {
    try {
      final response = await ApiRepository.post(
        Endpoints.getEndpoint(EndpointType.VerifyUserEmailOTP),
        jsonBody: {"otp": otp},
        setBarer: true,
        setTempToken: true,
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

  static Future<Response?> resendEmailOTP(String email) async {
    printDebug("Resend 1");
    try {
      final response = await ApiRepository.post(
        Endpoints.getEndpoint(EndpointType.ResendUserEmailOTP),
        jsonBody: {"email": email},
      );

      printDebug("Resend 2");
      return response;
    } on DioException catch (e) {
      toast(e.response?.data["error"]);
      printDebug("Resend 3");
      return e.response;
    } catch (e) {
      toast(AppStrings.something_went_wrong);
      printDebug(e.toString());
      printDebug("Resend 4");
      return null;
    }
  }
}
