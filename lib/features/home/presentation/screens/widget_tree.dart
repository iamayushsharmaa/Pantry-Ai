import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pantry_ai/core/router/app_routes.dart';
import 'package:pantry_ai/core/theme/colors.dart';

import '../../../../l10n/app_localizations.dart';

class WidgetTree extends StatelessWidget {
  final Widget child;

  const WidgetTree({super.key, required this.child});

  static const _tabs = [
    AppRoutes.home,
    AppRoutes.scan,
    AppRoutes.analytics,
    AppRoutes.settings,
  ];

  int _getSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    return _tabs.indexWhere((path) => location.startsWith(path));
  }

  void _onTabTapped(BuildContext context, int index) {
    if (index >= 0 && index < _tabs.length) {
      if (_tabs[index] == AppRoutes.scan) {
        context.push(AppRoutes.scan);
      } else {
        context.go(_tabs[index]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final selectedIndex = _getSelectedIndex(context);
    const kBrandColor = AppColors.brand;
    final l10n = AppLocalizations.of(context)!;

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
            icon: SvgPicture.asset(
              'assets/icons/home.svg',
              colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/home.svg',
              colorFilter: const ColorFilter.mode(kBrandColor, BlendMode.srcIn),
            ),
            label: l10n.home,
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
            label: l10n.scan,
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
            label: l10n.analytics,
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
            label: l10n.settings,
          ),
        ],
      ),
    );
  }
}
