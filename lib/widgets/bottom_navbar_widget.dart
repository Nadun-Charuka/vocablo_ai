import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:vocablo_ai/constants/colors.dart';
import 'package:vocablo_ai/screens/translation_screen.dart';
import 'package:vocablo_ai/screens/word_list_screen.dart';
import 'package:vocablo_ai/screens/profile_screen.dart';

class BottomNavbarWidget extends StatefulWidget {
  const BottomNavbarWidget({super.key});

  @override
  State<BottomNavbarWidget> createState() => _BottomNavbarWidgetState();
}

class _BottomNavbarWidgetState extends State<BottomNavbarWidget> {
  int _currentIndex = 1;
  final List<Widget> _pages = [
    WordListScreen(),
    TranslationScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        index: 1,
        backgroundColor: isDark ? kDarkSlateBackground : kLightBackgroundColor,
        color:
            isDark ? kDarkAppBarBackgroundColor : kLightAppBarBackgroundColor,
        buttonBackgroundColor: kLightPrimaryColor, // Same in both themes
        animationDuration: Duration(milliseconds: 500),
        items: [
          Icon(
            Icons.menu_book,
            color: _currentIndex == 0 ? Colors.black : Colors.white,
            size: 30,
          ),
          Icon(
            Icons.add,
            color: _currentIndex == 1 ? Colors.black : Colors.white,
            size: 40,
          ),
          Icon(
            Icons.person,
            color: _currentIndex == 2 ? Colors.black : Colors.white,
            size: 30,
          ),
        ],
      ),
      body: _pages[_currentIndex],
    );
  }
}
