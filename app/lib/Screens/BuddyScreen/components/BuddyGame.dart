import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:study_buddy_app/Services/user_setting.dart';
import 'package:study_buddy_app/components/buddy.dart';

class BuddyGame extends FlameGame with TapDetector {
  int buddySelected = UserSettings.buddy;
  SpriteComponent buddy = SpriteComponent();
  SpriteComponent background = SpriteComponent();
  SpriteAnimationComponent buddyAnimation = SpriteAnimationComponent();
  bool tapEnabled = true;
  int moveCounter = 0;
  static const int MOVE_INTERVAL = 60;
  int direction = Random().nextInt(8);
  bool shouldStop = false;

  List<Buddy> buddies = [
    Buddy(
      image: "quatro.png",
      animation: "SqueeshQuatroAnimation.png",
      size: Vector2(212, 300),
      stepTime: 0.035,
      spriteSize: 11,
    ),
    Buddy(
      image: "Teresa.png",
      animation: "TeresaJumpingAnimation.png",
      size: Vector2(283, 400),
      stepTime: 0.028,
      spriteSize: 18,
    ),
    Buddy(
      image: "Dos_Santos.png",
      animation: "dosSantosAnimation.png",
      size: Vector2(283, 400),
      stepTime: 0.035,
      spriteSize: 0,
    ),
    Buddy(
      image: "JuanCarlos.png",
      animation: "JuanCarlosAnimation.png",
      size: Vector2(300, 425),
      stepTime: 0.035,
      spriteSize: 0,
    ),
  ];

  @override
  Future<void> onLoad() async {
    super.onLoad();

    add(background
      ..sprite = await loadSprite("study_mode_bg.png")
      ..size = size);
    buddy
      ..sprite = await loadSprite(buddies[buddySelected].image)
      ..size = buddies[buddySelected].size
      ..y = size.y * 0.35
      ..x = size.x * 0.25;
    add(buddy);
  }

  @override
  Future<void> onTap() async {
    if (!tapEnabled) {
      return;
    }
    tapEnabled = false;
    buddy.opacity = 0;
    var spritesheet = await images.load(buddies[buddySelected].animation);
    SpriteAnimationData spriteData = SpriteAnimationData.sequenced(
      amount: buddies[buddySelected].spriteSize,
      textureSize: buddies[buddySelected].size,
      stepTime: buddies[buddySelected].stepTime,
      loop: false,
    );
    buddyAnimation =
        SpriteAnimationComponent.fromFrameData(spritesheet, spriteData)
          ..x = buddy.x
          ..y = buddy.y
          ..removeOnFinish = true;
    add(buddyAnimation);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (buddyAnimation.isRemoved) {
      buddy.opacity = 1;
      tapEnabled = true;
    }
    moveCounter++;
    moveBuddy();
  }

  Future<void> moveBuddy()  async {

    int steps = 1;

    void moveRight() {
        if (buddy.position.x+steps < size.x*0.48) {
          buddy.position.x += steps;
        }
    }

    void moveLeft() {
      if (buddy.position.x+steps > 0) {
        buddy.position.x -= steps;
      }
    }

    void moveUp() {
      if (buddy.position.y+steps > size.y*0.05) {
        buddy.position.y -= steps;
      }
    }

    void moveDown()  {
      if (buddy.position.y+steps < size.y*0.6) {
        buddy.position.y += steps;
      }
    }


    if(moveCounter % MOVE_INTERVAL == 0){
      moveCounter = 0;
      direction = Random().nextInt(8);
      shouldStop = !shouldStop;
    }

    if (shouldStop){
      switch(direction){
        case 0:
          moveRight();
          break;
        case 1:
          moveLeft();
          break;
        case 2:
          moveUp();
          break;
        case 3:
          moveDown();
          break;
        case 4:
          moveUp();
          moveRight();
          break;
        case 5:
          moveUp();
          moveLeft();
          break;
        case 6:
          moveDown();
          moveRight();
          break;
        case 7:
          moveDown();
          moveLeft();
          break;
      }
    }
  }
}
