import 'package:flutter/material.dart';
import 'package:woong_front/constants/routes.dart';
import 'package:woong_front/views/default/components/bottomnav.dart';

class DefaultAppNavBar {
  static const tabs = [
    ScaffoldWithNavBarTabItem(
      initialLocation: AppRouteConstant.home,
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    ScaffoldWithNavBarTabItem(
      initialLocation: AppRouteConstant.shopping,
      icon: Icon(Icons.shopping_bag),
      label: 'Shopping',
    ),
    ScaffoldWithNavBarTabItem(
      initialLocation: AppRouteConstant.cart,
      icon: Icon(Icons.shopping_cart),
      label: 'Cart',
    ),
    ScaffoldWithNavBarTabItem(
      initialLocation: AppRouteConstant.user,
      icon: Icon(Icons.account_circle),
      label: 'Account',
    ),
    ScaffoldWithNavBarTabItem(
      initialLocation: '/test',
      icon: Icon(Icons.text_increase_rounded),
      label: 'Test',
    ),
  ];
}
