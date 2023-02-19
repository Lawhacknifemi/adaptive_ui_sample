import 'package:adaptive_ui_sample/settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'browse_tab.dart';
import 'paltform_factory_widget.dart';
import 'recent_tab.dart';
import 'shared_tab.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        darkTheme: ThemeData.dark(),
        builder: (context, child) {
          return CupertinoTheme(
              data: const CupertinoThemeData(),
              child: Material(
                child: child,
              ));
        },
        home: const PlatformHomePage());
  }
}

class PlatformHomePage extends StatelessWidget {
  const PlatformHomePage({super.key});

  Widget _buildAndroidHomePage(BuildContext context) {
    return  RecentTab(
      androidNavigionDrawer: _AndroidNavigationDrawer(),
    );
  }

  Widget _buildIosHomePage(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(items: const [
        BottomNavigationBarItem(
            icon: RecentTab.iosIcon, label: RecentTab.title),
        BottomNavigationBarItem(
            icon: RecentTab.iosIcon,
            label: SharedTab.title),
        BottomNavigationBarItem(
            icon: BrowseTab.iosIcon, label: BrowseTab.title),
      ]),
      tabBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return CupertinoTabView(
              builder: (context) =>  RecentTab(),
            );
          case 1:
            return CupertinoTabView(
              builder: (context) => const SharedTab(),
            );
          case 2:
            return CupertinoTabView(
              defaultTitle: BrowseTab.title,
              builder: (context) => const BrowseTab(),
            );
          default:
            return const Placeholder();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformFactoryWidget(
        androidBuilder: _buildAndroidHomePage,
        iOsWidgetBuilder: _buildIosHomePage);
  }
}


class _AndroidNavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blueGrey),
            child: Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Icon(
                Icons.account_circle,
                color: Colors.blueAccent,
                size: 96,
              ),
            ),
          ),
          ListTile(
            leading: RecentTab.androidIcon,
            title: const Text(RecentTab.title),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: BrowseTab.androidIcon,
            title: const Text(BrowseTab.title),
            onTap: () {
              Navigator.pop(context);
              Navigator.push<void>(context,
                  MaterialPageRoute(builder: (context) => const BrowseTab()));
            },
          ),
          ListTile(
            leading: SharedTab.androidICon,
            title: const Text(SharedTab.title),
            onTap: () {
              Navigator.pop(context);
              Navigator.push<void>(context,
                  MaterialPageRoute(builder: (context) => const SharedTab()));
            },
          ),
          // Long drawer contents are often segmented.
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(),
          ),
          ListTile(
            leading: Settings.androidIcon,
            title: const Text(Settings.title),
            onTap: () {
              Navigator.pop(context);
              Navigator.push<void>(context,
                  MaterialPageRoute(builder: (context) => const Settings()));
            },
          ),
        ],
      ),
    );
  }
}

