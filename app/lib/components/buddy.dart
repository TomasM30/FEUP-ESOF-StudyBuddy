import 'package:flame/components.dart';

class Buddy{
  final String image;
  final String animation;
  final Vector2 size;
  final double stepTime;
  final int spriteSize;


  const Buddy({
    required this.spriteSize,
    required this.stepTime,
    required this.image,
    required this.animation,
    required this.size,
  });
}