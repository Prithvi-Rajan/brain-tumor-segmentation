import 'dart:html' as html;
import 'dart:typed_data';
import 'dart:io' as io;
import 'package:cancer_segmentation/Utils/constant.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker_web_redux/image_picker_web_redux.dart';
import 'report_widget.dart';

class BrainTumorSegmentation extends StatefulWidget {
  @override
  _BrainTumorSegmentationState createState() => _BrainTumorSegmentationState();
}

class _BrainTumorSegmentationState extends State<BrainTumorSegmentation>
    with TickerProviderStateMixin {
  final storageReference = FirebaseStorage.instance.ref();
  List<Uint8List> imagesForUpload = [];
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
          onPressed: initiateReport,
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

  uploadPhotos() async {
    Fluttertoast.showToast(msg: 'Uploading Photos...\nPlease Wait...');
    List<String> imgURLs = [];
    String path = 'bts' + uid ?? 'test';
    for (var i = 0; i < imagesForUpload.length; i++) {
      final img = imagesForUpload[i];
      String imgID = i.toString();
      final uploadTask = storageReference.child(path).child(imgID).putData(img);
      final taskSnapshot = await uploadTask.whenComplete(() => {});
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      imgURLs.add(downloadUrl);
    }
  }

  Future<void> loadPictures() async {
    imagesForUpload =
        await ImagePickerWeb.getMultiImages(outputType: ImageType.bytes);
  }

  Future<void> initiateReport() async {
    await loadPictures();
    await uploadPhotos();
  }
}
