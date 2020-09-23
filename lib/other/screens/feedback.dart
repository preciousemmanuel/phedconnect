
import 'package:flutter/material.dart';
import '../data/authenticated_staff.dart';
import '../services/location_service.dart';
import '../utilities/alert_dialog.dart';
import '../widgets/submit_btn.dart';
import '../controllers/feedback_controller.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';



class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  Color myHexColor = Color(0xff5e6da0);

    GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();
    FeedbackController fbc =  new FeedbackController();
      double _rating;
      int _ratingBarMode = 1;
      String _ratingText="Not Satisfied";
   
    String _comment;
    String _selectedModule;
    String latitude;
    String longitude;
    bool isLoading = false;
    var latLng;
   

    List<DropdownMenuItem> dropdownItemsFeedbackModule = [
        DropdownMenuItem(
          child: Text(
            "Select an option**",
            style: TextStyle(color: Colors.blue),
          ),
          value: "",
        ),
        DropdownMenuItem(
          child: Text("Our Service"),
          value: "Our Service",
        ),
        DropdownMenuItem(
          child: Text("PHED Connect"),
          value: "PHED Connect",
        ),
       
    ];



    @override
    void initState(){
        _selectedModule = dropdownItemsFeedbackModule[0].value;
        checkLocationServiceStatus();
        _getGeoPoints();
        super.initState();
    }

    checkLocationServiceStatus() async{

        // checkLocationServiceStatus();
        try{
            latLng = await LocationService.checkLocationPermissionStatus(context);
            if(!latLng["isServiceEnabled"]){
                _showSnackBar(isSuccessSnack: false, msg: "Please turn on your location service");
            }
        }
        catch(e){
            print("ireport-eLog: system couldn't check location service status");
        }
        
    }

    void _getGeoPoints() async{

        //showAlertDialog(context: context, isLoading: true, loadingMsg: "Fetching cordinates...");
      
        try{
          var latLng = await LocationService.checkLocationPermissionStatus(context);
          print(latLng.toString());
          
          if(latLng["isServiceEnabled"] && latLng["latitude"] != null && latLng["longitude"] != null){
              
              latitude = latLng["latitude"];
              longitude = latLng["longitude"];
              print(latLng["latitude"]);
              
          }
          
        }
        catch(e){
            print("dc_details: error fetching lat/lng");
            print("dc_details: "+e.toString());
        }
        
        print(longitude);
        print(latitude);
            
    }

    //Function: snackbar for creating and displaying widget
    void _showSnackBar({bool isSuccessSnack, String msg}){

          //create snackbar
          var snackBar =  SnackBar(
              backgroundColor: isSuccessSnack ? Colors.green : Colors.red,
              content: Text(msg,
              style: TextStyle(
                color: Colors.white
              ),),
          );

          //show snackbar
          scaffoldKey.currentState.showSnackBar(snackBar);
    }

  showErrorDialog(String errMsg){
    showAlertDialog(
      context: context, 
      isLoading: false, 
      isSuccess: false,
      completedMsg: errMsg
    );
  }

  bool validateDropdownInput(){
      
      setState(()=>isLoading = false); 

      if(_selectedModule.length < 1 || _selectedModule == null){
          showErrorDialog("Please select a module to continue");
          return false;
      }
      if(_comment == null || _comment.toString().trim().length < 1){
          showErrorDialog("Please enter a comment to continue");
          return false;
      }
      if(latitude == null || latitude.toString().trim().length < 1){
          showErrorDialog("Please turn on your location service");
          return false;
      }
      if(_comment == null || _comment.toString().trim().length < 1){
          showErrorDialog("Please turn on your location service");
          return false;
      }
      return true;
    
  }


  /*
  * This method handles the submission process
  */
  void _completeSubmitAction() async{


       if(!validateDropdownInput()){
         return;
       }
       // _getGeoPoints();

         //display loading dialog
        setState(()=>isLoading = true);
        //create form data
        Map<String,dynamic> data = {
            "StaffId": authenticatedStaff.staffId,
            "StaffName": authenticatedStaff.name,
            "StaffPhone": authenticatedStaff.phoneNo,
            "Email": authenticatedStaff.email,  
            "Comments": _comment.trim(),           
            "Latitude": latitude.toString(),
            "Longitude": longitude.toString(),
            "ModuleName": _selectedModule,
        };

            Map<String, dynamic> res;
            res = await fbc.submit(data);
            //submission was successful
            if(res != null){
              if(res['isSuccessful']){
                setState(()=>isLoading = false); 
                showAlertDialog(
                  context: context,
                  navigateTo: '/modules',
                  isLoading: false, 
                  isSuccess: true, 
                  completedMsg: res['msg']);
              }
              //submission failed
              else{
                setState(()=>isLoading = false); 
                showAlertDialog(context: context, isLoading: false, isSuccess: false, completedMsg: res['msg']);
              }
            }
          
    }


    Widget  _buildDropDownButtonModule(){
     return Column(  
       crossAxisAlignment: CrossAxisAlignment.start,
       children: <Widget>[
         Text("Select an option, you want to give feedback on",
           style: TextStyle(
             fontWeight: FontWeight.bold,
             color: Colors.white
           )
         ),
         SizedBox(height: 8.0,),
         Container(
           width: double.infinity,
            margin: EdgeInsets.all(2.0),
            padding: EdgeInsets.all(8.0),
            height: 60.0,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(blurRadius: 6.0, offset: Offset(0,2), color: Colors.black12)
              ],
              borderRadius: BorderRadius.circular(5.0)
            ),
           child: DropdownButton(
             items: dropdownItemsFeedbackModule,
             onChanged: (dynamic value){
               print("feedback report: $value");
               setState(() {
                 _selectedModule = value;
               });
             },
             value: _selectedModule,
             style: TextStyle(
               color: Colors.black,
               fontWeight: FontWeight.w600
             ),
           ),
         ),
       ],
     );
  }

   


  //builds the text field for comment
  Widget _buildCommentTextField(){
      return TextFormField(
        maxLines: 5,
        decoration: InputDecoration(
            labelText: "Enter your feedback here...",
            hintText: "Enter here",
            fillColor: Colors.white,
            filled: true 
        ),
        onChanged: (newValue) => _comment = newValue,
      );
  }


  Widget _ratingBar(int mode) {
    switch (mode) {
      case 1:
        return RatingBar(
          initialRating: 2,
          minRating: 1,
          
          allowHalfRating: true,
          unratedColor: Colors.amber.withAlpha(50),
          itemCount: 5,
          itemSize: 50.0,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) =>Icon(
                        Icons.star,
                        color: Theme.of(context).primaryColor,
                      ),
          onRatingUpdate: (rating) {
            setState(() {
              _rating = rating;
            });
          },
        );
      case 2:
        return RatingBar(
          initialRating: 3,
        
          allowHalfRating: true,
          itemCount: 5,
           itemBuilder: (context, _) =>Icon(
                        Icons.star,
                        color: Theme.of(context).primaryColor,
                      ),
          
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          onRatingUpdate: (rating) {
            setState(() {
              _rating = rating;
              _ratingText="Not Satisfied";
            });
          },
        );
      case 3:
        return RatingBar(
          initialRating: 3,
      
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
           itemBuilder: (context, _) =>Icon(
                        Icons.star,
                        color: Theme.of(context).primaryColor,
                      ),
          onRatingUpdate: (rating) {
            setState(() {
              _rating = rating;
              _ratingText="Quite Satisfied";
            });
          },
        );
      default:
        return Container();
    }
  }
  
  // Widget ratingText(){
  //   if (rating >=1 && rating <=3) {
  //     setState(() {
        
  //     });
  //     _ratingText="Not Satisfied";
  //   } else if(){

  //   }
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myHexColor,
        key: scaffoldKey,
        appBar: AppBar(
          title: Text("Feedback"),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body:isLoading ? Center(child: CircularProgressIndicator()) : SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
           
            child: Stack(
              children:[
                 Image(
              height: MediaQuery.of(context).size.height / 3.3,
              fit: BoxFit.cover,
              width: double.infinity,
              image: AssetImage('assets/images/feedback.gif'),
            ),
            Container(
              height: 400.0,
              
              margin: EdgeInsets.only(top:170.0,bottom: 20.0,left:10.0,right: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:BorderRadius.circular(7.0),
    //             boxShadow:  [
    //   BoxShadow(color: Colors.grey, spreadRadius: 3),
    // ],
    
              ),
              child:Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(children: [
                  SizedBox(height: 10.0),
                   _ratingBar(_ratingBarMode),

                  SizedBox(height: 5.0),
                  Text(_ratingText),
                  SizedBox(height: 10.0),
                  
                  
                  _buildDropDownButtonModule(),
                  SizedBox(height: 10.0),
                  _buildCommentTextField(),
                  SizedBox(height: 10.0),
                  SubmitButton(_completeSubmitAction, isLoading, "SUBMIT")   
                ],),
              )
            )
              ]
            )
          ),
         

        )
    );
  }
}
