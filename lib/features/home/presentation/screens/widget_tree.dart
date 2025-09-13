import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class WidgetTree extends StatelessWidget {
  final Widget child;

  const WidgetTree({super.key, required this.child});

  static const _tabs = ['/home', '/scan', '/analytics', '/settings'];

  int _getSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    return _tabs.indexWhere((path) => location.startsWith(path));
  }

  void _onTabTapped(BuildContext context, int index) {
    if (index >= 0 && index < _tabs.length) {
      if (_tabs[index] == '/scan') {
        context.push('/scan');
      } else {
        context.go(_tabs[index]);
      }
    }
  }

  bool _shouldShowFAB(String location) {
    return location.startsWith('/home') || location.startsWith('/analytics');
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final selectedIndex = _getSelectedIndex(context);
    const kBrandColor = Color(0xFF00A87D);

    return Scaffold(
      body: child,

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) => _onTabTapped(context, index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: kBrandColor,
        unselectedItemColor: Colors.grey,
        iconSize: 22,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: [
          BottomNavigationBarItem(
            // normal (unselected)
            icon: SvgPicture.asset(
              'assets/icons/home.svg',
              colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
            ),
            // selected
            activeIcon: SvgPicture.asset(
              'assets/icons/home.svg',
              colorFilter: const ColorFilter.mode(kBrandColor, BlendMode.srcIn),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/scan.svg',
              colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/scan.svg',
              colorFilter: const ColorFilter.mode(kBrandColor, BlendMode.srcIn),
            ),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/analytics.svg',
              colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/analytics.svg',
              colorFilter: const ColorFilter.mode(kBrandColor, BlendMode.srcIn),
            ),
            label: 'Analytics',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/settings.svg',
              colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/settings.svg',
              colorFilter: const ColorFilter.mode(kBrandColor, BlendMode.srcIn),
            ),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
