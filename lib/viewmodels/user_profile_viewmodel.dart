import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shoppe/core/package/package_export.dart';
import 'package:shoppe/core/package/utils.dart';
import 'package:shoppe/core/sharedpreferences/sharedpreferences.dart';
import 'package:shoppe/models/user_profile_model.dart';
import 'package:shoppe/services/user_profile_service.dart';
import 'package:shoppe/viewmodels/dashboard_viewmodel.dart';

class UserProfileViewModel extends ChangeNotifier {
  // * loading profile data
  bool loading = true;

  loadProfileData(BuildContext context) async {
    bool isLoaded = await getUserProfileDetails(context);

    if (isLoaded) {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> onLogoutClicked(BuildContext context) async {
    await showOkCancelAlertDialog(
      context: context,
      title: 'Logout',
      message: 'Are you sure you want to logout?',
      okLabel: 'Logout',

      cancelLabel: 'Cancel',
      barrierDismissible: false,
      canPop: false,
    ).then((value) {
      if (value == OkCancelResult.ok) {
        if (context.mounted) {
          context.read<DashboardViewModel>().resetAll();
          logoutUser(context);
        }
      }
    });
  }

  onEditClick(BuildContext context) async {
    context.push("/editprofile");
  }

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
