part of '../estate.details.dart';

class _FinancingUI extends StatelessWidget {
  final double price, principal, propertyTax, insurance;

  const _FinancingUI({
    Key? key,
    required this.price,
    required this.principal,
    required this.propertyTax,
    required this.insurance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => AnimatedColumn(
        animateType: AnimateType.slideRight,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                      width: _getBarChartWidth(context, principal),
                      height: 8,
                      decoration: BoxDecoration(
                        color: context.colorScheme.secondary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ).right(8),
                    Container(
                      width: _getBarChartWidth(context, propertyTax),
                      height: 8,
                      decoration: BoxDecoration(
                        color: context.colorScheme.error,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ).right(8),
                    Container(
                      width: _getBarChartWidth(context, insurance),
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
              '\$${(price / 12).toStringAsFixed(0)}'
                  .h6(context, weight: FontWeight.w600),
            ],
          ),

          // principal + interest with respective indicator
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: context.colorScheme.secondary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  context.localizer.principal.subtitle1(context),
                ],
              ),
              '\$${(principal / 12).toStringAsFixed(0)}'
                  .subtitle1(context, weight: FontWeight.w600),
            ],
          ).top(16),

          // property tax with respective indicator
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: context.colorScheme.error,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  context.localizer.propertyTax.subtitle1(context),
                ],
              ),
              '\$${(propertyTax / 12).toStringAsFixed(0)}'
                  .subtitle1(context, weight: FontWeight.w600),
            ],
          ).top(4),

          // home insurance with respective indicator
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: context.colorScheme.tertiary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  context.localizer.homeInsurance.subtitle1(context),
                ],
              ),
              '\$${(insurance / 12).toStringAsFixed(0)}'
                  .subtitle1(context, weight: FontWeight.w600),
            ],
          ).top(4),
        ],
      );

// use the values of the principal, property tax and insurance to calculate
// the width of the bar chart between 0 and 1
  double _getBarChartWidth(BuildContext context, double value) =>
      (context.width * 0.65) * value / (principal + propertyTax + insurance);
}
