import 'package:provider/provider.dart';
import 'package:shoppe/core/constants/app_colors.dart';
import 'package:shoppe/core/package/package_export.dart';
import 'package:shoppe/viewmodels/dashboard_viewmodel.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DismissLoader(
      canPop: false,
      onBack: () {
        context.read<DashboardViewModel>().resetAll();
      },
      child: Scaffold(
        backgroundColor: theme.canvasColor,
        body: Container(
          alignment: Alignment.center,
          child: text(
            text: "Category Screen",
            fontSize: 20,
            textColor: AppColors.primaryColor,
            fontWeight: 5,
          ),
        ),
      ),
    );
  }
}
