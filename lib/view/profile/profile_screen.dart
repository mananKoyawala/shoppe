import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shoppe/core/constants/app_colors.dart';
import 'package:shoppe/core/package/package_export.dart';
import 'package:shoppe/core/package/utils.dart';
import 'package:shoppe/core/sharedpreferences/sharedpreferences.dart';
import 'package:shoppe/viewmodels/dashboard_viewmodel.dart';
import 'package:shoppe/viewmodels/user_profile_viewmodel.dart';
import 'package:shoppe/widgets/profile/profile_shimmer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<UserProfileViewModel>().loadProfileData(context);
    return DismissLoader(
      canPop: false,
      onBack: () {
        context.read<DashboardViewModel>().resetAll();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<UserProfileViewModel>(
          builder: (context, value, child) {
            return value.loading ? ProfileShimmer() : ProfileArea();
          },
        ),
      ),
    );
  }
}

class ProfileArea extends StatelessWidget {
  const ProfileArea({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = context.read<UserProfileViewModel>();
    return CP(
      h: 16,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () => controller.onEditClick(context),
                child: CP(
                  h: 5,
                  v: 5,
                  child: text(
                    text: AppStrings.edit,
                    fontSize: 18,
                    textColor: AppColors.primaryColor,
                    fontWeight: 7,
                  ),
                ),
              ),
            ),
            CircleAvatar(
              radius: 65,
              backgroundColor: Colors.grey.shade400,
              child: Icon(Icons.person, color: Colors.white, size: 80),
            ),
            sizeH25(),
            text(
              text: AppPreferences.getUserFullName(),
              fontSize: 20,
              fontWeight: 5,
            ),
            sizeH15(),
            Divider(),
            sizeH15(),
            Row(
              children: [
                Icon(
                  CupertinoIcons.phone_solid,
                  color: AppColors.primaryColor,
                  size: 20,
                ),
                sizeW10(),
                text(
                  text: "+91 ${AppPreferences.getUserPhoneNumber()}",
                  fontSize: 18,
                ),
              ],
            ),
            sizeH15(),
            Row(
              children: [
                Icon(
                  CupertinoIcons.mail_solid,
                  color: AppColors.primaryColor,
                  size: 20,
                ),
                sizeW10(),
                text(text: AppPreferences.getUserEmail(), fontSize: 18),
              ],
            ),
            sizeH15(),
            Divider(),
            sizeH10(),
            InkWell(
              onTap: () {
                launchURL(Uri.parse("http://github.com/manankoyawala"));
              },
              child: CP(
                v: 5,
                child: Row(
                  children: [
                    Icon(Icons.info_outline, size: 20),
                    sizeW10(),
                    text(text: AppStrings.about_me, fontSize: 18),
                  ],
                ),
              ),
            ),
            sizeH10(),
            Divider(),
            sizeH10(),
            InkWell(
              onTap: () {
                controller.onLogoutClicked(context);
              },
              child: CP(
                v: 5,
                child: Row(
                  children: [
                    Icon(Icons.logout, color: Colors.red, size: 20),
                    sizeW10(),
                    text(
                      text: AppStrings.logout,
                      fontSize: 18,
                      textColor: Colors.red,
                    ),
                  ],
                ),
              ),
            ),
            sizeH10(),
          ],
        ),
      ),
    );
  }
}
