part of '../dashboard.dart';

Widget _buildFeaturedHouseListHeader(BuildContext context) =>
    SliverToBoxAdapter(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          context.localizer.featured.h6(context),
          TextButton(
              // TODO show filter page
              onPressed: context.showFeatureUnderDevSheet,
              child: context.localizer.showMore
                  .button(context, color: context.colorScheme.secondary)),
        ],
      ).horizontal(20),
    );

Widget _buildFeaturedHouseList(BuildContext context) {
  final images = [
    Assets.imgApartments6,
    Assets.imgApartments5,
    Assets.imgApartments4,
  ];
  return SliverToBoxAdapter(
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.fromLTRB(
          20, 8, 20, context.mediaQuery.padding.bottom + 16),
      shrinkWrap: true,
      itemCount: images.length,
      separatorBuilder: (_, __) => const SizedBox(width: 16),
      itemBuilder: (context, index) =>
          FeaturedEstateListTile(key: UniqueKey(), image: images[index])
              .fillMaxWidth(context, 0.7),
    ).fillMaxHeight(context, 0.42),
  );
}
