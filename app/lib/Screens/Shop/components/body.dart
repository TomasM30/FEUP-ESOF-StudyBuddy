import 'package:flutter/material.dart';
import 'package:study_buddy_app/Screens/BuddyScreen/main_screen.dart';
import 'package:study_buddy_app/Screens/Shop/components/background.dart';
import 'package:study_buddy_app/Services/database.dart';
import 'package:study_buddy_app/Services/user_setting.dart';
import 'package:study_buddy_app/components/custom_button.dart';
import 'package:study_buddy_app/components/custom_button_color.dart';
import 'package:study_buddy_app/components/shop_items.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  BodyState createState() => BodyState();
}

class BodyState extends State<Body> {
  DatabaseService databaseService = DatabaseService();

  @override
  void initState() {
    super.initState();
  }

  bool itemExistsInShopAndPurchased(ShopItem item) {
    return UserSettings.shop.any((shopItem) => shopItem.name == item.name) &&
        UserSettings.purchased
            .any((purchasedItem) => purchasedItem.name == item.name);
  }

  ShopItem getItemPurchased(ShopItem item) {
    return UserSettings.purchased[UserSettings.purchased
        .indexWhere((element) => element.name == item.name)];
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Background(
          child: Container(
            margin: EdgeInsets.only(top: screenHeight * 0.4),
            child: ListView.builder(
              itemCount: UserSettings.shop.length,
              itemBuilder: (BuildContext context, int index) {
                ShopItem item = UserSettings.shop[index];
                bool xpNeeded =
                    UserSettings.xpAmount < UserSettings.shop[index].xp;
                bool coinsNeeded =
                    UserSettings.coinsAmount < UserSettings.shop[index].coins;
                return ListTile(
                  leading: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: 44,
                      minHeight: 44,
                      maxWidth: 64,
                      maxHeight: 64,
                    ),
                    child: xpNeeded
                        ? Icon(Icons.lock)
                        : Image.asset('assets/images/${item.image}'),
                  ),
                  title: Text(
                    item.name,
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: "Arial",
                      decoration: TextDecoration.underline,
                      decorationThickness: 2,
                      decorationColor: Color(0xffdcdcc2),
                    ),
                  ),
                  subtitle: itemExistsInShopAndPurchased(item)
                      ? null
                      : Text(
                          "Coins: ${item.coins.toString()}"
                          "\nXP: ${item.xp.toString()}",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontFamily: "Arial")),
                  trailing: !xpNeeded
                      ? CustomButtons(
                          width: screenWidth * 0.15,
                          iconSrc: !itemExistsInShopAndPurchased(item)
                              ? "assets/icons/shop.svg"
                              : (getItemPurchased(item).used
                                  ? "assets/icons/used.svg"
                                  : "assets/icons/money.svg"),
                          press: () async {
                            if (itemExistsInShopAndPurchased(item)) {
                              if (getItemPurchased(item).used) {
                                getItemPurchased(item).used = false;
                                databaseService
                                    .updatePurchases(UserSettings.purchased);
                              } else {
                                getItemPurchased(item).used = true;
                                databaseService
                                    .updatePurchases(UserSettings.purchased);
                              }
                            } else {
                              if (!coinsNeeded) {
                                UserSettings.coinsAmount -= item.coins;
                                UserSettings.purchased.add(item);
                                databaseService
                                    .updatePurchases(UserSettings.purchased);
                                databaseService
                                    .updateCoins(UserSettings.coinsAmount);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Not enough coins"),
                                  ),
                                );
                              }
                            }
                            setState(() {});
                          },
                          /*child: Text(
                            itemExistsInShopAndPurchased(item)
                                ? (getItemPurchased(item).used
                                    ? 'Unuse'
                                    : 'Use')
                                : 'Buy',
                          )*/
                        )
                      : null,
                );
              },
            ),
          ),
        ),
        Positioned(
          top: screenHeight * 0.17,
          left: screenWidth * 0.05,
          child: Row(children: [
            Stack(children: [
              CustomButtons(
                width: 90,
                iconSrc: 'assets/icons/newLevelStar.svg',
              ),
              Positioned(
                top: screenWidth * 0.08,
                left: screenWidth * 0.06,
                child: Text(
                  "XP",
                  style: TextStyle(
                      fontSize: 40,
                      color: Color(0xffffffff),
                      fontFamily: "Wishes"),
                ),
              )
            ]),
            Padding(
              padding: EdgeInsets.only(left: screenWidth * 0.02),
              child: Text(
                "${UserSettings.xpAmount}",
                style: TextStyle(
                    fontSize: 40,
                    color: Color(0xffffffff),
                    fontFamily: "Wishes"),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: screenWidth * 0.2),
              child: CustomButtons(
                width: 70,
                iconSrc: 'assets/icons/money.svg',
              ),
            ),
            Text(
              "\$${UserSettings.coinsAmount}",
              style: TextStyle(
                  fontSize: 40, color: Colors.white, fontFamily: "Wishes"),
            ),
          ]),
        ),
        Padding(
          padding: EdgeInsets.only(top: screenHeight * 0.05),
          child: Align(
            alignment: Alignment.topCenter,
            child: Text(
              "SHOP",
              style: TextStyle(
                  fontSize: 80, color: Colors.white, fontFamily: 'Content'),
            ),
          ),
        ),
        Positioned(
          top: screenHeight * 0.01,
          left: screenWidth * 0.03,
          child: CustomButtonsColor(
            iconSrc: "assets/icons/go-back-simple.svg",
            press: () {
              if (!mounted) return;
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return MainScreen();
                  },
                ),
              );
            },
            color: Color(0xd0f3edd7),
          ),
        ),
      ],
    );
  }
}
