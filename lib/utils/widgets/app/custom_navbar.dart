import 'package:flutter/material.dart';
import 'package:otk_employee/utils/theme/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:otk_employee/ui/home/provider/home_provider.dart';

class CustomNavbar extends StatelessWidget {
  const CustomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, _) {
        return BottomNavigationBar(
          currentIndex: provider.selectedIndex,
          onTap: (value) {
            provider.selectedIndex = value;
          },
          iconSize: 24,
          // showUnselectedLabels: true,
          showSelectedLabels: true,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.dark.withValues(alpha: 0.5),
          selectedLabelStyle: TextStyle(
            fontSize: 12,
            color: AppColors.primary,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 12,
            color: AppColors.dark.withValues(alpha: 0.5),
          ),
          items: [
            ...provider.menu.map((e) {
              return BottomNavigationBarItem(
                icon: Icon(
                  e['icon'],
                ),
                activeIcon: Icon(
                  e['active_icon'],
                ),
                label: "${e['title'] ?? ''}",
              );
            }),
          ],
        );
      },
    );
  }
}

/*
  'title': 'Orders',
  'icon': Icons.home_outlined,
  'active_icon': Icons.home,
  "page": TailoringPage(),
*/
