import 'package:electronic_e_commerce/getx/language_getx_controller.dart';
import 'package:electronic_e_commerce/preferences/user_preferences.dart';
import 'package:electronic_e_commerce/screens/about_screen.dart';
import 'package:electronic_e_commerce/screens/auth/active_account_screen.dart';
import 'package:electronic_e_commerce/screens/auth/change_password_screen.dart';
import 'package:electronic_e_commerce/screens/auth/create_account_screen.dart';
import 'package:electronic_e_commerce/screens/auth/forget_password_screen.dart';
import 'package:electronic_e_commerce/screens/auth/reset_password_screen.dart';
import 'package:electronic_e_commerce/screens/bottom_navigation_bar/bottom_navigation_bar_screen.dart';
import 'package:electronic_e_commerce/screens/bottom_navigation_bar/tab_bottom_navigation_bar/home_screen.dart';
import 'package:electronic_e_commerce/screens/bottom_navigation_bar/tab_bottom_navigation_bar/my_order.dart';
import 'package:electronic_e_commerce/screens/cart/cart.dart';
import 'package:electronic_e_commerce/screens/category_screen.dart';
import 'package:electronic_e_commerce/screens/contact_screen.dart';
import 'package:electronic_e_commerce/screens/last_product_screen.dart';
import 'package:electronic_e_commerce/screens/launch_screen.dart';
import 'package:electronic_e_commerce/screens/auth/login_screen.dart';
import 'package:electronic_e_commerce/screens/on_boarding/on_boarding_screen.dart';
import 'package:electronic_e_commerce/screens/profile_screen.dart';
import 'package:electronic_e_commerce/utilities/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'getx/city_getx_controller.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefController().initSharePre();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  LanguageGetxController language_getx_controller =
  Get.put(LanguageGetxController());

  @override
  Widget build(BuildContext context) {
      return  Obx(() {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme:
          ThemeData(
            appBarTheme: AppBarTheme(centerTitle: true, elevation: 0,
              color: Colors.transparent,
              iconTheme: IconThemeData(
                color: AppColors.MAIN_COLORE,
                size: 30,
              ),),
          ),
          initialRoute: '/launch_screen',

          routes: {
            '/launch_screen': (context) => LaunchScreen(),
            '/on_boarding_screen': (context) => OnBoardingScreen(),
            '/login_screen': (context) => LoginScreen(),
            '/create_account_screen': (context) => CreateAccountScreen(),
            '/forget_password_screen': (context) => ForgetPasswordScreen(),
            '/home_screen': (context) => HomeScreen(),
            '/bottom_navigation_bar_screen': (context) => BottomNavigationBarScreen(),
            '/category_screen': (context) => CategoryScreen(),
            '/last_product_screen': (context) => LastProductScreen(),
            '/change_password_screen': (context) => ChangePasswordScreen(),
            '/profile_screen': (context) => ProfileScreen(),
            '/contant_screen': (context) => ContantScreen(),
            '/about_screen': (context) => AboutScreen(),
            '/cart_screen': (context) => MyOrderProductsScreen(),



          },
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
           GlobalMaterialLocalizations.delegate,

          ],
          supportedLocales: [
            const Locale('en', ''),
            const Locale('ar', '')
          ],
          locale:Locale(language_getx_controller.languageCode.value),
        );

      });


  }
}

