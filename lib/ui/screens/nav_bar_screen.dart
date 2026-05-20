
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app_flutter/ui/screens/tabs/home%20screen/home_screen.dart';
import 'package:quiz_app_flutter/ui/screens/tabs/profile%20screen/profile_screen.dart';
import 'package:quiz_app_flutter/ui/screens/tabs/quiz%20screen/quizzes_screen.dart';

import '../../utlis/app_colors.dart';
import '../../utlis/app_text.dart';

class mainWrapperScreen extends StatefulWidget {
  const mainWrapperScreen({super.key});

  @override
  State<mainWrapperScreen> createState() => _HomeScreenTabState();
}

class _HomeScreenTabState extends State<mainWrapperScreen> {
  int selectedIndex = 0;

  final selectedItem = [Icons.home, Icons.map, Icons.favorite];

  final unSelectedItem = [
    Icons.home_outlined,
    Icons.favorite_outline,
    Icons.info_outline,
  ];

  List<Widget> selectedWidget = [
    HomeScreen(),
    QuizzesHomeScreen(categoryId: ''),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var labels = [
      'home',
      'quizzes',
     'profile'
    ];

    return Scaffold(
     appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        leading: Icon(Icons.menu, color: AppColors.onSurfaceVariantColor, size: width * 0.06),
        title: Text('QuizMaster', style: AppTextStyle.title20Primary),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: width * 0.04),
            child: CircleAvatar(
              radius: width * 0.04,
              backgroundImage: const NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuBgAbgjBZGWw1_zgZqEZHsTGewVUsdD3vrKTtVGwrpIl2ynMwHRM08E58Nzb92lQeceVHmt7XeFTSp7hbpnAbJaE9B-IKLBlC5ZW45fkEShGIHUYefUcb_1UD8WCIfqMqM86nQfFOyaBQQkILUz5yJwrhwVYBH9YiXRoDYdRG-_lP88NnYy6Cn851GoWN5br4p_ay5d2dWB7FZyTe625sdTfPm1vHQk1i_HyT0R9eKi7IN2ak397ODtHDP9gsB5cH60o1lPKmFwTGah'),
            ),
          ),
        ],
        shape: Border(bottom: BorderSide(color: AppColors.outlineVariantColor, width: 1)),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      /********************/
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        backgroundColor: Theme.of(context).navigationBarTheme.backgroundColor,
        itemCount: 3,
        tabBuilder: (int index, bool isActive) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isActive ? selectedItem[index] : unSelectedItem[index],
                size: 24,
                color: AppColors.greyColor,
              ),
              const SizedBox(height: 4),
              Text(labels[index], style: AppTextStyle.normal12Grey),
            ],
          );
        },

        activeIndex: selectedIndex,
        gapLocation: GapLocation.none,
        notchSmoothness: NotchSmoothness.softEdge,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        onTap: (index) => setState(() => selectedIndex = index),
         
        //other params
      ),

      body: selectedWidget[selectedIndex],
    );
  }
}
