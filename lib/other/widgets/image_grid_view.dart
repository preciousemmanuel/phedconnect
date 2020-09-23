
/*
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class ImageGridView extends StatelessWidget {


  final List<Asset> images;
  ImageGridView(this.images);


  //get file from Asset
  Future<File> getImageFileFromAsset(String path) async {
    final file = File(path);
    return file;
  }

  //add file to list
  getFile() async {
      for (int i = 0; i < images.length; i++) {
          var path2 = await FlutterAbsolutePath.getAbsolutePath(images[i].identifier);
          print("identifier " +path2);
          var file = await getImageFileFromAsset(path2);
          print("File: " + file.toString());
      }
  }


  @override
  Widget build(BuildContext context) {
    return images.length < 1 ? Container() : Container(
      height: 100,
      child: GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 5,
        mainAxisSpacing: 1,
        children: List.generate(images.length, (index) {
          Asset asset = images[index];
          //print("print $index : " + asset.name.toString());
          //testPrint();
          return AssetThumb(
            asset: asset,
            width: 300,
            height: 300,
          );
        }),
      ),
    );
  }
}

*/