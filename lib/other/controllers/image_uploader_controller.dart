

// import 'dart:convert';
// import 'dart:io';

// import 'package:mime/mime.dart';
// import 'package:scoped_model/scoped_model.dart';
// import 'package:http/http.dart' as http;
// import 'package:http_parser/http_parser.dart';

// class ImageUploaderController extends Model{

    
//         Future<Map<String, dynamic>> uploadImagesToServer(List<File> images, {String senderFlag}) async{



//         print(images.length.toString());
//         print(senderFlag);
        
//         print("uploading filese api called...");
//         http.Response response;
//         Map<String, dynamic> _res;


//         String baseUrl = "http://api.nepamsonline.com/PHEDConnect/iu_disconnect.php";
//         //String baseUrl = 'http://192.168.43.144/PHEDConnect/iu_disconnect.php';
//         //String baseUrl = "http://10.0.2.2/PHEDConnect/iu_disconnect.php";

//         // Intilize the multipart request
//         final imageUploadRequest = http.MultipartRequest('POST', Uri.parse(baseUrl));

//         //Number of images to be uploaded
//         imageUploadRequest.fields["count"] = images.length.toString();

//         //indicate the sender
//         //dc => disconnection, rc => reconnection, ir => ireport
//         imageUploadRequest.fields["flag"] = senderFlag;
          
//         // Attach the file in the request
//         for(int i=0; i < images.length; i++){

//             final imagePath = images[i].path;

//             // Find the mime type of the selected file by looking at the header bytes of the file
//             final mimeTypeData =
//             lookupMimeType(imagePath, headerBytes: [0xFF, 0xD8]).split('/');

//             //create a multipart file
//             final file = await http.MultipartFile.fromPath(
//               'image$i', 
//               imagePath,
//               contentType: MediaType(mimeTypeData[0], mimeTypeData[1])
//             );

//             //add to our request
//             imageUploadRequest.files.add(file);
//         }
          
//         try{

//             final streamResponse = await imageUploadRequest.send();
//             response = await http.Response.fromStream(streamResponse);

//             print("upload disconnection images response ${response.statusCode}");
//             print(response.body.toString());

//             var decodedResponse = json.decode(response.body);
//             //print(decodedResponse.toString());


//             ///successful response
//             if(response.statusCode == 200){

//                 //successful upload
//                 if(decodedResponse["status"] == "SUCCESS"){
//                     _res = {
//                       'isSuccessful': true,
//                       'msg': decodedResponse["message"],
//                       'data': json.encode(decodedResponse["data"])
//                     }; 
//                     print("UPLOAD RESPONSE0: ${response.body}"); 
//                 }
//                 //failed upload
//                 else{
//                     _res = {
//                         'isSuccessful': false,
//                         'msg': decodedResponse["message"],
//                         'data': null
//                     }; 
//                     print("UPLOAD RESPONSE1: "+ response.body); 
//                 }    
//             }
//             //failed upload
//             else{
//                 _res = {
//                     'isSuccessful': false,
//                     'msg': "image upload not successful",
//                     'data': null
//                 }; 
//                 print("UPLOAD RESPONSE2: "+ response.body); 
//             } 
            
//         }catch (e) {
//           // error in calling the API point
//             _res = {
//                 'isSuccessful': false,
//                 'msg': "Ooops..system couldn't complete this action.Please try again",
//                 'filePaths': null
//             }; 
//         }
//         return _res;

        
//   }


// }