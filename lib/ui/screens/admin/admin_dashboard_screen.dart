import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../utlis/app_colors.dart';
import '../../../utlis/app_text.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({Key? key}) : super(key: key);

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text('Admin Dashboard', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.black),
            onPressed: () {
              // Logout logic
              Provider.of<MyUsersProvider>(context, listen: false).clearUser();
              Navigator.pushReplacementNamed(context, '/loginScreen');
            },
          )
        ],
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'Quizzes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Scores',
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (_currentIndex == 0) {
      return Center(child: Text("Manage Quizzes - Coming soon!", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black)));
    } else {
      return Center(child: Text("Student Analytics - Coming soon!", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black)));
    }
  }
}
