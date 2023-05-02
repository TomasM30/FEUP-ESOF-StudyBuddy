import 'package:study_buddy_app/components/sessions.dart';
import 'package:study_buddy_app/components/shop_items.dart';

class UserSettings {
  static String lastLogIn = "";
  static double multiplier = 1;
  static int streak = 1;
  static int xpAmount = 0;
  static int coinsAmount = 0;
  static int duration = 0;
  static int level = 0;
  static int buddy = 0;
  static bool music = false;
  static bool doNotDisturb = false;
  static List<ShopItem> purchased = [];
  static List<ShopItem> shop = [];
  static List<Session> sessions = [];
}