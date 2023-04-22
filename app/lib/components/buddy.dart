import 'package:flame/components.dart';

class Buddy{
  final String image;
  final String animation;
  final Vector2 size;
  final double stepTime;

  const Buddy({
    required this.stepTime,
    required this.image,
    required this.animation,
    required this.size,
  });
}