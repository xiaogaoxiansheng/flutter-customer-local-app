import 'package:flutter/material.dart';
import 'package:flutter_avif/flutter_avif.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainStyles {
  static const Color bottomBackground = Colors.white;
  static const Color selectedColor = Colors.green;
  static const Color unselectedColor = Colors.grey;

  static double bottomNavHeight() => 64.h;

  static List<BottomNavigationBarItem> bottomNavItems() => [
        BottomNavigationBarItem(
          icon: AvifImage.asset(
            'assets/images/tabbar_home01.avif',
            width: 24.w,
            height: 24.w,
            errorBuilder: (c, e, s) => const Icon(Icons.home),
          ),
          activeIcon: AvifImage.asset(
            'assets/images/tabbar_home02.avif',
            width: 24.w,
            height: 24.w,
            errorBuilder: (c, e, s) => const Icon(Icons.home),
          ),
          label: '首页',
        ),
        BottomNavigationBarItem(
          icon: AvifImage.asset(
            'assets/images/tabbar_device01.avif',
            width: 24.w,
            height: 24.w,
            errorBuilder: (c, e, s) => const Icon(Icons.devices),
          ),
          activeIcon: AvifImage.asset(
            'assets/images/tabbar_device02.avif',
            width: 24.w,
            height: 24.w,
            errorBuilder: (c, e, s) => const Icon(Icons.devices),
          ),
          label: '设备',
        ),
        BottomNavigationBarItem(
          icon: AvifImage.asset(
            'assets/images/tabbar_alarm01.avif',
            width: 24.w,
            height: 24.w,
            errorBuilder: (c, e, s) => const Icon(Icons.warning),
          ),
          activeIcon: AvifImage.asset(
            'assets/images/tabbar_alarm02.avif',
            width: 24.w,
            height: 24.w,
            errorBuilder: (c, e, s) => const Icon(Icons.warning),
          ),
          label: '告警',
        ),
        BottomNavigationBarItem(
          icon: AvifImage.asset(
            'assets/images/tabbar_my01.avif',
            width: 24.w,
            height: 24.w,
            errorBuilder: (c, e, s) => const Icon(Icons.person),
          ),
          activeIcon: AvifImage.asset(
            'assets/images/tabbar_my02.avif',
            width: 24.w,
            height: 24.w,
            errorBuilder: (c, e, s) => const Icon(Icons.person),
          ),
          label: '我',
        ),
      ];
}

