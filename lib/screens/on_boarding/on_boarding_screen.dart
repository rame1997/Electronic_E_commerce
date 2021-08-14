import 'package:electronic_e_commerce/utilities/app_colors.dart';
import 'package:electronic_e_commerce/utilities/size_config.dart';
import 'package:electronic_e_commerce/widgets/button.dart';
import 'package:electronic_e_commerce/widgets/on_boarding_content.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
// TODO: implement initState
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
// TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(
            right: SizeConfig.scaleWidth(16), left: SizeConfig.scaleWidth(16)),
        child: Stack(
          children: [
            PageView(
              controller: _pageController,
              onPageChanged: (int selectedPage) {
                setState(() {
                  _currentPage = selectedPage;
                });
              },
              children: [
                OnBoardingContent(
                  image: 'images/on_boarding1.svg',
                  title: AppLocalizations.of(context)!.on_boarding_title1,
                  sub_title:
                      AppLocalizations.of(context)!.on_boarding_sub_title1,
                ),
                OnBoardingContent(
                  image: 'images/on_boarding2.svg',
                  title: AppLocalizations.of(context)!.on_boarding_title2,
                  sub_title:
                      AppLocalizations.of(context)!.on_boarding_sub_title2,
                ),
                OnBoardingContent(
                  image: 'images/on_boarding3.svg',
                  title: AppLocalizations.of(context)!.on_boarding_title3,
                  sub_title:
                      AppLocalizations.of(context)!.on_boarding_sub_title3,
                ),
              ],
            ),
            Positioned(
              bottom: SizeConfig.scaleHeight(142),
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SmoothPageIndicator(
                        controller: _pageController,
                        count: 3,
                        axisDirection: Axis.horizontal,
                        effect: ExpandingDotsEffect(
                            spacing: 4.0,
                            radius: 4.0,
                            dotWidth: 10.0,
                            dotHeight: 8.0,
                            strokeWidth: 1.5,
                            expansionFactor: 3,
                            dotColor: AppColors.INDICATOR_DEFAULT_COLOR,
                            activeDotColor: AppColors.MAIN_COLORE),
                      ),
                      SizedBox(
                        height: SizeConfig.scaleHeight(15),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
                bottom: SizeConfig.scaleHeight(14),
                left: 0,
                right: 0,
                child: button(
                  text: AppLocalizations.of(context)!.getting_started,
                  color: AppColors.MAIN_COLORE,
                  onPressed: () {
                    Navigator.pushNamed(context, '/login_screen');
                  },
                ))
          ],
        ),
      ),
    );
  }
}
