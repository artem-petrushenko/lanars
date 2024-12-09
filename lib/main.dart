import 'dart:async';

import 'package:lanars/src/core/utils/logger/refined_logger.dart';
import 'package:lanars/src/feature/app/logic/app_runner.dart';

void main() => runZonedGuarded(
      () => const AppRunner().initializeAndRun(),
      logger.logZoneError,
    );
