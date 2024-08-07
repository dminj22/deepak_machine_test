import 'package:deepak_machine_test/provider/authentication_provider.dart';
import 'package:deepak_machine_test/provider/user_list_provider.dart';
import 'package:deepak_machine_test/screen/dashboard/base/user_list_screen.dart';
import 'package:deepak_machine_test/screen/dashboard/base/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int currentPageIndex = 0;
  List screen = [
    const UserListScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(
        () => context.read<AuthenticationProvider>().profileDetails());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Deepak Minj Machine Test"),
        actions: [
          IconButton(
              onPressed: () {
                context.read<AuthenticationProvider>().logoutUser(context);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          currentPageIndex = index;
          setState(() {});
        },
        selectedIndex: currentPageIndex,
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.person),
            icon: Icon(Icons.person_2_outlined),
            label: 'Profile',
          ),
        ],
      ),
      body: screen.elementAt(currentPageIndex),
    );
  }
}
