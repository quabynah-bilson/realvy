part of '../dashboard.dart';

Widget _buildTrendingHouseListHeader(BuildContext context) =>
    SliverToBoxAdapter(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          context.localizer.trending.h6(context),
          TextButton(
              // TODO show filter page
              onPressed: context.showFeatureUnderDevSheet,
              child: context.localizer.showMore
                  .button(context, color: context.colorScheme.secondary)),
        ],
      ).horizontal(20).top(8),
    );

Widget _buildTrendingHouseList(BuildContext context) {
  final images = [
    Assets.imgApartments3,
    Assets.imgApartments2,
    Assets.imgApartments1,
  ];
  return SliverToBoxAdapter(
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
      shrinkWrap: true,
      itemCount: images.length,
      separatorBuilder: (_, __) => const SizedBox(width: 16),
      itemBuilder: (context, index) =>
          TrendingEstateListTile(key: UniqueKey(), image: images[index])
              .fillMaxWidth(context, 0.8),
    ).fillMaxHeight(context, 0.22),
  );
}
