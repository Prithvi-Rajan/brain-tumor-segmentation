import 'package:flutter/material.dart';

class ReportSegment extends StatefulWidget {
  final String title;
  final String status;

  const ReportSegment({Key key, @required this.title, @required this.status})
      : super(key: key);
  @override
  _ReportSegmentState createState() => _ReportSegmentState();
}

class _ReportSegmentState extends State<ReportSegment> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(widget.title),
    );
  }
}
