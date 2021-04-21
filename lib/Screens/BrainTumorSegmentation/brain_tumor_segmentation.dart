import 'package:flutter/material.dart';
import 'report_widget.dart';

class BrainTumorSegmentation extends StatefulWidget {
  @override
  _BrainTumorSegmentationState createState() => _BrainTumorSegmentationState();
}

class _BrainTumorSegmentationState extends State<BrainTumorSegmentation>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final double widthSize = MediaQuery.of(context).size.width;
    final double heightSize = MediaQuery.of(context).size.height;
    bool mobileWidth = widthSize < 800;

    List<Widget> tabs = [
      ReportSegment(
        title: 'Pending Reports',
        status: 'pending',
      ),
      ReportSegment(
        title: 'Completed Reports',
        status: 'completed',
      ),
    ];
    TabController _tabController = TabController(
      length: tabs.length,
      vsync: this,
      initialIndex: 0,
    );

    return Container(
      height: mobileWidth ? heightSize - 40 : heightSize,
      color: Theme.of(context).primaryColor,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
          tooltip: 'Initiate New Report',
          elevation: 0,
          highlightElevation: 1,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 40,
              child: TabBar(
                tabs: [tabTitle('Pending'), tabTitle('Completed')],
                controller: _tabController,
              ),
            ),
            Expanded(
              child: TabBarView(
                children: tabs,
                physics: new NeverScrollableScrollPhysics(),
                controller: _tabController,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget tabTitle(String title) {
    return Text(
      title,
      style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 24),
    );
  }
}
