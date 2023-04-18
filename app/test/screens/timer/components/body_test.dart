import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dnd/flutter_dnd.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:study_buddy_app/Screens/Timer/components/body.dart';
import 'package:study_buddy_app/main.dart';

@GenerateNiceMocks([MockSpec<FlutterDnd>()])
import 'body_test.mocks.dart';
void main(){
  TestWidgetsFlutterBinding.ensureInitialized();
  
  group('Timer', () {
    test('Timer starting value should be 0', () {
      final timer = BodyState();
      expect(timer.duration, Duration());
    });

    test('Timer should be able to start', () {
      final timer = BodyState();
      timer.startTimer();
      expect(timer.timer, isNotNull);
    });
    /* testWidgets('After 2 seconds, timer should be 2 seconds', (WidgetTester tester) async{
      final timer = BodyState();
      await tester.pumpWidget(MaterialApp(home: Body()));
      print("Mounted");
      //await Future<void>.delayed(Duration(seconds: 2));
      print("2 seconds passed");
      expect(timer.duration, Duration(seconds: 0));
      timer.stopTimer();
    }); */

  });


  group('Music', () {
    BodyState music = BodyState();
 
    test('Music should be able to play', (){
      MyApp.music = true;
      music.setAudio();
      expect(music.audioPlayer, isNotNull);
      music.audioPlayer.onPlayerStateChanged.listen((event) {
        expect(event, PlayerState.PLAYING);
      });
    });

    test('Music should be able to stop', (){
      final music = BodyState();
      MyApp.music = false;
      music.setAudio();
      music.audioPlayer.onPlayerStateChanged.listen((event) {
        expect(event, PlayerState.PAUSED);
      });
    });
   });

   group('DND', () {
    /*
    testWidgets('If permission isnt granted, it should show the dialog', (tester) async{
      final flutter_dnd = MockFlutterDnd();
      when(flutter_dnd.isNotificationPolicyAccessGranted).thenAnswer((_) async => false);
      final dnd = BodyState();
      await tester.pumpWidget(Body(FlutterDnd: flutter_dnd));
      });
    });
    */

});
}