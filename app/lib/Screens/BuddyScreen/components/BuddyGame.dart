import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/gestures.dart';
import 'package:study_buddy_app/Services/database.dart';
import 'package:study_buddy_app/Services/user_setting.dart';
import 'package:study_buddy_app/components/buddy.dart';
import 'package:study_buddy_app/components/shop_items.dart';

class BuddyGame extends FlameGame with TapDetector, DoubleTapDetector {
  DatabaseService databaseService = DatabaseService();
  List<SpriteComponent> components = [];
  int buddySelected = UserSettings.buddy;
  SpriteComponent buddy = SpriteComponent();
  SpriteComponent background = SpriteComponent();
  SpriteAnimationComponent buddyAnimation = SpriteAnimationComponent();
  SpriteAnimationComponent buddyHappyAnimation = SpriteAnimationComponent();
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

  List<ShopItem> items = UserSettings.purchased;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    print(UserSettings.streak);
    print(UserSettings.multiplier);
    print(UserSettings.lastLogIn);

    databaseService.getPurchases();
    add(background
      ..sprite = await loadSprite("study_mode_bg.png")
      ..size = size);

    for (int i = 0; i < items.length; i++) {
      SpriteComponent item = SpriteComponent()
        ..sprite = await loadSprite(items[i].image)
        ..size = Vector2(items[i].sizeX, items[i].sizeY)
        ..opacity = items[i].used ? 1 : 0
        ..y = size.y * items[i].posY
        ..x = size.x * items[i].posX;
      components.add(item);
      add(item);
    }

    buddy
      ..sprite = await loadSprite(buddies[buddySelected].image)
      ..size = buddies[buddySelected].size
      ..y = size.y * 0.35
      ..x = size.x * 0.25;
    add(buddy);
  }

  @override
  void onTapUp (TapUpInfo info)  {
    super.onTapUp(info);
    int counter = 0;
    SpriteComponent spriteComponentobject = components[0];
    final taplocation = info.eventPosition.game;
    bool poschanged = false;
    bool found = false;
    double posx = taplocation.x;
    double posy = taplocation.y;
    int j = 0;
    for(int i = 0; i < components.length; i++){
      final spriteComponent = components[i];
      if(!items[i].used){
        continue;
      }
      if(taplocation.x >= spriteComponent.x-75 && taplocation.x <= spriteComponent.x+75 && taplocation.y >= spriteComponent.y-75 && taplocation.y <= spriteComponent.y+75){
        counter++;
        spriteComponentobject = spriteComponent;
        found = true;
        j = i;
      }
      if (found){
        poschanged = true;
        posx = taplocation.x;
        posy = taplocation.y;
        found = false;
      }
    }
    if (counter > 0 && poschanged){
      spriteComponentobject.x = posx;
      spriteComponentobject.y = posy;
      items[j].posX = posx/size.x;
      items[j].posY = posy/size.y;
      databaseService.updatePurchases(items);
      counter = 0;
      poschanged = false;
    }
  }

  @override
  Future<void> onDoubleTap() async {
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
  Future<void> update(double dt) async {
    super.update(dt);
    /*if (UserSettings.sessions.isNotEmpty) {
      if((int.parse(UserSettings.sessions[UserSettings.sessions.length-1].day) - DateTime.now().day).abs() > 7){
        buddy.opacity = 0;
      }
    }*/




    if (buddyAnimation.isRemoved) {
      buddy.opacity = 1;
      tapEnabled = true;
    }

    moveCounter++;
    moveBuddy();
  }

  Future<void> moveBuddy() async {
    int steps = 1;

    void moveRight() {
      if (buddy.position.x + steps < size.x * 0.48) {
        buddy.position.x += steps;
      }
    }

    void moveLeft() {
      if (buddy.position.x + steps > 0) {
        buddy.position.x -= steps;
      }
    }

    void moveUp() {
      if (buddy.position.y + steps > size.y * 0.05) {
        buddy.position.y -= steps;
      }
    }

    void moveDown() {
      if (buddy.position.y + steps < size.y * 0.6) {
        buddy.position.y += steps;
      }
    }

    if (moveCounter % MOVE_INTERVAL == 0) {
      moveCounter = 0;
      direction = Random().nextInt(8);
      shouldStop = !shouldStop;
    }

    if (shouldStop) {
      switch (direction) {
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
