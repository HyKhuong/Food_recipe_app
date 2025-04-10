import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Import Font Awesome

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80, // Increase the height of the navigation bar
      decoration: BoxDecoration(
        color: Colors.white, // Background color
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        type: BottomNavigationBarType.fixed, // Fixed type for more than 3 items
        selectedItemColor:
            Colors.blueAccent, // Modern blue color for selected items
        unselectedItemColor: const Color.fromRGBO(
            69, 66, 66, 1), // Subtle grey for unselected items
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12, // Adjust font size for selected labels
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 12, // Adjust font size for unselected labels
        ),
        showUnselectedLabels: true, // Show labels for all items
        elevation: 0, // Remove default elevation
        iconSize: 24, // Adjust icon size
        items: [
          BottomNavigationBarItem(
            icon: _buildIcon(FontAwesomeIcons.house, FontAwesomeIcons.house, 0),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(FontAwesomeIcons.list, FontAwesomeIcons.listUl, 1),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(FontAwesomeIcons.magnifyingGlass,
                FontAwesomeIcons.magnifyingGlass, 2),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(FontAwesomeIcons.userAstronaut,
                FontAwesomeIcons.userAstronaut, 3),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(FontAwesomeIcons.cartShopping,
                FontAwesomeIcons.cartShopping, 4),
            label: 'Cart',
          ),
        ],
      ),
    );
  }

  // Helper function to build animated icons with color
  Widget _buildIcon(IconData outlineIcon, IconData filledIcon, int index) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      child: FaIcon(
        // Use FaIcon for Font Awesome icons
        currentIndex == index ? filledIcon : outlineIcon,
        key: ValueKey<int>(currentIndex == index ? 1 : 0),
        size: 24, // Adjust icon size
        color: currentIndex == index
            ? Colors.blueAccent
            : Colors.grey, // Add color here
      ),
    );
  }
}
