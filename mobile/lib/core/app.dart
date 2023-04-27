import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mobile/core/routing/router.dart';
import 'package:mobile/core/theme.dart';
import 'package:mobile/core/utils/extensions.dart';
import 'package:shared_utils/shared_utils.dart';

/// root widget for application
class RealvyApp extends StatefulWidget {
  const RealvyApp({Key? key}) : super(key: key);

  @override
  State<RealvyApp> createState() => _RealvyAppState();
}

class _RealvyAppState extends State<RealvyApp> {
  @override
  Widget build(BuildContext context) => DismissKeyboard(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateTitle: (context) => context.localizer.appName,
          theme: context.useLightTheme,
          darkTheme: context.useDarkTheme,
          themeMode: ThemeMode.light,
          // todo -> add support for dark mode
          onGenerateRoute: AppRouterConfig.setupRoutes,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          // locale: state is SuccessState<String> ? Locale(state.data) : null,
        ),
      );
}
