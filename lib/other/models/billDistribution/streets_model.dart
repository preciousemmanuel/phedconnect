 class StreetsModel{
  static String dtrid;
  String streetName, community,streetcode,nearestbusstop,accountno,customeraddress,landmark,poleno,customername;
  StreetsModel({
    this.streetName,
    this.community,
    this.nearestbusstop,
    this.streetcode,
    this.accountno,
    this.customeraddress,
    this.landmark,
    this.poleno,
    this.customername
  });
 // streetsModel({this.streetName,this.community,this.nearestbusstop,this.streetcode,this.accountno});

  factory StreetsModel.createStreets(Map<String, dynamic> json){
      return StreetsModel(
            community: json["Community"],
            streetName: json["street_name"],
            nearestbusstop: json["last_bus_stop"],
            streetcode: json["sn"]
      );
  }     
}