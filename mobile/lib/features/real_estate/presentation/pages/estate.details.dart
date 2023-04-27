import 'dart:math';

import 'package:dartz/dartz.dart' show Tuple3;
import 'package:flutter/material.dart';
import 'package:mobile/core/utils/extensions.dart';
import 'package:mobile/features/shared/presentation/widgets/page.indicator.dart';
import 'package:shared_utils/shared_utils.dart';

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
                    image: AssetImage(widget.image),
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
            child: AnimatedColumn(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // name
                'Blue Small House in the Water'.h5(context),

                // address
                '2342 Street, New York'
                    .subtitle2(context, emphasis: kEmphasisMedium),

                // amenities (3 bedrooms, 2 bathrooms, 1 garage & 4,120 sqft)
                Opacity(
                  opacity: kEmphasisMedium,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            // bedrooms
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(TablerIcons.bed),
                                '3 Bedrooms'.bodyText2(context).left(8),
                              ],
                            ),

                            // bathrooms
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(TablerIcons.bath),
                                '2 Bathrooms'.bodyText2(context).left(8),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            // garage
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(TablerIcons.car),
                                '1 Garage'.bodyText2(context).left(8),
                              ],
                            ),

                            // sqft
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(TablerIcons.home),
                                '4,120 sqft'
                                    .toString()
                                    .bodyText2(context)
                                    .left(8),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ).vertical(16).horizontal(20),

                // description
                context.localizer.description
                    .subtitle1(context, weight: FontWeight.w600)
                    .top(16)
                    .bottom(8),
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                        'Sed euismod, diam ac tincidunt dignissim, '
                        'nu lla libero ultrices nunc, quis aliquet elit '
                    .subtitle1(context),

                // monthly expenses
                context.localizer.monthlyExpenses
                    .subtitle1(context, weight: FontWeight.w600)
                    .top(16)
                    .bottom(8),
                Row(
                  children: [
                    // price breakdown
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: _getBarChartWidth(_principal),
                            height: 8,
                            decoration: BoxDecoration(
                              color: context.colorScheme.primary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ).right(8),
                          Container(
                            width: _getBarChartWidth(_propertyTax),
                            height: 8,
                            decoration: BoxDecoration(
                              color: context.colorScheme.error,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ).right(8),
                          Container(
                            width: _getBarChartWidth(_insurance),
                            height: 8,
                            decoration: BoxDecoration(
                              color: context.colorScheme.tertiary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 8),

                    // price
                    '\$${(_price / 12).toStringAsFixed(0)}'.h5(context, weight: FontWeight.w600),
                  ],
                ),
              ],
            ).horizontal(20).top(24),
          )
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

  // use the values of the principal, property tax and insurance to calculate
  // the width of the bar chart between 0 and 1
  double _getBarChartWidth(double value) {
    logger.d('value: $value, total: ${_principal + _propertyTax + _insurance}');
    return (context.width * 0.65) * value / (_principal + _propertyTax + _insurance);
  }
}
