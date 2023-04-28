part of '../estate.details.dart';

Widget _buildAmenities(BuildContext context) => AnimatedColumn(
      animateType: AnimateType.slideLeft,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // name
        'Blue Small House in the Water'.h5(context),

        // address
        '2342 Street, New York'.subtitle2(context, emphasis: kEmphasisMedium),

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
                        '4,120 sqft'.toString().bodyText2(context).left(8),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ).vertical(16).horizontal(20),
      ],
    );
