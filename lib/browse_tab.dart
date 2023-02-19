import 'package:adaptive_ui_sample/paltform_factory_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BrowseTab extends StatelessWidget {
  const BrowseTab({super.key});

  static const title = "Browse";
  static const androidIcon = Icon(Icons.folder);
  static const iosIcon = Icon(CupertinoIcons.folder);
 
  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(title),
      ),
      body: _buildListView(context)
    );
  }

  Widget _buildListView(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          CustomCard(
            title: "First Option",
            onPressed: () => showChoices(
                context, ["Hollla", "Just Here", "LFG 👍", "TTM 🚀"]),
          ),
         CustomCard(title: "Secon option",
         onPressed: () => showChoices(context,[
          "Amigo ", "Just Another Option"
         ],
         ))
        ],
      ),
    );
  }

  void showChoices(BuildContext context, List<String> choices) {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        showDialog<void>(
          context: context,
          builder: (context) {
            int? selectedRadio = 1;
            return AlertDialog(
              contentPadding: const EdgeInsets.only(top: 12),
              content: StatefulBuilder(
                builder: (context, setState) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List<Widget>.generate(choices.length, (index) {
                      return RadioListTile<int?>(
                        title: Text(choices[index]),
                        value: index,
                        groupValue: selectedRadio,
                        onChanged: (value) {
                          setState(() => selectedRadio = value);
                        },
                      );
                    }),
                  );
                },
              ),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                TextButton(
                  child: const Text('CANCEL'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            );
          },
        );
        return;
      case TargetPlatform.iOS:
        showCupertinoModalPopup<void>(
          context: context,
          builder: (context) {
            return SizedBox(
              height: 250,
              child: CupertinoPicker(
                backgroundColor: Theme.of(context).canvasColor,
                useMagnifier: true,
                magnification: 1.1,
                itemExtent: 40,
                scrollController: FixedExtentScrollController(initialItem: 1),
                children: List<Widget>.generate(choices.length, (index) {
                  return Center(
                    child: Text(
                      choices[index],
                      style: const TextStyle(
                        fontSize: 21,
                      ),
                    ),
                  );
                }),
                onSelectedItemChanged: (value) {},
              ),
            );
          },
        );
        return;
      default:
        assert(false, 'Unexpected platform $defaultTargetPlatform');
    }
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text("iCloud"),
        trailing: CupertinoButton(
            child: const Icon(CupertinoIcons.ellipsis_circle),
            onPressed: () {}),
      ),
      child: _buildListView(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformFactoryWidget(
        androidBuilder: _buildAndroid, iOsWidgetBuilder: _buildIos);
  }
}

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    this.onPressed, required this.title,
  });

  final Function()? onPressed;

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InkWell(
        onTap: onPressed,
        child: Card(
          child: Column(
            children:  [
              Text(
                title,
                style: const TextStyle(fontSize: 24),
              ),
              Text(
                "🚀💿",
                style: TextStyle(fontSize: 24),
              )
            ],
          ),
        ),
      ),
    );
  }
}
