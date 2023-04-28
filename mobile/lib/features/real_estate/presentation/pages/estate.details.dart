import 'dart:math';

import 'package:dartz/dartz.dart' show Tuple3;
import 'package:flutter/material.dart';
import 'package:mobile/core/routing/router.dart';
import 'package:mobile/core/utils/extensions.dart';
import 'package:mobile/features/shared/presentation/widgets/page.indicator.dart';
import 'package:shared_utils/shared_utils.dart';

part "subpages/estate.details.amenities.dart";

part "subpages/estate.details.description.dart";

part "subpages/estate.details.financing.dart";

class EstateDetailsPage extends StatefulWidget {
  final String image;

  const EstateDetailsPage({Key? key, required this.image}) : super(key: key);

  @override
  State<EstateDetailsPage> createState() => _EstateDetailsPageState();
}

class _EstateDetailsPageState extends State<EstateDetailsPage> {
  late final _expandedHeight = context.height * 0.4;

  // randomly generate a price for this property between 10k and 100k
  late final _price = Random().nextInt(90000) + 10000;
  late var _principal = 0.00, _propertyTax = 0.00, _insurance = 0.00;

  @override
  void initState() {
    super.initState();
    _calculateMortgage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            collapsedHeight: kToolbarHeight,
            expandedHeight: _expandedHeight,
            actions: [
              IconButton(
                  // TODO share estate
                  onPressed: context.showFeatureUnderDevSheet,
                  icon: const Icon(TablerIcons.share)),
              IconButton(
                  // TODO add to favorite
                  onPressed: context.showFeatureUnderDevSheet,
                  icon: const Icon(TablerIcons.heart)),
            ],
            flexibleSpace: Hero(
              tag: widget.image,
              child: Container(
                decoration: BoxDecoration(
                  color: context.colorScheme.surface,
                  image: DecorationImage(
                    image: ResizeImage(AssetImage(widget.image),
                        height: _expandedHeight.toInt(),
                        width: context.width.toInt(),
                        allowUpscaling: true),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: const PageIndicator(count: 3, currentIndex: 0).vertical(12),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.only(left: 16),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                  color: context.colorScheme.onBackground
                      .withOpacity(kEmphasisLowest),
                  borderRadius: BorderRadius.circular(8)),
              child: context.localizer.houseType.caption(context,
                  color: context.colorScheme.onBackground,
                  weight: FontWeight.w600),
            ).align(Alignment.centerLeft),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAmenities(context),
                _buildDescription(context),
                _FinancingUI(
                    price: _price.toDouble(),
                    principal: _principal,
                    propertyTax: _propertyTax,
                    insurance: _insurance),

                // buy with this price
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    context.localizer.buyWithPrice
                        .subtitle1(context, weight: FontWeight.w600)
                        .top(16),

                    // price
                    '\$${_price..toStringAsFixed(2)}'
                        .h5(context,
                            weight: FontWeight.w600,
                            color: context.colorScheme.secondary)
                        .top(16),
                  ],
                ).top(20),
              ],
            ).horizontal(20).top(24),
          ),
          SliverSafeArea(
            top: false,
            sliver: SliverToBoxAdapter(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: AppRoundedButton(
                      text: context.localizer.survey,
                      outlined: true,
                      onTap: context.showFeatureUnderDevSheet,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: AppRoundedButton(
                      text: context.localizer.discuss,
                      onTap: () =>
                          // TODO pass the user model to the chat screen
                          context.navigator.pushNamed(AppRouter.chatRoute,
                              arguments: 'Quabynah Bilson'),
                    ),
                  ),
                ],
              ).horizontal(16).top(24),
            ),
          ),
        ],
      ),
    );
  }

  // given a price (e.g. 1200), return a tuple of (principal + interest of 60%,
  // property tax of 20% and insurance of 20%) of the price
  Tuple3<double, double, double> _getPriceBreakdown(double price) {
    final principalAndInterest = price * 0.6;
    final propertyTax = price * 0.27;
    final insurance = price * 0.13;

    return Tuple3(principalAndInterest, propertyTax, insurance);
  }

  // calculate the mortgage of this property
  void _calculateMortgage() {
    final breakdown = _getPriceBreakdown(_price.toDouble());

    setState(() {
      _principal = breakdown.value1;
      _propertyTax = breakdown.value2;
      _insurance = breakdown.value3;
    });
    logger.d(
        'principal: $_principal, property tax: $_propertyTax, insurance: $_insurance');
  }
}
