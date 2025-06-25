import 'package:shoppe/core/package/package_export.dart';
import 'package:shoppe/core/package/utils.dart';
import 'package:shoppe/core/sharedpreferences/sharedpreferences.dart';
import 'package:shoppe/models/user_profile_model.dart';
import 'package:shoppe/services/user_profile_service.dart';

class UserProfileViewModel extends ChangeNotifier {
  Future<bool> getUserProfileDetails(BuildContext context) async {
    final token = await AppPreferences.getAccessToken();

    printDebug("UserAccessToken $token");

    if (token.isEmpty) {
      printDebug("NoAccessTokenFound");
    }

    final response = await UserProfileService.getUserProfileDetails();

    if (response != null) {
      UserProfileModel user_profile = UserProfileModel.fromJson(
        response.data["data"]["user_profile"],
      );
      await setUserPreferenceData(user_profile, setAccessToken: false);
      return true;
    }
    AppPreferences.clearAllPreferences();
    return false;
  }
}
