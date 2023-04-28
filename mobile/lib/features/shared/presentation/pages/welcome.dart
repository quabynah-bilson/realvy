import 'package:flutter/material.dart';
import 'package:mobile/core/routing/router.dart';
import 'package:mobile/core/utils/extensions.dart';
import 'package:mobile/features/shared/presentation/widgets/page.indicator.dart';
import 'package:mobile/generated/assets.dart';
import 'package:shared_utils/shared_utils.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  late final _titles = [
        context.localizer.onboarding_1,
        context.localizer.onboarding_2,
        context.localizer.onboarding_3,
      ],
      _subtitles = [
        context.localizer.onboarding_1_subhead,
        context.localizer.onboarding_2_subhead,
        context.localizer.onboarding_3_subhead,
      ];
  final _images = [
        Assets.imgOb1,
        Assets.imgOb2,
        Assets.imgOb3,
      ],
      _pageController = PageController();
  var _currentPage = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (page) => setState(() => _currentPage = page),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => Container(
                  decoration: BoxDecoration(
                    color: context.colorScheme.background,
                  ),
                  child: _images[index].asAssetImage(),
                ),
              ),
            ),
            PageIndicator(count: _titles.length, currentIndex: _currentPage)
                .top(16),
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 16.0),
                child: AnimatedColumn(
                  animateType: AnimateType.slideRight,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _titles[_currentPage].h5(context),
                    _subtitles[_currentPage]
                        .bodyText1(context, alignment: TextAlign.center)
                        .top(16),
                    AppRoundedButton(
                      text: context.localizer.next,
                      onTap: () {
                        if (_currentPage == _titles.length - 1) {
                          context.navigator.pushNamedAndRemoveUntil(
                              AppRouter.loginRoute, (route) => false);
                          return;
                        }

                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 350),
                          curve: Curves.easeInOut,
                        );
                      },
                    ).top(40),
                    TextButton(
                            onPressed: () => context.navigator
                                .pushNamedAndRemoveUntil(
                                    AppRouter.loginRoute, (route) => false),
                            child: context.localizer.skip.button(context))
                        .top(16),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
