import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../constants/app_colors.dart';
import '../shared/ui_helper.dart';

class HomePage extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const HomePage({
    super.key,
    required this.navigationShell,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final StreamSubscription<ConnectivityResult> _subscription;

  @override
  void initState() {
    super.initState();

    _subscription = Connectivity().onConnectivityChanged.listen((result) => UiHelper.showConnectivityStatus(context: context, result: result));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.bgColor1,
        body: widget.navigationShell,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white10,
          selectedItemColor: AppColors.buttonColor,
          unselectedItemColor: AppColors.textColor1,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          currentIndex: widget.navigationShell.currentIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_rounded),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.attach_money_rounded),
              label: 'Income',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.money_rounded),
              label: 'Expense',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_rounded),
              label: 'Chart',
            )
          ],
          onTap: (index) {
            widget.navigationShell.goBranch(
              index,
              initialLocation: index == widget.navigationShell.currentIndex,
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _subscription.cancel();

    super.dispose();
  }
}
