import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:study_buddy_app/components/buddy.dart';

class BuddyGame extends FlameGame with TapDetector, HasDraggableComponents {
  SpriteComponent buddy = SpriteComponent();
  SpriteComponent background = SpriteComponent();
  SpriteAnimationComponent buddyAnimation = SpriteAnimationComponent();
  bool tapEnabled = true;
  int moveCounter = 0;
  static const int MOVE_INTERVAL = 3;

  Buddy quatro = Buddy(
      image: "quatro.png",
      animation: "SqueeshQuatroAnimation.png",
      size: Vector2(212, 300),
      stepTime: 0.035);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(background
      ..sprite = await loadSprite("study_mode_bg.png")
      ..size = size);
    buddy
      ..sprite = await loadSprite(quatro.image)
      ..size = quatro.size
      ..y = size.y * 0.6
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
    var spritesheet = await images.load(quatro.animation);
    SpriteAnimationData spriteData = SpriteAnimationData.sequenced(
      amount: 11,
      textureSize: Vector2(212, 300),
      stepTime: quatro.stepTime,
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
    moveBuddy();
  }

  void moveBuddy() {
    // Increment the move counter
    moveCounter++;

    // Only move the buddy object every MOVE_INTERVAL ticks
    if (moveCounter >= MOVE_INTERVAL) {
      // Reset the move counter
      moveCounter = 0;

      // Generate a random horizontal direction
      bool moveRight = Random().nextBool();

      // Generate a random vertical movement distance between -5 and 5 pixels
      int moveY = Random().nextInt(11) - 5;

      // Determine the x movement distance based on the horizontal direction
      int moveX = moveRight ? 2 : -2;

      // Check if the new position will be within the bounds
      if (buddy.x + moveX >= 0 && buddy.x + moveX <= size.x*0.5 && buddy.y + moveY >= size.y*0.05 && buddy.y + moveY <= size.y*0.65) {
        // If the new position is within the bounds, update the buddy's position
        buddy.x += moveX;
        buddy.y += moveY;
      }
    }
  }
}
