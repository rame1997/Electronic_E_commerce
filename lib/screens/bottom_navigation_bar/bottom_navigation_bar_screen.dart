import 'package:electronic_e_commerce/screens/bottom_navigation_bar/tab_bottom_navigation_bar/common_questions_screen.dart';
import 'package:electronic_e_commerce/screens/bottom_navigation_bar/tab_bottom_navigation_bar/my_order.dart';
import 'package:electronic_e_commerce/screens/bottom_navigation_bar/tab_bottom_navigation_bar/favorite_screen.dart';
import 'package:electronic_e_commerce/screens/bottom_navigation_bar/tab_bottom_navigation_bar/home_screen.dart';
import 'package:electronic_e_commerce/screens/bottom_navigation_bar/tab_bottom_navigation_bar/setting_screen.dart';
import 'package:electronic_e_commerce/utilities/app_colors.dart';
import 'package:electronic_e_commerce/utilities/size_config.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:electronic_e_commerce/firebase/fb_notifications.dart';



class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({Key? key}) : super(key: key);

  @override
  _BottomNavigationBarScreenState createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> with FbNotifications{
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    MyOrderProductsScreen(),
    FavoriteProductsScreen(),
    SettingScreen(),
    CommonQuestionsScreen(),
  ];
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeForegroundNotificationForAndroid();
    manageNotificationAction();
    FirebaseMessaging.instance.getToken();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BACKGROUND_HOME,
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: AppLocalizations.of(context)!.home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: AppLocalizations.of(context)!.my_order,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: AppLocalizations.of(context)!.favorite,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: AppLocalizations.of(context)!.setting,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_answer),
            label: AppLocalizations.of(context)!.faqs,
          ),
        ],
        currentIndex: _selectedIndex,
        backgroundColor: Colors.white,
        onTap: _onItemTapped,
        iconSize: SizeConfig.scaleHeight(22),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.MAIN_COLORE,
        unselectedItemColor: AppColors.grey,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        unselectedFontSize: SizeConfig.scaleTextFont(10),
        selectedFontSize: SizeConfig.scaleTextFont(10),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

}
