part of '../estate.details.dart';

Widget _buildDescription(BuildContext context) => AnimatedColumn(
      animateType: AnimateType.slideRight,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // description
        context.localizer.description
            .subtitle1(context, weight: FontWeight.w600)
            .top(16)
            .bottom(8),
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
            'Sed euismod, diam ac tincidunt dignissim, '
            'nu lla libero ultrices nunc, quis aliquet elit '
            .subtitle1(context),
      ],
    );
