import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'paltform_factory_widget.dart';
import 'settings_screen.dart';

class RecentTab extends StatefulWidget {
  RecentTab({super.key, this.androidNavigionDrawer});
  static const title = 'Recent';
  static const iosIcon = Icon(CupertinoIcons.time);
  static const androidIcon = Icon(Icons.timelapse);

  static const _itemsLength = 40;
  final Widget? androidNavigionDrawer;

  @override
  State<RecentTab> createState() => _RecentTabState();
}

class _RecentTabState extends State<RecentTab> {
  final _androidRefreshKey = GlobalKey<RefreshIndicatorState>();

  Future<void> _refreshData() {
    return Future.delayed(
      // This is just an arbitrary delay that simulates some network activity.
      const Duration(seconds: 2),
      () => setState(() {}),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformFactoryWidget(
        androidBuilder: _buildAndroid, iOsWidgetBuilder: _buildIos);
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(RecentTab.title),
          actions: [
            IconButton(
                onPressed: () {
                  _androidRefreshKey.currentState!.show();
                },
                icon: const Icon(Icons.refresh)),
            IconButton(
                onPressed: () {
                  Navigator.of(context).push<void>(MaterialPageRoute(
                      builder: (context) => const Settings()));
                },
                icon: const Icon(Icons.settings))
          ],
        ),
        drawer: widget.androidNavigionDrawer,
        body: RefreshIndicator(
          key: _androidRefreshKey,
          onRefresh: () {
            return _refreshData();
          },
          child: GridView.builder(
            itemCount: 40,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, crossAxisSpacing: 20, mainAxisSpacing: 20),
            itemBuilder: (context, index) => _listBuilder(context, index),
          ),
        ));
  }

  Widget _listBuilder(BuildContext context, int index) {
    if (index >= RecentTab._itemsLength) return const SizedBox.shrink();
    return SafeArea(
      top: true,
      bottom: false,
      child: CachedNetworkImage(
          imageUrl:
              "https://resizing.flixster.com/lFdqqf-ROS4HL0NhUg5NMbFDO74=/218x280/v2/https://flxt.tmsimg.com/assets/63862_v9_ba.jpg",
          width: 100,
          height: 100,
          fit: BoxFit.fitWidth,
          errorWidget: (context, url, error) => Icon(Icons.error)),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CustomScrollView(
      slivers: [
        CupertinoSliverNavigationBar(
          automaticallyImplyLeading: true,
          largeTitle: const Text(RecentTab.title),
          trailing: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Navigator.of(context, rootNavigator: true).push<void>(
                CupertinoPageRoute(
                  title: Settings.title,
                  fullscreenDialog: true,
                  builder: (context) => const Settings(),
                ),
              );
            },
            child: const Icon(CupertinoIcons.settings),
          ),
        ),
         CupertinoSliverRefreshControl(
          onRefresh: _refreshData,
        ),
        SliverSafeArea(
            sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 20.0,
                    mainAxisSpacing: 20.0),
                delegate: SliverChildBuilderDelegate(
                    childCount: RecentTab._itemsLength,
                    (context, index) => _listBuilder(context, index))))
      ],
    );
  }
}
