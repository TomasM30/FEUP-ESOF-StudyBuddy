import 'package:flutter_test/flutter_test.dart';
import 'package:study_buddy_app/Screens/Register/components/body.dart';


void main() {

  //! Needs refactoring for unit testing and code cleanup
  //TODO: Add the rest of the unit tests
  test('Initially email and password should be empty', () {
    final register = BodyState();
    expect(register.getEmail(), '');
    expect(register.getPassword(), '');
  });
}