
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class FileUploadButton extends StatefulWidget {

//   final Function setImages;
//   final Function setPassport;
//   final String buttonTitle;
//   FileUploadButton({this.setImages, this.buttonTitle, this.setPassport});

//   @override
//   _FileUploadButtonState createState() => _FileUploadButtonState();
// }

// class _FileUploadButtonState extends State<FileUploadButton> {

//   List<File> selectedImageList = List();
//   List<File> displayImageList = List();
//   String error = 'No Error Dectected';

//   @override
//   void initState() {
//     super.initState();
//   }

  
  
//   //displays the bottom sheet modal with options to choose image from 
//   //gallery or from the camera
//   void openImagePicker(BuildContext context){
//     showModalBottomSheet(context: context, builder: (BuildContext context){
//       return Container(
//         height: 200.0,
//         padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 1.0),
//         child: Column(
//           children: <Widget>[
//               Text("Add Image", style: TextStyle(fontWeight: FontWeight.bold),),
//                SizedBox(height: 10.0),
//                FlatButton(
//                  child: Text("Use Camera", style: TextStyle(color: Theme.of(context).primaryColor),),
//                  onPressed: (){
//                    getImage(context, ImageSource.camera);
//                  },
//                ),
//                FlatButton(
//                  child: Text("Use Gallery", style: TextStyle(color: Theme.of(context).primaryColor),),
//                  onPressed: (){
//                    getImage(context, ImageSource.gallery);
//                  },
//                ),
         
//           ],
//         )
//       );
//     });
//   }

//   void getImage(BuildContext context, ImageSource imageSource) async {
//       var image;
//       if(imageSource == ImageSource.camera){
//         image = await ImagePicker().getImage(
//           source: imageSource, imageQuality: 60
//         );
//       }
//       else{
//         image = await ImagePicker().getImage(
//           source: imageSource, imageQuality: 65
//         );
//       }

//       if(image != null){
          
//           int allowedImages = widget.buttonTitle == "Passport" ? 1: 3;
          
//           selectedImageList.add(File(image.path));
//           if(displayImageList.length <= allowedImages ){
//             setState(() => displayImageList = selectedImageList);
//           }

//           widget.buttonTitle == null ? 
//           widget.setImages(displayImageList) : widget.setPassport(displayImageList); 
//       }
//      //widget.setImage(image);
//       Navigator.pop(context);
//   }

//   void _removeImage(int index){
//     selectedImageList.removeAt(index);
//     setState(() => displayImageList = selectedImageList);
//   }

//   Widget buildImageGridView(){

//       return displayImageList.length < 1 ? Container() : Container(
//         height: 100,
//         child: GridView.count(
//           crossAxisCount: 3,
//           crossAxisSpacing: 5,
//           mainAxisSpacing: 1,
//           children: List.generate(displayImageList.length, (index) {
//             File filePath = displayImageList[index];
//             print("print $index : " + filePath.toString());
//             return InkWell(
//                 onDoubleTap: () => _removeImage(index),
//                 child: Container(
//                 height: 100.0,
//                 width: 100.0,
//                 child: Image.file(
//                   filePath,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             );
//           }),
//         ),
//       );
//   }


//   @override
//   Widget build(BuildContext context) {
//     return  Align(
//         alignment: Alignment.centerLeft,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Container(
//              width: 150.0,
//               child: OutlineButton(
//                 borderSide: BorderSide(color: Colors.green, width: 2.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Icon(Icons.add_a_photo, color: Colors.green),
//                     SizedBox(width: 5.0),
//                     Text(
//                       widget.buttonTitle == null ? "Add Images" : widget.buttonTitle,
//                        style: TextStyle(color: Colors.white),
//                       overflow: TextOverflow.ellipsis,
//                     )
//                   ],
//                 ),
//                 //onPressed: loadAssets, //for multi-image selection
//                 onPressed: (){openImagePicker(context);},
//               ),
//             ),
//             SizedBox(height: 10.0),
//             buildImageGridView()
//           ],
//         ),
//     );
//   }


//   /*

//     //build method for multi-image selection
//     override
//     Widget build(BuildContext context) {
//       return  Align(
//           alignment: Alignment.centerLeft,
//           child: Column(
//             children: <Widget>[
//               Container(
//               width: 150.0,
//                 child: OutlineButton(
//                   borderSide: BorderSide(color: Colors.green, width: 2.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Icon(Icons.add_a_photo, color: Colors.green),
//                       SizedBox(width: 5.0),
//                       Text(
//                         "Add Images",
//                         overflow: TextOverflow.ellipsis,
//                       )
//                     ],
//                   ),
//                   //onPressed: loadAssets, //for multi-image selection
//                 ),
//               ),
//             ],
//           ),
//       );
//     }

//   */

  


// }