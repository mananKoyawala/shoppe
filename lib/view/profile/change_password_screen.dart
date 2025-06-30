import 'package:provider/provider.dart';
import 'package:shoppe/core/constants/app_colors.dart';
import 'package:shoppe/core/package/package_export.dart';
import 'package:shoppe/core/package/utils.dart';
import 'package:shoppe/viewmodels/change_password_viewmodel.dart';
import 'package:shoppe/widgets/fill_background_secondary.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = context.read<ChangePasswordViewModel>();
    return DismissLoader(
      onBack: () {
        controller.resetAll();
      },
      child: Stack(
        children: [
          FillBackgroundSecondary(),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: CP(
              h: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sizeH(getScreenHeight(context) * .2),
                  text(
                    text: AppStrings.change_password,
                    fontSize: 35,
                    fontWeight: 7,
                  ),
                  sizeH10(),
                  text(text: AppStrings.edit_profile_title, fontSize: 18),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Form(
                        key: controller.formKey,
                        child: Column(
                          children: [
                            sizeH25(),
                            Consumer<ChangePasswordViewModel>(
                              builder: (context, value, child) {
                                return textFormField(
                                  context: context,
                                  theme: theme,
                                  obsecureText: value.isObsecure,
                                  maxLines: 1,
                                  controller: controller.passwordCtr,
                                  textInputType: TextInputType.text,
                                  funValidate:
                                      (val) => controller.validatePassword(val),
                                  hintText: AppStrings.password,
                                  suffixIcon: iconButton(
                                    onTap: () => controller.toggleObsecure(),
                                    icon: Icon(
                                      value.isObsecure
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                );
                              },
                            ),
                            sizeH25(),
                            Consumer<ChangePasswordViewModel>(
                              builder: (context, value, child) {
                                return textFormField(
                                  context: context,
                                  theme: theme,
                                  obsecureText: value.isObsecureConPwd,
                                  maxLines: 1,
                                  controller: controller.confirmPwdCtr,
                                  textInputType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                  funValidate:
                                      (val) => controller
                                          .validateConfirmPassword(val),
                                  hintText: AppStrings.conPwd,
                                  suffixIcon: iconButton(
                                    onTap:
                                        () => controller.toggleObsecureConPwd(),
                                    icon: Icon(
                                      value.isObsecureConPwd
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                );
                              },
                            ),
                            // Password requirements
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                text(
                                  text: "Password requirements",
                                  fontSize: 16,
                                ),
                                iconButton(
                                  onTap: () => showPasswordCriteria(context),
                                  icon: Icon(
                                    Icons.info,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            // TODO : send otp based on email or mobile phone verified
                          ],
                        ),
                      ),
                    ),
                  ),

                  Visibility(
                    visible: MediaQuery.of(context).viewInsets.bottom == 0,
                    child: Column(
                      children: [
                        simpleButton(
                          height: 55,
                          context,
                          onTap: () => controller.onChangePassword(context),
                          title: text(
                            text: AppStrings.change_password,
                            fontSize: 18,
                            textColor: Colors.white,
                          ),
                        ),
                        sizeH20(),
                        simpleButton(
                          backgroundColor: Colors.transparent,
                          height: 55,
                          context,
                          onTap: () => controller.onCancel(context),
                          title: text(
                            text: AppStrings.cancel,
                            fontSize: 18,
                            textColor: theme.shadowColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  sizeH20(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
