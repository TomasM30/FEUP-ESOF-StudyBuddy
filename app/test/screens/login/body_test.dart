import 'package:flutter_test/flutter_test.dart';
import 'package:study_buddy_app/Screens/Login/components/body.dart';

void main(){

  //! Needs refactoring for unit testing and code cleanup
  //TODO: Add the rest of the unit tests
  test('Initially email and password should be empty', () {
    final login = BodyState();
    expect(login.getEmail(), '');
    expect(login.getPassword(), '');
  });
}