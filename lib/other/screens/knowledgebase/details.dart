import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';

class KBDetailsScreen extends StatefulWidget {

  final String kbType;
  final int lastItem;
 

  KBDetailsScreen(this.kbType, this.lastItem);

  @override
  _KBDetailsScreenState createState() => _KBDetailsScreenState();
}

class _KBDetailsScreenState extends State<KBDetailsScreen> {

  int count = 0;
  String url;

  @override
  void initState() {

    super.initState();
    
    //image url
    url = "http://api.nepamsonline.com/PHEDConnect/kb/${widget.kbType}/${widget.kbType}_";
    //url = "http://10.0.2.2/PHEDConnect/kb/${widget.kbType}/${widget.kbType}_";


    //forces screen to potrait mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  dispose(){
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text("Knowledge Base Details"),
     ),
     body: Stack(
       children: <Widget>[
         /*FadeInImage(
           placeholder: AssetImage("assets/images/bgg.png"),
           image: NetworkImage("http://10.0.2.2/PHEDConnect/phed_nerc/phed_nerc_3.JPG"),
           width: MediaQuery.of(context).size.width,
           height: MediaQuery.of(context).size.height,
           fit: BoxFit.fitWidth,
         ),
         */
         PhotoView(
           imageProvider: NetworkImage(url+"$count.JPG"),
           loadFailedChild: Image.asset("assets/images/bgg.png"),
           loadingBuilder: (context, event) => Center(
            child: Container(
              width: 20.0,
              height: 20.0,
              child: CircularProgressIndicator(
                value: event == null
                    ? 0
                    : event.cumulativeBytesLoaded / event.expectedTotalBytes,
              ),
            ),
          ),
           enableRotation: true,
         ),
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
               IconButton(
                 icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
                 onPressed: (){
                     setState(() {
                     if(count > 0){
                       count--;
                       print(count.toString());
                     }
                   });
                 
                 },
               ),
               IconButton(
                 icon: Icon(Icons.arrow_forward_ios, color: Colors.white,),
                 onPressed: (){
                    if(count < widget.lastItem){
                      setState(() {
                        count++;
                        print(count.toString());
                      });
                    }
                    
                 },
               )
             ],
           ),
         )
       ],
     ),
   );
  }
}