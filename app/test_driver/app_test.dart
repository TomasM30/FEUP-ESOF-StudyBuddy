import 'dart:async';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'package:glob/glob.dart';

import 'steps/test_steps.dart';

Future<void> main() async {
  final config = FlutterTestConfiguration()
    ..defaultTimeout = new Duration(seconds: 50)
    ..features = [Glob(r"test_driver/features/NoNotsMusic.feature")]
    ..reporters = [
      ProgressReporter(),
    ]
    ..stepDefinitions = [
      HaveGiven(),
      TapSignUpButton(),
      HaveGiven2(),
      FormField(),
      HaveThen(),
    ]
    ..restartAppBetweenScenarios = true
    ..targetAppPath = "test_driver/app.dart";

  return GherkinRunner().execute(config);
}
