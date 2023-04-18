import 'dart:async';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:study_buddy_app/Services/auth.dart';

class DatabaseService {
  final AuthService _authService = AuthService();

  Future<void> importData() async {
    try {
      final user = _authService.getCurrentUser();
      if (await checkKeyExistence(user!.uid)) {
        print('Node already exists with UID: ${user.uid}');
        return;
      }
      final data = {
        'email': user.email,
        'xp': 1,
        'level': 1,
        'coins': 0,
        'streak': 0,
      };
      FirebaseDatabase.instance.ref().child("Users").child(user.uid).set(data);
    } on FirebaseException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  Future<bool> checkKeyExistence(String key) async {
    try {
      final user = _authService.getCurrentUser();
      DatabaseReference reference =
          FirebaseDatabase.instance.ref().child('Users').child(user!.uid);
      DatabaseEvent snapshot = (await reference.once());
      return snapshot.snapshot.value != null;
    } on FirebaseException catch (e) {
      print(e);
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<int?> getXp() async {
    try {
      final userId = _authService.getCurrentUser()!.uid;
      final ref = FirebaseDatabase.instance.ref();
      final snapshot = await ref.child('Users/$userId/xp').get();
      final xpValue = snapshot.value as int?;
      return xpValue;
    } on FirebaseException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<int?> getCoins() async {
    try {
      final userId = _authService.getCurrentUser()!.uid;
      final ref = FirebaseDatabase.instance.ref();
      final snapshot = await ref.child('Users/$userId/coins').get();
      final coins = snapshot.value as int?;
      return coins;
    } on FirebaseException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<int?> getLevel() async {
    try {
      final userId = _authService.getCurrentUser()!.uid;
      final ref = FirebaseDatabase.instance.ref();
      final snapshot = await ref.child('Users/$userId/level').get();
      final level = snapshot.value as int?;
      return level;
    } on FirebaseException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<int> getLvl(int xp) async {
    int level =
        min(20, (log(xp) / log(pow(e, ((log(44640)) / 19)))).floor() + 1);
    return level;
  }

  Future<void> updateXp(int xp) async {
    try {
      final uid = _authService.getCurrentUser()!.uid;
      DatabaseReference xpRef =
          FirebaseDatabase.instance.ref().child("Users").child(uid);
      await xpRef.update({"xp": xp});
    } on FirebaseException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateLevel(int lvl) async {
    try {
      final uid = _authService.getCurrentUser()!.uid;
      DatabaseReference xpRef =
          FirebaseDatabase.instance.ref().child("Users").child(uid);
      await xpRef.update({"level": lvl});
    } on FirebaseException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  int getNextLvlXp(int lvl) {
    int xp = pow(e,
            (pow(e, ((log(44640)) / 19)) * (lvl) - pow(e, ((log(44640)) / 19))))
        .floor();
    return xp;
  }
}
