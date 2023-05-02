
class ShopItem{
  final String image;
  final int coins;
  final String name;
  final int xp;
  bool used;
  final double sizeX;
  final double sizeY;
  double posX;
  double posY;

  ShopItem({
    required this.sizeX,
    required this.sizeY,
    required this.posX,
    required this.posY,
    this.used = false,
    required this.name,
    required this.xp,
    required this.coins,
    required this.image,
  });
}