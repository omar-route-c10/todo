import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/auth/login_screen.dart';
import 'package:todo/auth/user_provider.dart';
import 'package:todo/firebase_utils.dart';
import 'package:todo/tabs/settings/settings_tab.dart';
import 'package:todo/tabs/tasks/add_task_bottom_sheet.dart';
import 'package:todo/tabs/tasks/tasks_provider.dart';
import 'package:todo/tabs/tasks/tasks_tab.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> tabs = [
    TasksTab(),
    SettingsTab(),
  ];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<String> appBarTitles = [
      AppLocalizations.of(context)!.todoList,
      AppLocalizations.of(context)!.settings,
    ];
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsetsDirectional.only(start: 20),
          child: Text(appBarTitles[currentIndex]),
        ),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseUtils.logout();
              Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
              Provider.of<TasksProvider>(context, listen: false).clear();
              Provider.of<UserProvider>(context, listen: false).currentUser =
                  null;
            },
            icon: const Icon(
              Icons.logout_outlined,
              color: AppTheme.whiteColor,
              size: 32,
            ),
          ),
        ],
      ),
      body: tabs[currentIndex],
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        padding: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        surfaceTintColor: Colors.white,
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) => setState(() {
            currentIndex = index;
          }),
          items: const [
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/images/tasks_icon.png'),
              ),
              label: 'Tasks',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/images/settings_icon.png'),
              ),
              label: 'Settings',
            ),
          ],
          type: BottomNavigationBarType.fixed,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (_) => AddTaskBottomSheet(),
          );
        },
        child: const Icon(
          Icons.add,
          size: 32,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
