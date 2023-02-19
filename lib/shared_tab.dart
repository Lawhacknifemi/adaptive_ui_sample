import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'delete_button.dart';
import 'paltform_factory_widget.dart';

class SharedTab extends StatelessWidget {
  const SharedTab({super.key});

  static const title = "Shared";
  static const androidICon = Icon(Icons.share);
  static const iosICon = Icon(Icons.share);

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title: const Text(title),),
      body: SafeArea(child: Center(child: _buildBody())),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const CupertinoSliverNavigationBar(
          largeTitle: Text(title),
        ),
        const SliverAppBar(
          backgroundColor: Colors.transparent,
          title: CupertinoSearchTextField(),
        ),
        const CupertinoSliverRefreshControl(),
        SliverSafeArea(
          sliver: SliverToBoxAdapter(
              child: _buildBody()),
        )
      ],
    );
  }

  Column _buildBody() {
    return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Icon(
              size: 80,
              CupertinoIcons.folder_badge_person_crop,
              color: Colors.grey,
            ),
            Text(
              "No Shared Files",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            Text(
              "Shared files will appear here.",
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(
              height: 80,
            ),
            DeleteButton()
          ],
        );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformFactoryWidget(
        androidBuilder: _buildAndroid, iOsWidgetBuilder: _buildIos);
  }
}
