import 'package:shoppe/core/package/package_export.dart';

class DashboardViewModel extends ChangeNotifier {
  int index = 0;
  bool showCart = false;
  final pageController = PageController();

  changeIndex(int value) {
    index = value;
    pageController.jumpToPage(index);
    showCart = false;
    notifyListeners();
  }

  changeShowCart(int indexValue) {
    showCart = true;
    index = indexValue;
    pageController.jumpToPage(index);
    notifyListeners();
  }

  resetAll() {
    index = 0;
    pageController.jumpToPage(0);
    showCart = false;
    notifyListeners();
  }
}
