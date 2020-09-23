/*
* This class is the model for a customer(currently for list of customers due for disconnection)
*  Note: To extend it for other customers
*/

class Customer {
  int serialNo;
  String disconId;
  String accountNo;
  String address;
  String cin;
  String dtrCode;
  String feederName;
  String feeder11name;
  String feeder11id;
  String feeder33id;
  String zone;
  String dtrExec;
  String arrears;
  String lastPayDate;
  String latitude;
  String longitude;
  String disconReason;
  String disconAmount;
  String disconHistoryId;
  String disconBy;
  String settlementPlanId;
  String dateOfDiscon;
  String datePaid;
  String amountPaid;
  String month;
  String year;
  String dateGenerated;
  String generatedby;
  String disconStatus;
  String gandId;
  String accountType;
  String accountName;
  String avgConsumption;
  String dtrExecEmail;
  String dtrExecName;
  String dtrExecPhone;
  String dtrName;
  String feederId;
  String dtrId;
  String phase;
  String tariff;
  int poleno;
  String landmark;
  String meterno;
  String delivered;
  String capacity;
  String status;
  
  String bookcode, billsn, email, phoneNo, dtrcode, streetName;
  int streetNo;

  Customer(
      {this.serialNo,
      this.disconId,
      this.accountNo,
      this.address,
      this.cin,
      this.dtrCode,
      this.feederName,
      this.zone,
      this.dtrExec,
      this.arrears,
      this.lastPayDate,
      this.latitude,
      this.longitude,
      this.disconReason,
      this.disconAmount,
      this.disconHistoryId,
      this.disconBy,
      this.settlementPlanId,
      this.dateOfDiscon,
      this.datePaid,
      this.amountPaid,
      this.month,
      this.year,
      this.dateGenerated,
      this.generatedby,
      this.disconStatus,
      this.gandId,
      this.accountType,
      this.accountName,
      this.avgConsumption,
      this.dtrExecEmail,
      this.dtrExecName,
      this.dtrExecPhone,
      this.dtrName,
      this.feederId,
      this.dtrId,
      this.phase,
      this.tariff,
      this.bookcode,
      this.billsn,
      this.poleno,
      this.landmark,
      this.phoneNo,
      this.streetNo,
      this.meterno,
      this.capacity,
      this.feeder11name,
      this.feeder11id,
      this.feeder33id,
      this.delivered,
      this.status});
  factory Customer.searcheddtrbyname(Map<String, dynamic> json) {
    return Customer(
        latitude: json["Lat"],
        longitude: json["lon"],
        dtrName: json["DTR_Name"],
        dtrId: json["DTRID"],
        feederName: json["Feeder33Name"],
        feeder11name: json["Feeder11Name"],
        feeder11id: json["Feeder11ID"],
        feeder33id: json["Feeder33ID"],
        capacity: json["capacity"]);
  }
  factory Customer.createCustomersbystreets(Map<String, dynamic> json) {
    return Customer(
        meterno: json['MeterNo'],
        accountNo: json["AccountNO"],
        address: json["Address"],
        cin: json["cin"],
        latitude: json["Lat"],
        longitude: json["lon"],
        accountType: json["AccountType"],
        accountName: json["Names"],
        dtrName: json["DTR_Name"],
        dtrId: json["DTRID"],
        phase: json["Phase"],
        tariff: json["CurrentTarriffClass"],
        feederName: json["Feeder33Name"],
        phoneNo: json["GSM"],
        bookcode: json["BookCode"],
        billsn: json["ID"],
        delivered: json["delivered"]);
  }
  factory Customer.searchedCustomer(Map<String, dynamic> json) {
    return Customer(
        meterno: json['CurrentMeterSerialNo'],
        accountNo: json["ACCOUNTNO"],
        address: json["Addr1"],
        cin: json["cin"],
        latitude: json["Latitude"],
        longitude: json["Longitude"],
        accountType: json["AccountType"],
        accountName: json["Name"],
        dtrName: json["DTR_Name"],
        dtrId: json["DTRID"],
        phase: json["Phase"],
        tariff: json["CurrentTarriffClass"],
        feederName: json["Feeder33Name"],
        phoneNo: json["GSM"],
        bookcode: json["bookcode"],
        billsn: json["billsn"],
        delivered: json["delivered"]);
  }
  factory Customer.streetCustomer(Map<String, dynamic> json) {
    return Customer(
        meterno: json['MeterNo'],
        accountNo: json["ACCOUNTNO"],
        address: json["Address"],
        cin: json["cin"],
        latitude: json["Lat"],
        longitude: json["lon"],
        accountType: json["AccountType"],
        accountName: json["Names"],
        dtrName: json["DTR_Name"],
        dtrId: json["DTRID"],
        phase: json["Phase"],
        billsn: json["ID"],
        phoneNo: json["phoneno"],
        bookcode: json["bookcode"],
        delivered: json["delivered"]);
  }

  factory Customer.updateBillCustomerDetail(
      String accountNo,
      String bookcode,
      String email,
      String phoneNo,
      int poleno,
      String dtrcode,
      int streetNo,
      String streetName) {
    return Customer(
        accountNo: bookcode,
        address: email,
        phoneNo: phoneNo,
        poleno: poleno,
        longitude: dtrcode,
        accountType: streetName,
        streetNo: streetNo,
        dtrName: accountNo);
  }
  factory Customer.createCustomer(Map<String, dynamic> json) {
    return Customer(
        serialNo: json["SerialNo"],
        disconId: json["DisconID"],
        accountNo: json["AccountNo"],
        address: json["Address"],
        cin: json["CIN"],
        dtrCode: json["DTRCode"],
        feederName: json["FeederName"],
        zone: json["Zone"],
        dtrExec: json["DTRExec"],
        arrears: json["Arrears"],
        lastPayDate: json["LastPayDate"],
        latitude: json["Latitude"],
        longitude: json["Longitude"],
        disconReason: json["DisconReason"],
        disconAmount: json["DisconAmount"],
        disconHistoryId: json["DisconHistoryID"],
        disconBy: json["DisconBy"],
        settlementPlanId: json["SettlementPlan_ID"],
        dateOfDiscon: json["DateOfDiscon"],
        datePaid: json["DatePaid"],
        amountPaid: json["AmountPaid"],
        month: json["Month"],
        year: json["Year"],
        dateGenerated: json["DateGenerated"],
        generatedby: json["GeneratedBy"],
        disconStatus: json["DisconStatus"],
        gandId: json["Gang_ID"],
        accountType: json["AccountType"],
        accountName: json["AccountName"],
        avgConsumption: json["AvgConsumption"],
        dtrExecEmail: json["DTR_Exec_Email"],
        dtrExecName: json["DTR_Exec_Name"],
        dtrExecPhone: json["DTR_Exec_Phone"],
        dtrName: json["DTR_Name"],
        feederId: json["FeederId"],
        dtrId: json["DTR_Id"],
        phase: json["Phase"],
        tariff: json["Tariff"],
        status: json["ConsumerStatus"],
        meterno: json["MeterNo"]);
  }
}
