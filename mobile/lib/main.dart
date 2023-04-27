import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile/core/app.dart';
import 'package:shared_utils/shared_utils.dart';

/// https://www.behance.net/gallery/166031945/LivingLodge-Real-Estate-Application
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // TODO -> add dependencies

  runZonedGuarded(
      () => runApp(const RealvyApp()), (error, stack) => logger.e(error));
}
