
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app_flutter/ui/screens/tabs/home%20screen/home_screen.dart';
import 'package:quiz_app_flutter/ui/screens/tabs/profile%20screen/profile_screen.dart';
import 'package:quiz_app_flutter/ui/screens/tabs/quiz%20screen/quizzes_screen.dart';

import '../../utlis/app_colors.dart';
import '../../utlis/app_text.dart';
import '../../utlis/app_routes .dart';
import 'package:provider/provider.dart';
import '../../../../providers/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../utlis/dialog_utlis.dart';

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
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, color: AppColors.onSurfaceVariantColor, size: width * 0.06),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Text('QuizArena', style: AppTextStyle.title20Primary),
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: AppColors.primaryColor),
              child: Consumer<MyUsersProvider>(
                builder: (context, authProvider, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuBgAbgjBZGWw1_zgZqEZHsTGewVUsdD3vrKTtVGwrpIl2ynMwHRM08E58Nzb92lQeceVHmt7XeFTSp7hbpnAbJaE9B-IKLBlC5ZW45fkEShGIHUYefUcb_1UD8WCIfqMqM86nQfFOyaBQQkILUz5yJwrhwVYBH9YiXRoDYdRG-_lP88NnYy6Cn851GoWN5br4p_ay5d2dWB7FZyTe625sdTfPm1vHQk1i_HyT0R9eKi7IN2ak397ODtHDP9gsB5cH60o1lPKmFwTGah'),
                      ),
                      const SizedBox(height: 10),
                      Text(authProvider.currentUser?.name ?? 'Arsheel Patel', style: AppTextStyle.title20Primary.copyWith(color: Colors.white)),
                    ],
                  );
                }
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context); 
                // We're already in the main wrapper, just need to set index if possible, but simplest is to do nothing or close drawer.
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                // Currently handled by bottom nav.
              },
            ),
            ListTile(
              leading: const Icon(Icons.emoji_events),
              title: const Text('Leaderboard (Tech Trivia)'),
              onTap: () {
                Navigator.pop(context); // Close drawer
                Navigator.pushNamed(context, AppRoutes.leaderboardScreen, arguments: 'tech-trivia');
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                // Functional settings dialog
                DialogUtlis.showDialogMessage(
                  context: context, 
                  title: 'Settings', 
                  middleText: 'Settings page coming soon!', 
                  buttonText: 'OK'
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log Out'),
              onTap: () async {
                final authService = AuthService();
                await FirebaseAuth.instance.signOut();
                try {
                  await authService.logout();
                  Provider.of<MyUsersProvider>(context, listen: false).clearUser();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    AppRoutes.loginScreen,
                        (route) => false,
                  );
                } catch (e) {
                  print(e);
                }
              },
            ),
          ],
        ),
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
