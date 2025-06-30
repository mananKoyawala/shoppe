import 'package:shimmer/shimmer.dart';
import 'package:shoppe/core/constants/app_colors.dart';
import 'package:shoppe/core/package/package_export.dart';
import 'package:shoppe/core/package/utils.dart';
import 'package:shoppe/providers/profile_image_notifer.dart';
import 'package:shoppe/viewmodels/user_profile_viewmodel.dart';

class UserProfileImage extends StatelessWidget {
  const UserProfileImage({
    super.key,
    required this.height,
    required this.controller,
  });

  final double height;
  final UserProfileViewModel controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: userImageNotifier,
      builder: (context, value, child) {
        return Stack(
          children: [
            Container(
              height: height,
              width: height,
              decoration: BoxDecoration(borderRadius: radius(height)),
              child: ClipRRect(
                borderRadius: radius(height),
                child: Image.network(
                  fit: BoxFit.cover,
                  value,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade400,
                          borderRadius: radius(height),
                        ),
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 80,
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade400,
                          borderRadius: radius(height),
                        ),
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 80,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 5,
              right: 5,
              child: InkWell(
                borderRadius: radius(20),
                onTap: () {
                  controller.onUploadImage();
                },
                child: CircleAvatar(
                  backgroundColor: AppColors.textFieldBgLight,
                  radius: 20,
                  child: Center(
                    child: Icon(
                      Icons.edit,
                      color: AppColors.primaryColor,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
