import 'package:flame/components.dart';
import 'package:flame/game.dart';

class BuddyGame extends FlameGame {
  SpriteComponent quatro = SpriteComponent();
  SpriteComponent background = SpriteComponent();
  late SpriteComponent quatroSprite;
  late SpriteAnimationComponent quatroA;


  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(background
      ..sprite = await loadSprite("study_mode_bg.png")
      ..size = size);
    quatro
      ..sprite = await loadSprite("quatro.png")
      ..size = Vector2(300, 300)
      ..y = 150
      ..x = 50;
    add(quatro);
  }

  @override
  void update(double dt) {
    super.update(dt);
    quatro.x += 100 * dt;
    if (quatro.x > size.x) {
      quatro.x = -quatro.width;
    }
  }
}
