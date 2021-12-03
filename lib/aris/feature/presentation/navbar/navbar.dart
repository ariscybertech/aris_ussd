import 'package:aris_ussd/aris/feature/presentation/navbar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';

enum ThemeStyle {
  Dribbble,
  Light,
  NoElevation,
  AntDesign,
  BorderRadius,
  FloatingBar,
  NotificationBadge,
  WithTitle,
  BlurEffect
}

class Navbar extends StatefulWidget {
  Navbar({Key key, this.title}) : super(key: key);
final String title;
  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _currentIndex = 0;
  ThemeStyle _currentStyle = ThemeStyle.NotificationBadge;

  List<int> _badgeCounts = List<int>.generate(5, (index) => index);

  List<bool> _badgeShows = List<bool>.generate(5, (index) => true);

  @override
  Widget build(BuildContext context) {
    return CustomNavigationBar(
      iconSize: 30.0,
      selectedColor: Colors.white,
      strokeColor: Colors.white,
      unSelectedColor: Colors.grey[600],
      backgroundColor: Colors.black,
      borderRadius: Radius.circular(20.0),
      blurEffect: true,
      opacity: 0.8,
      items: [
        CustomNavigationBarItem(
          icon: Icon(
            Icons.home,
          ),
        ),
        CustomNavigationBarItem(
          icon: Icon(
            Icons.shopping_cart,
          ),
        ),
        CustomNavigationBarItem(
          icon: Icon(
            Icons.cloud,
          ),
        ),
        CustomNavigationBarItem(
          icon: Icon(
            Icons.search,
          ),
        ),
        CustomNavigationBarItem(
          icon: Icon(
            Icons.supervised_user_circle
          ),
        ),
      ],
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      isFloating: true,
    );
  }
}
