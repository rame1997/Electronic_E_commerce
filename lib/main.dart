import 'package:electronic_e_commerce/getx/language_getx_controller.dart';
import 'package:electronic_e_commerce/preferences/user_preferences.dart';
import 'package:electronic_e_commerce/screens/about_screen.dart';
import 'package:electronic_e_commerce/screens/address/add_address_screen.dart';
import 'package:electronic_e_commerce/screens/address/address_option_screen.dart';
import 'package:electronic_e_commerce/screens/auth/active_account_screen.dart';
import 'package:electronic_e_commerce/screens/auth/change_password_screen.dart';
import 'package:electronic_e_commerce/screens/auth/create_account_screen.dart';
import 'package:electronic_e_commerce/screens/auth/forget_password_screen.dart';
import 'package:electronic_e_commerce/screens/auth/reset_password_screen.dart';
import 'package:electronic_e_commerce/screens/bottom_navigation_bar/bottom_navigation_bar_screen.dart';
import 'package:electronic_e_commerce/screens/bottom_navigation_bar/tab_bottom_navigation_bar/home_screen.dart';
import 'package:electronic_e_commerce/screens/bottom_navigation_bar/tab_bottom_navigation_bar/my_order.dart';
import 'package:electronic_e_commerce/screens/card/add_card_screen.dart';
import 'package:electronic_e_commerce/screens/card/card_option_screen.dart';
import 'package:electronic_e_commerce/screens/cart/cart.dart';
import 'package:electronic_e_commerce/screens/categories/category_screen.dart';
import 'package:electronic_e_commerce/screens/contact_screen.dart';
import 'package:electronic_e_commerce/screens/payment/card_address_option_Screen.dart';
import 'package:electronic_e_commerce/screens/product/last_product_screen.dart';
import 'package:electronic_e_commerce/screens/launch_screen.dart';
import 'package:electronic_e_commerce/screens/auth/login_screen.dart';
import 'package:electronic_e_commerce/screens/on_boarding/on_boarding_screen.dart';
import 'package:electronic_e_commerce/screens/payment/payment_option.dart';
import 'package:electronic_e_commerce/screens/profile_screen.dart';
import 'package:electronic_e_commerce/utilities/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Database/db_provider.dart';
import 'firebase/fb_notifications.dart';
import 'getx/city_getx_controller.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefController().initSharePre();
  await Firebase.initializeApp();
  await FbNotifications.initNotifications();
  await DBProvider().initDatabase();

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
            '/cart_screen': (context) => CartScreen(),
            '/payment_option_screen': (context) => PaymentOptionScreen(),
            '/card_option_screen': (context) => CardOptionScreen(),
            '/address_option_screen': (context) => AddressOptionScreen(),
            '/add_card_screen': (context) => AddCardScreen(),
            '/add_address_screen': (context) => AddAddressScreen(),
            '/card_address_option_screen': (context) => CardAddressOptionScreen(),



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

