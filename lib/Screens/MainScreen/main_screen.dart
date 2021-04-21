import 'package:cancer_segmentation/Screens/BrainTumorSegmentation/brain_tumor_segmentation.dart';
import 'package:cancer_segmentation/Screens/MainScreen/Widgets/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> titleList = ['Brain Tumor Segmentation'];
  List<IconData> iconList = [FontAwesomeIcons.brain];
  int _selectedIndex = 0;
  List<Widget> pages = [
    BrainTumorSegmentation(),
  ];
  @override
  Widget build(BuildContext context) {
    final double widthSize = MediaQuery.of(context).size.width;
    final double heightSize = MediaQuery.of(context).size.height;
    bool mobileWidth = widthSize < 800;
    return Scaffold(
      key: _scaffoldKey,
      drawer: mobileWidth
          ? Drawer(
              child: Sidebar(titleList, iconList, onSelectedCallback),
            )
          : null,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (mobileWidth)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () {
                      _scaffoldKey.currentState.openDrawer();
                    }),
                Text(
                  titleList[_selectedIndex],
                  style: Theme.of(context).textTheme.headline6,
                ),
                Container()
              ],
            ),
          Row(
            children: [
              if (!mobileWidth)
                Container(
                    constraints: BoxConstraints(maxWidth: 360),
                    height: heightSize,
                    decoration: BoxDecoration(
                        color: Theme.of(context).canvasColor,
                        boxShadow: [
                          BoxShadow(blurRadius: 2, color: Colors.grey)
                        ]),
                    child: Sidebar(titleList, iconList, onSelectedCallback)),
              Expanded(
                child: pages[_selectedIndex],
              )
            ],
          ),
        ],
      ),
    );
  }

  onSelectedCallback(int index) => setState(() => _selectedIndex = index);
}
