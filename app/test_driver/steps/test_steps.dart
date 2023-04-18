import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class HaveGiven extends Given2WithWorld<String, String, FlutterWorld> {
  @override
  Future<void> executeStep(String button1, String button2) async {
    final button1Finder = find.byValueKey(button1);
    final button2Finder = find.byValueKey(button2);
    await FlutterDriverUtils.isPresent(world.driver, button1Finder);
    await FlutterDriverUtils.isPresent(world.driver, button2Finder);
  }

  @override
  RegExp get pattern => RegExp(r'I have {string} and {string}');
}

class TapSignUpButton extends Then1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String button1) async {
    final signupButtonFinder = find.byValueKey(button1);
    await FlutterDriverUtils.tap(world.driver, signupButtonFinder);
  }

  @override
  RegExp get pattern => RegExp(r'I tap on the {string} button');
}

class HaveGiven2 extends Given3WithWorld<String, String, String, FlutterWorld> {
  @override
  Future<void> executeStep(
      String button1, String button2, String button3) async {
    final button1Finder = find.byValueKey(button1);
    final button2Finder = find.byValueKey(button2);
    final button3Finder = find.byValueKey(button3);
    await FlutterDriverUtils.isPresent(world.driver, button1Finder);
    await FlutterDriverUtils.isPresent(world.driver, button2Finder);
    await FlutterDriverUtils.isPresent(world.driver, button3Finder);
  }

  @override
  RegExp get pattern => RegExp(r'I have {string} and {string} and {string}');
}

class FormField extends When2WithWorld<String, String, FlutterWorld> {
  @override
  Future<void> executeStep(String button1, String button2) async {
    final button1Finder = find.byValueKey(button1);
    await FlutterDriverUtils.tap(world.driver, button1Finder);
    await FlutterDriverUtils.enterText(world.driver, button1Finder, button2);
  }

  @override
  RegExp get pattern => RegExp(r'I press the {String} and type {String}');
}

class HaveThen extends Then1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String button1) async {
    final signupButtonFinder = find.byValueKey(button1);
    await FlutterDriverUtils.tap(world.driver, signupButtonFinder);
    await Future.delayed(Duration(seconds: 5));
  }

  @override
  RegExp get pattern => RegExp(r'I have {string}');
}
