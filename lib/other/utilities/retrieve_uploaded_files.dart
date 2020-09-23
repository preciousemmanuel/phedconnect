/*import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

Future<List> getUploadFiles(List<Asset> images) async{
    List upFiles = [];

    for(int i=0; i<images.length; i++){
        var path2 = await FlutterAbsolutePath.getAbsolutePath(images[i].identifier);
        var file = File(path2);
        String fileName = file.path.split("/").last;

        upFiles.add(MultipartFile.fromFileSync(file.path, filename: fileName));
    }

    return upFiles;
}
*/