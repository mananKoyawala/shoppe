import 'package:provider/provider.dart';
import 'package:shoppe/core/constants/app_colors.dart';
import 'package:shoppe/core/package/package_export.dart';
import 'package:shoppe/core/package/utils.dart';
import 'package:shoppe/viewmodels/signup_viewmodel.dart';
import 'package:shoppe/widgets/fill_background_secondary.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<SignupViewModel>();
    final theme = Theme.of(context);
    return DismissLoader(
      onBack: () => controller.resetAll(),
      child: Scaffold(
        backgroundColor: theme.canvasColor,
        body: Stack(
          children: [
            FillBackgroundSecondary(),
            CP(
              h: 16,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sizeH(getScreenHeight(context) * .2),
                  text(text: AppStrings.signup, fontSize: 50, fontWeight: 7),
                  sizeH10(),
                  text(text: AppStrings.signup_message, fontSize: 20),
                  sizeH10(),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Form(
                            key: controller.formKey,
                            child: Column(
                              children: [
                                sizeH25(),
                                // First name
                                textFormField(
                                  context: context,
                                  theme: theme,
                                  controller: controller.firstNameCtr,
                                  textInputType: TextInputType.text,
                                  funValidate:
                                      (val) => controller.fieldIsRequired(val),
                                  hintText: AppStrings.firstName,
                                  scrollPadding: EdgeInsets.only(
                                    top:
                                        MediaQuery.of(context).viewInsets.top +
                                        40.0,
                                    bottom:
                                        MediaQuery.of(
                                          context,
                                        ).viewInsets.bottom +
                                        20.0,
                                  ),
                                ),
                                sizeH25(),
                                // Last name
                                textFormField(
                                  context: context,
                                  theme: theme,
                                  controller: controller.lastNameCtr,
                                  textInputType: TextInputType.text,
                                  funValidate:
                                      (val) => controller.fieldIsRequired(val),
                                  hintText: AppStrings.lastName,
                                  scrollPadding: EdgeInsets.only(
                                    top:
                                        MediaQuery.of(context).viewInsets.top +
                                        40.0,
                                    bottom:
                                        MediaQuery.of(
                                          context,
                                        ).viewInsets.bottom +
                                        20.0,
                                  ),
                                ),
                                // Email
                                sizeH25(),
                                textFormField(
                                  context: context,
                                  theme: theme,
                                  controller: controller.emailCtr,
                                  textInputType: TextInputType.emailAddress,
                                  funValidate:
                                      (val) => controller.validateEmail(val),
                                  hintText: AppStrings.email,
                                  scrollPadding: EdgeInsets.only(
                                    top:
                                        MediaQuery.of(context).viewInsets.top +
                                        40.0,
                                    bottom:
                                        MediaQuery.of(
                                          context,
                                        ).viewInsets.bottom +
                                        20.0,
                                  ),
                                ),
                                sizeH25(),
                                // Password
                                Consumer<SignupViewModel>(
                                  builder: (context, value, child) {
                                    return textFormField(
                                      context: context,
                                      theme: theme,
                                      obsecureText: value.isObsecure,
                                      maxLines: 1,
                                      controller: controller.passwordCtr,
                                      textInputType: TextInputType.text,
                                      funValidate:
                                          (val) =>
                                              controller.validatePassword(val),
                                      hintText: AppStrings.password,
                                      suffixIcon: iconButton(
                                        onTap:
                                            () => controller.toggleObsecure(),
                                        icon: Icon(
                                          value.isObsecure
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                      scrollPadding: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(
                                              context,
                                            ).viewInsets.top +
                                            40.0,
                                        bottom:
                                            MediaQuery.of(
                                              context,
                                            ).viewInsets.bottom +
                                            20.0,
                                      ),
                                    );
                                  },
                                ),
                                sizeH25(),
                                // Confirm password
                                Consumer<SignupViewModel>(
                                  builder: (context, value, child) {
                                    return textFormField(
                                      context: context,
                                      theme: theme,
                                      obsecureText: value.isObsecureConPwd,
                                      maxLines: 1,
                                      controller: controller.confirmPwdCtr,
                                      textInputType: TextInputType.text,
                                      funValidate:
                                          (val) => controller
                                              .validateConfirmPassword(val),
                                      hintText: AppStrings.conPwd,
                                      suffixIcon: iconButton(
                                        onTap:
                                            () =>
                                                controller
                                                    .toggleObsecureConPwd(),
                                        icon: Icon(
                                          value.isObsecureConPwd
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                      scrollPadding: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(
                                              context,
                                            ).viewInsets.top +
                                            40.0,
                                        bottom:
                                            MediaQuery.of(
                                              context,
                                            ).viewInsets.bottom +
                                            20.0,
                                      ),
                                    );
                                  },
                                ),
                                sizeH25(),
                                // Phone number
                                textFormField(
                                  context: context,
                                  theme: theme,
                                  maxLength: 10,
                                  controller: controller.phoneNumberCtr,
                                  textInputType: TextInputType.number,
                                  funValidate:
                                      (val) =>
                                          controller.validatePhonenumber(val),
                                  hintText: AppStrings.phone_number,
                                  scrollPadding: EdgeInsets.only(
                                    top:
                                        MediaQuery.of(context).viewInsets.top +
                                        40.0,
                                    bottom:
                                        MediaQuery.of(
                                          context,
                                        ).viewInsets.bottom +
                                        20.0,
                                  ),
                                ),
                                sizeH25(),
                                // Gender
                                Consumer(
                                  builder: (context, value, child) {
                                    return DropdownButtonFormField<String>(
                                      validator:
                                          (value) => controller
                                              .validateGenderSelected(value),
                                      icon: Icon(
                                        Icons.arrow_drop_down_circle,
                                        color: AppColors.primaryColor,
                                      ),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey[700],
                                      ),
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: getBorderColor(theme),

                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        contentPadding: const EdgeInsets.only(
                                          top: 20,
                                          bottom: 20,
                                          left: 24,
                                          right: 10,
                                        ),

                                        errorStyle: const TextStyle(
                                          fontSize: 14,
                                        ),

                                        hintText: AppStrings.gender,
                                        hintStyle: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey[700],
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: getBorderColor(theme),
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: getBorderColor(theme),
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: getBorderColor(theme),
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: getBorderColor(theme),
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: getBorderColor(theme),
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                      ),
                                      value: controller.selectedGender,
                                      items:
                                          controller.genders.map((String item) {
                                            return DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(item),
                                            );
                                          }).toList(),
                                      onChanged: (String? newValue) {
                                        controller.changeValue(newValue);
                                      },
                                    );
                                  },
                                ),
                                sizeH25(),
                                // Country name
                                textFormField(
                                  context: context,
                                  theme: theme,
                                  controller: controller.countryCtr,
                                  textInputType: TextInputType.text,
                                  funValidate:
                                      (val) => controller.fieldIsRequired(val),
                                  hintText: AppStrings.country,
                                  scrollPadding: EdgeInsets.only(
                                    top:
                                        MediaQuery.of(context).viewInsets.top +
                                        40.0,
                                    bottom:
                                        MediaQuery.of(
                                          context,
                                        ).viewInsets.bottom +
                                        20.0,
                                  ),
                                ),
                                sizeH25(),
                                // State name
                                textFormField(
                                  context: context,
                                  theme: theme,
                                  controller: controller.stateCtr,
                                  textInputType: TextInputType.text,
                                  funValidate:
                                      (val) => controller.fieldIsRequired(val),
                                  hintText: AppStrings.state,
                                  scrollPadding: EdgeInsets.only(
                                    top:
                                        MediaQuery.of(context).viewInsets.top +
                                        40.0,
                                    bottom:
                                        MediaQuery.of(
                                          context,
                                        ).viewInsets.bottom +
                                        20.0,
                                  ),
                                ),
                                sizeH25(),
                                // City name
                                textFormField(
                                  context: context,
                                  theme: theme,
                                  controller: controller.cityCtr,
                                  textInputType: TextInputType.text,
                                  funValidate:
                                      (val) => controller.fieldIsRequired(val),
                                  hintText: AppStrings.city,
                                  scrollPadding: EdgeInsets.only(
                                    top:
                                        MediaQuery.of(context).viewInsets.top +
                                        40.0,
                                    bottom:
                                        MediaQuery.of(
                                          context,
                                        ).viewInsets.bottom +
                                        20.0,
                                  ),
                                ),
                                sizeH25(),
                                // Address
                                textFormField(
                                  maxLines: 3,
                                  context: context,
                                  theme: theme,
                                  controller: controller.addressCtr,
                                  textInputType: TextInputType.text,
                                  funValidate:
                                      (val) => controller.fieldIsRequired(val),
                                  hintText: AppStrings.address,
                                  scrollPadding: EdgeInsets.only(
                                    top:
                                        MediaQuery.of(context).viewInsets.top +
                                        40.0,
                                    bottom:
                                        MediaQuery.of(
                                          context,
                                        ).viewInsets.bottom +
                                        20.0,
                                  ),
                                ),
                                sizeH25(),
                                // DOB
                                textFormField(
                                  onTap: () => controller.pickDate(context),
                                  readOnly: true,
                                  context: context,
                                  theme: theme,
                                  controller: controller.dobCtr,
                                  textInputType: TextInputType.text,
                                  funValidate:
                                      (val) => controller.fieldIsRequired(val),
                                  hintText: AppStrings.dob,
                                  suffixIcon: Icon(
                                    Icons.date_range,
                                    color: AppColors.primaryColor,
                                  ),
                                  scrollPadding: EdgeInsets.only(
                                    top:
                                        MediaQuery.of(context).viewInsets.top +
                                        40.0,
                                    bottom:
                                        MediaQuery.of(
                                          context,
                                        ).viewInsets.bottom +
                                        20.0,
                                  ),
                                ),
                                sizeH25(),
                                // Pincode
                                textFormField(
                                  context: context,
                                  theme: theme,
                                  maxLength: 6,
                                  maxLines: 1,
                                  onlyNumber: true,
                                  controller: controller.pincodeCtr,
                                  textInputType: TextInputType.number,
                                  textInputAction: TextInputAction.done,
                                  funValidate:
                                      (val) => controller.validatePincode(val),
                                  hintText: AppStrings.pin_code,
                                  scrollPadding: EdgeInsets.only(
                                    top:
                                        MediaQuery.of(context).viewInsets.top +
                                        40.0,
                                    bottom:
                                        MediaQuery.of(
                                          context,
                                        ).viewInsets.bottom +
                                        20.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  sizeH25(),
                  Visibility(
                    visible: MediaQuery.of(context).viewInsets.bottom == 0,
                    child: Column(
                      children: [
                        simpleButton(
                          height: 55,
                          context,
                          onTap: () => controller.onNext(context),
                          title: text(
                            text: AppStrings.next,
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
          ],
        ),
      ),
    );
  }
}
