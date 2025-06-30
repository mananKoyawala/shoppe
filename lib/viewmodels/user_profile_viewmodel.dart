import 'dart:io';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shoppe/core/constants/app_colors.dart';
import 'package:shoppe/core/constants/loader.dart';
import 'package:shoppe/core/package/package_export.dart';
import 'package:shoppe/core/package/utils.dart';
import 'package:shoppe/core/sharedpreferences/sharedpreferences.dart';
import 'package:shoppe/models/user_profile_model.dart';
import 'package:shoppe/providers/profile_image_notifer.dart';
import 'package:shoppe/services/user_profile_service.dart';
import 'package:shoppe/viewmodels/dashboard_viewmodel.dart';

class UserProfileViewModel extends ChangeNotifier {
  // * loading profile data
  bool loading = true;

  onUploadImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      final image = File(pickedFile.path);
      printDebug(image);
      // TODO : check jpg, jpeg or png
      final response = await UserProfileService.uploadUserProfileImage(image);
      if (response != null && response.statusCode == 200) {
        if (response.data["data"]["user_image_updated"]) {
          String url = response.data["data"]["image_url"];
          await AppPreferences.setUserImageUrl(url);
          printDebug(url);
          userImageNotifier.value = url;
          toast("Image uploaded");
        } else {
          toast("Failed to upload image");
        }
      }
    }
  }

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

  onDeleteClick(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            backgroundColor: Colors.white,
            title: Text('Delete Account'),
            content: Text(
              'This action will permanently delete your account. Do you want to continue?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: text(
                  text: "Cancel",
                  fontSize: 16,
                  textColor: AppColors.primaryColor,
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: text(
                  text: "Delete",
                  fontSize: 18,
                  fontWeight: 7,
                  textColor: Colors.red,
                ),
              ),
            ],
          ),
    );

    if (result == true && context.mounted) {
      AppLoader.showLoader();
      final res = await UserProfileService.deleteUser();
      if (res != null && res.statusCode == 200 && context.mounted) {
        context.read<DashboardViewModel>().resetAll();
        logoutUser(context);
        toast(AppStrings.account_deleted);
      }
      AppLoader.dismissLoader();
    }
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
