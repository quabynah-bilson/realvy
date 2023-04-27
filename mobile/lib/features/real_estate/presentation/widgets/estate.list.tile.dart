import 'package:flutter/material.dart';
import 'package:mobile/core/routing/router.dart';
import 'package:mobile/core/utils/extensions.dart';
import 'package:shared_utils/shared_utils.dart';

class FeaturedEstateListTile extends StatefulWidget {
  final String image;

  const FeaturedEstateListTile({Key? key, required this.image})
      : super(key: key);

  @override
  State<FeaturedEstateListTile> createState() => _FeaturedEstateListTileState();
}

class _FeaturedEstateListTileState extends State<FeaturedEstateListTile> {
  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => context.navigator.pushNamed(AppRouter.estateDetailsRoute, arguments: widget.image),
        child: Container(
          width: context.width,
          height: context.height * 0.42,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: context.colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            children: [
              // TODO: replace with real image
              Positioned.fill(
                child:
                    Hero(tag: widget.image, child: widget.image.asAssetImage()),
              ),

              // TODO: replace with real data
              Positioned(
                top: 16,
                left: 16,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                      color: context.colorScheme.secondary,
                      borderRadius: BorderRadius.circular(8)),
                  child: context.localizer.forSale.caption(context,
                      color: context.colorScheme.onSecondary,
                      weight: FontWeight.w600),
                ),
              ),

              Positioned(
                top: 16,
                right: 16,
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.colorScheme.surface),
                  child: IconButton(
                      // TODO show notification page
                      onPressed: context.showFeatureUnderDevSheet,
                      color: context.colorScheme.onSurface,
                      icon: const Icon(TablerIcons.hearts)),
                ),
              ),

              // TODO: replace with real data
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: GlassMorphism(
                  glassColor: context.colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  padding: const EdgeInsets.all(16),
                  border:
                      Border.all(color: context.colorScheme.surface, width: 1),
                  child: SizedBox(
                    width: context.width,
                    // TODO: replace with real data
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        '3 Bedroom Apartment'
                            .h6(context, color: context.colorScheme.onSurface),
                        '3234 Despard Street, Atlanta'
                            .bodyText2(context,
                                color: context.colorScheme.onSurface,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                emphasis: kEmphasisMedium)
                            .top(4),
                        '\$1232.59'
                            .subtitle1(context,
                                color: context.colorScheme.secondary,
                                overflow: TextOverflow.ellipsis,
                                weight: FontWeight.w600,
                                maxLines: 1)
                            .top(4),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
}

class TrendingEstateListTile extends StatelessWidget {
  final String image;

  const TrendingEstateListTile({Key? key, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final widgetHeight = context.height * 0.22;
    return GestureDetector(
      onTap: () => context.navigator.pushNamed(AppRouter.estateDetailsRoute, arguments: image),
      child: Container(
        height: widgetHeight,
        padding: const EdgeInsets.all(8),
        width: context.width,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: context.width * 0.3,
              height: widgetHeight,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: context.colorScheme.background,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                    topRight: Radius.circular(4),
                    bottomRight: Radius.circular(4)),
              ),
              child: Hero(tag: image, child: image.asAssetImage()),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    '3 Bedroom Apartment'.subtitle1(context,
                        weight: FontWeight.w600,
                        color: context.colorScheme.onSurface),
                    '3234 Despard Street, Atlanta'.bodyText2(context,
                        color: context.colorScheme.onSurface,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        emphasis: kEmphasisMedium),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              TablerIcons.bed,
                              color: context.colorScheme.onSurface,
                              size: 16,
                            ),
                            '3'
                                .bodyText2(context,
                                    color: context.colorScheme.onSurface,
                                    weight: FontWeight.w600)
                                .left(4),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              TablerIcons.bath,
                              color: context.colorScheme.onSurface,
                              size: 16,
                            ),
                            '2'
                                .bodyText2(context,
                                    color: context.colorScheme.onSurface,
                                    weight: FontWeight.w600)
                                .left(4),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              TablerIcons.map_pin,
                              color: context.colorScheme.onSurface,
                              size: 16,
                            ),
                            '3,3km'
                                .bodyText2(context,
                                    color: context.colorScheme.onSurface,
                                    weight: FontWeight.w600)
                                .left(4),
                          ],
                        ),
                      ],
                    ).vertical(8),
                    const Spacer(),
                    '\$1232.59'.subtitle1(context,
                        color: context.colorScheme.secondary,
                        overflow: TextOverflow.ellipsis,
                        weight: FontWeight.w600,
                        maxLines: 1),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
