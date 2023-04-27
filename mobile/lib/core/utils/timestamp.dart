import 'package:timeago/timeago.dart' as timeago;

String formatTimestamp(DateTime then) =>
    timeago.format(then, locale: 'en');
