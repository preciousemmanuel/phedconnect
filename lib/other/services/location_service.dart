import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';


class LocationService{

  static Map<String, dynamic> _latLng;
  static String _latitude;
  static String _longitude;


  //check for location service status
  static checkLocationPermissionStatus(BuildContext context) async{ 
      
      //check if permission is granted
       
       LocationPermission permission = await checkPermission();

       print("Location check permission status: " + permission.toString());
       //not granted
       if(permission == LocationPermission.denied || permission == LocationPermission.deniedForever){

          //request for permission
          //PermissionStatus permission = await LocationPermissions().requestPermissions();
          LocationPermission permission = await requestPermission();

          print("Location request permission status: "+ permission.toString());
          if(permission == LocationPermission.denied || permission == LocationPermission.deniedForever){
              Navigator.pop(context); //return to previous screen
          }
          //permission granted: check is service is enabled
          else{
            return LocationService.checkLocationServiceStatus();
          } 
       }
       //permission is granted
       else{    
           return LocationService.checkLocationServiceStatus();    
       }
  }

  static Future<Map<String, dynamic>> checkLocationServiceStatus() async{

         // ServiceStatus serviceStatus = await LocationPermissions().checkServiceStatus();
          bool isServiceEnabled  = await isLocationServiceEnabled();
          print("Location Service status: " + isServiceEnabled.toString());
          
          if(isServiceEnabled){
              //Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

              Position position = await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
              print("Lat and Long of current position: "+ position.toString());

              //Location service is enabled and lat/lng values where found
              if(position != null){
                  print("lat: " + position.latitude.toString());
                  print("long: " + position.longitude.toString());
                  _latitude = position.latitude.toString();
                  _longitude = position.longitude.toString();

                  return _latLng = {
                    "isServiceEnabled": true,
                    "latitude": _latitude,
                    "longitude": _longitude
                  };
              }
              //Location service is enable but no lat/lng values where found
              else{
                print("lat/long: " + "NULL");
                return _latLng = {
                  "isServiceEnabled": true,
                  "latitude": null,
                  "longitude": null
                };
              }
          }
          else{
             //Location service is not enabled
              _latLng = {
                  "isServiceEnabled": false,
                  "latitude": null,
                  "longitude": null
            };       
          }

          return _latLng;
  }
}