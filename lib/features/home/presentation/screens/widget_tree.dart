import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pantry_ai/core/router/app_routes.dart';
import 'package:pantry_ai/core/theme/colors.dart';

import '../../../../l10n/app_localizations.dart';

class WidgetTree extends StatelessWidget {
  final Widget child;

  const WidgetTree({super.key, required this.child});

  static const List<String> _tabs = [
    AppRoutes.home,
    AppRoutes.scan,
    AppRoutes.saved,
    AppRoutes.settings,
  ];

  int _getSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;

    if (location == AppRoutes.scan) return 0;

    final index = _tabs.indexWhere(
      (path) => location == path || location.startsWith('$path/'),
    );

    return index == -1 ? 0 : index;
  }

  void _onTabTapped(BuildContext context, int index) {
    if (index < 0 || index >= _tabs.length) return;

    final target = _tabs[index];
    final current = GoRouterState.of(context).uri.path;

    if (current == target) return;

    if (index == 1) {
      context.push(AppRoutes.scan);
      return;
    }

    context.go(target);
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _getSelectedIndex(context);
    final l10n = AppLocalizations.of(context)!;
    const brandColor = AppColors.brand;

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) => _onTabTapped(context, index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: brandColor,
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
              colorFilter: const ColorFilter.mode(brandColor, BlendMode.srcIn),
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
              colorFilter: const ColorFilter.mode(brandColor, BlendMode.srcIn),
            ),
            label: l10n.scan,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.bookmark_border_rounded, size: 22),
            activeIcon: const Icon(
              Icons.bookmark_rounded,
              size: 22,
              color: brandColor,
            ),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/settings.svg',
              colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/settings.svg',
              colorFilter: const ColorFilter.mode(brandColor, BlendMode.srcIn),
            ),
            label: l10n.settings,
          ),
        ],
      ),
    );
  }
}
