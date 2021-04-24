import 'package:cancer_segmentation/Utils/constant.dart';
import 'package:flutter/material.dart';

class Sidebar extends StatefulWidget {
  final List<String> titleList;
  final Function(int) onSelected;
  final List<IconData> iconList;
  Sidebar(this.titleList, this.iconList, this.onSelected);
  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              child: Image.asset(
            'images/login-image.png',
            fit: BoxFit.cover,
            height: 160,
          )),
          SizedBox(height: 20),
          Text(
            "Welcome,",
            style: Theme.of(context).textTheme.headline4,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              firebaseUser?.displayName ?? 'User',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          Divider(
            height: 40,
          ),
          ...List.generate(
              widget.titleList.length,
              (index) => ListTile(
                    contentPadding: EdgeInsets.all(0),
                    leading: Icon(
                      widget.iconList[index],
                      color: Color(0xff6666ff),
                    ),
                    title: Text(widget.titleList[index]),
                    onTap: () => widget.onSelected(index),
                  ))
        ],
      ),
    );
  }
}
