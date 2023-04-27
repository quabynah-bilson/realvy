import 'package:flutter/material.dart';
import 'package:mobile/core/routing/router.dart';
import 'package:mobile/core/utils/extensions.dart';
import 'package:mobile/generated/assets.dart';
import 'package:shared_utils/shared_utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loading = false;

  @override
  Widget build(BuildContext context) {
    kUseDefaultOverlays(context, statusBarBrightness: context.theme.brightness);
    return Scaffold(
      body: LoadingIndicator(
        isLoading: _loading,
        lottieAnimResource: Assets.animLoading,
        loadingAnimIsAsset: true,
        message: context.localizer.authenticating,
        child: AnimatedColumn(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Assets.imgAppLogo.asAssetImage(height: context.height * 0.15),
            context.localizer.appName.h5(context).top(16),
            context.localizer.appDesc.subtitle1(context).top(16),
            const SizedBox(height: 40),
            AppRoundedButton(
              text: context.localizer.continueWithGoogle,
              layoutSize: LayoutSize.matchParent,
              icon: TablerIcons.brand_google,
              outlined: true,
              // TODO implement google sign in
              onTap: context.showFeatureUnderDevSheet,
            ),
            AppRoundedButton(
              text: context.localizer.continueWithApple,
              layoutSize: LayoutSize.matchParent,
              icon: TablerIcons.brand_apple,
              // TODO implement apple sign in
              onTap: context.showFeatureUnderDevSheet,
            ).top(16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Expanded(
                  child: Divider(height: 40),
                ),
                context.localizer.or.subtitle2(context).horizontal(16),
                const Expanded(
                  child: Divider(height: 40),
                ),
              ],
            ).vertical(16),
            AppRoundedButton(
              text: context.localizer.signInWithEmail,
              layoutSize: LayoutSize.matchParent,
              backgroundColor: context.colorScheme.secondary,
              textColor: context.colorScheme.onSecondary,
              onTap: () async {
                var successful = await context.showLoginWithEmailSheet();
                if (successful is bool && successful) {
                  context.navigator.pushNamedAndRemoveUntil(
                      AppRouter.dashboardRoute, (route) => false);
                }
              },
            ),
            TextButton(
              onPressed: () =>
                  context.navigator.pushNamed(AppRouter.registerRoute),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: context.localizer.noAccountYet),
                    const TextSpan(text: ' '),
                    TextSpan(
                      text: context.localizer.signUp,
                      style: context.textTheme.labelLarge
                          ?.copyWith(color: context.colorScheme.secondary),
                    ),
                  ],
                ),
                style: context.textTheme.labelLarge
                    ?.copyWith(color: context.colorScheme.onBackground),
              ),
            ).top(16),
          ],
        ).horizontal(24).centered(),
      ),
    );
  }
}
