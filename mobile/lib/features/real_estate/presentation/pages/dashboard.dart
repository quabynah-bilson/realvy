import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:mobile/core/utils/extensions.dart';
import 'package:mobile/features/real_estate/presentation/widgets/estate.list.tile.dart';
import 'package:mobile/generated/assets.dart';
import 'package:shared_utils/shared_utils.dart';

part 'subpages/featured.estates.dart';

part 'subpages/trending.estates.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late final _headerHeight = context.height * 0.45;

  Widget get _buildHouseFinder => SliverAppBar(
        floating: true,
        pinned: true,
        toolbarHeight: kToolbarHeight,
        collapsedHeight: context.height * 0.3 + kToolbarHeight,
        expandedHeight: _headerHeight,
        leadingWidth: 32,
        leading: IconButton(
            // TODO show notification page
            onPressed: context.showFeatureUnderDevSheet,
            color: context.colorScheme.surface,
            icon: const Icon(TablerIcons.apps)),
        centerTitle: false,
        title: AnimatedColumn(
          animateType: AnimateType.slideRight,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            context.localizer.appName
                .h6(context, color: context.colorScheme.surface),
            context.localizer.appDesc.bodyText2(context,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                color: context.colorScheme.surface,
                emphasis: kEmphasisMedium),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: context.colorScheme.surface),
            child: IconButton(
                // TODO show notification page
                onPressed: context.showFeatureUnderDevSheet,
                color: context.colorScheme.onSurface,
                icon: const Icon(TablerIcons.bell)),
          ),
        ],
        flexibleSpace: Container(
          width: context.width,
          decoration: BoxDecoration(
            color: context.colorScheme.surface,
            image: DecorationImage(
              image: ResizeImage(
                  const AssetImage(Assets.imgApartmentsSkyscraper),
                  width: context.width.toInt(),
                  height: _headerHeight.toInt(),
                  allowUpscaling: true),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: GlassMorphism(
                  blurRadius: 5,
                  glassColor: context.colorScheme.onBackground,
                  child: const SizedBox.expand(),
                ),
              ),
              Positioned.fill(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 40),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    AppTextField(
                      context.localizer.searchHint,
                      background: context.colorScheme.surface,
                      prefixIcon: const Icon(TablerIcons.map_2),
                      inputType: TextInputType.streetAddress,
                      bottom: 0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: AppTextField(
                            context.localizer.houseType,
                            readOnly: true,
                            onTap: context.showFeatureUnderDevSheet,
                            // TODO: show house type picker
                            background: context.colorScheme.surface,
                            prefixIcon: const Icon(TablerIcons.home_check),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: AppTextField(
                            context.localizer.priceRange,
                            readOnly: true,
                            onTap: context.showFeatureUnderDevSheet,
                            // TODO: show price range picker
                            background: context.colorScheme.surface,
                            prefixIcon: const Icon(TablerIcons.home_dollar),
                          ),
                        ),
                      ],
                    ),
                    AppRoundedButton(
                      text: context.localizer.search,
                      onTap: context
                          .showFeatureUnderDevSheet, // TODO search for houses
                    ),
                  ],
                ).align(Alignment.bottomCenter),
              ),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    kUseDefaultOverlays(context, statusBarBrightness: context.theme.brightness);

    return Scaffold(
      body: AnimationLimiter(
        child: CustomScrollView(
          slivers: [
            /// header app bar
            _buildHouseFinder,

            /// trending houses list
            _buildTrendingHouseListHeader(context),
            _buildTrendingHouseList(context),

            /// featured houses list
            _buildFeaturedHouseListHeader(context),
            _buildFeaturedHouseList(context),
          ],
        ),
      ),
    );
  }
}
