import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shoppe/core/constants/app_colors.dart';
import 'package:shoppe/core/package/package_export.dart';
import 'package:shoppe/viewmodels/dashboard_viewmodel.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<DashboardViewModel>();
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      bottomNavigationBar: Consumer<DashboardViewModel>(
        builder: (context, value, child) {
          return StylishBottomBar(
            backgroundColor: const Color.fromARGB(8, 0, 0, 0),
            option: AnimatedBarOptions(iconStyle: IconStyle.animated),
            elevation: 0,
            items: [
              BottomBarItem(
                icon: const Icon(Icons.house_outlined),
                selectedIcon: Icon(
                  Icons.house_rounded,
                  color: AppColors.primaryColor,
                ),
                unSelectedColor: Colors.grey,
                title: text(
                  text: AppStrings.home,
                  fontSize: 12,
                  textColor: AppColors.primaryColor,
                  fontWeight: 7,
                ),
              ),
              BottomBarItem(
                icon: Icon(Icons.style_outlined),
                selectedIcon: Icon(Icons.style, color: AppColors.primaryColor),
                title: text(
                  text: AppStrings.category,
                  fontSize: 12,
                  textColor: AppColors.primaryColor,
                  fontWeight: 7,
                ),
              ),
              BottomBarItem(
                icon: const Icon(Icons.person_outline),
                selectedIcon: const Icon(Icons.person),
                selectedColor: Colors.white,
                unSelectedColor: Colors.white,
                title: const Text(''),
              ),
              BottomBarItem(
                icon: const Icon(Icons.bookmark_outline),
                selectedIcon: Icon(
                  Icons.bookmark,
                  color: AppColors.primaryColor,
                ),
                title: text(
                  text: AppStrings.bookmark,
                  fontSize: 12,
                  textColor: AppColors.primaryColor,
                  fontWeight: 7,
                ),
              ),
              BottomBarItem(
                icon: const Icon(Icons.person_outline),
                selectedIcon: Icon(Icons.person, color: AppColors.primaryColor),
                title: text(
                  text: AppStrings.profile,
                  fontSize: 12,
                  textColor: AppColors.primaryColor,
                  fontWeight: 7,
                ),
              ),
            ],

            hasNotch: true,
            fabLocation: StylishBarFabLocation.center,
            currentIndex: value.index,
            notchStyle: NotchStyle.circle,
            onTap: (index) => controller.changeIndex(index),
          );
        },
      ),
      floatingActionButton: Consumer<DashboardViewModel>(
        builder: (context, value, child) {
          return FloatingActionButton(
            onPressed: () => controller.changeShowCart(2),
            backgroundColor: Colors.white,
            shape: CircleBorder(),
            child: Icon(
              value.showCart ? CupertinoIcons.cart_fill : CupertinoIcons.cart,
              color: AppColors.primaryColor,
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
        child: PageView(
          controller: controller.pageController,
          children: const [
            Center(child: Text(AppStrings.home)),
            Center(child: Text(AppStrings.category)),
            Center(child: Text(AppStrings.cart)),
            Center(child: Text(AppStrings.bookmark)),
            Center(child: Text(AppStrings.profile)),
          ],
        ),
      ),
    );
  }
}
