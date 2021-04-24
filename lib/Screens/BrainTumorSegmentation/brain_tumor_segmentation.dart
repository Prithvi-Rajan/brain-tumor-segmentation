import 'dart:html' as html;
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
  List<html.File> imagesForUpload = [];
  List<String> imgURLs = [];
  String pathToAPI;
  Reference imageFolder;

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

  Future<void> loadPictures() async {
    imagesForUpload =
        await ImagePickerWeb.getMultiImages(outputType: ImageType.file);
  }

  Future<void> uploadPhotos() async {
    Fluttertoast.showToast(msg: 'Uploading Photos...\nPlease Wait...');

    String path = 'api/bts/$uid';
    for (var i = 0; i < imagesForUpload.length; i++) {
      final img = imagesForUpload[i];
      String imgID = i.toString();
      final uploadTask = storageReference.child(path).child(imgID).putBlob(img);
      final taskSnapshot = await uploadTask.whenComplete(() => {});
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      imgURLs.add(downloadUrl);
      imageFolder = taskSnapshot.ref.parent;
    }
  }

  Future<void> addDocument() async {
    final data = {
      'api': 'bts',
      'initiator': uid,
      'images': imgURLs,
      'imageFolder': imageFolder.fullPath,
      'status': 'pending',
      'timestamp': DateTime.now().millisecondsSinceEpoch
    };
    final ref = await firestoreIns.collection('api-bts').add(data);
    pathToAPI = ref.path;
    print(pathToAPI);
  }

  Future<void> callAPI() async {
    // TODO: Implement RESTapi here
  }

  Future<void> initiateReport() async {
    await loadPictures();
    await uploadPhotos();
    await addDocument();
    await callAPI();
  }
}
