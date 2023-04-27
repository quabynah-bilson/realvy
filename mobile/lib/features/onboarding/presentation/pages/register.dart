import 'package:flutter/material.dart';
import 'package:mobile/core/routing/router.dart';
import 'package:mobile/core/utils/extensions.dart';
import 'package:mobile/core/utils/validator.dart';
import 'package:mobile/generated/assets.dart';
import 'package:shared_utils/shared_utils.dart';

class RegisterAccountPage extends StatefulWidget {
  const RegisterAccountPage({Key? key}) : super(key: key);

  @override
  State<RegisterAccountPage> createState() => _RegisterAccountPageState();
}

class _RegisterAccountPageState extends State<RegisterAccountPage> {
  final _formKey = GlobalKey<FormState>(),
      _phoneNumberController = TextEditingController(),
      _usernameController = TextEditingController(),
      _passwordController = TextEditingController(),
      _fullNameController = TextEditingController();
  var _loading = false;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(),
        body: LoadingIndicator(
          isLoading: _loading,
          message: context.localizer.authenticating,
          loadingAnimIsAsset: true,
          lottieAnimResource: Assets.animLoading,
          child: Form(
            key: _formKey,
            child: AnimatedListView(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
              children: [
                context.localizer.createAccount.h5(context).bottom(40),
                AppTextField(
                  context.localizer.fullName,
                  controller: _fullNameController,
                  validator: Validators.validate,
                  capitalization: TextCapitalization.words,
                  prefixIcon: const Icon(TablerIcons.id_badge),
                ),
                AppTextField(
                  context.localizer.username,
                  controller: _usernameController,
                  validator: (input) =>
                      Validators.validateEmail(context, input),
                  prefixIcon: const Icon(TablerIcons.mail),
                ),
                AppTextField(
                  context.localizer.phoneNumber,
                  controller: _phoneNumberController,
                  textFieldType: AppTextFieldType.phone,
                  validator: (input) =>
                      Validators.validatePhone(context, input),
                  prefixIcon: const Icon(TablerIcons.phone_plus),
                  maxLength: 10,
                ),
                AppTextField(
                  context.localizer.password,
                  controller: _passwordController,
                  validator: (input) =>
                      Validators.validatePassword(context, input),
                  textFieldType: AppTextFieldType.password,
                  prefixIcon: const Icon(Icons.password),
                ),
                AppRoundedButton(
                        text: context.localizer.signUp,
                        backgroundColor: context.colorScheme.secondary,
                        textColor: context.colorScheme.onSecondary,
                        onTap: _validateAndSubmit)
                    .centered(),
              ],
            ),
          ),
        ),
      );

  void _validateAndSubmit() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _loading = true);
      await Future.delayed(const Duration(seconds: 2));
      setState(() => _loading = false);
      context.navigator
          .pushNamedAndRemoveUntil(AppRouter.dashboardRoute, (route) => false);
    }
  }
}
