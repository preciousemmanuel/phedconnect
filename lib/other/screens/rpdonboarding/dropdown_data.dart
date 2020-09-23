 import 'package:flutter/material.dart';


//Category dropdown list
List<DropdownMenuItem> dropdownItemsOnboardingCategory = [
        DropdownMenuItem(
          child: Text(
            "Select Onboarding Action**",
            style: TextStyle(color: Colors.blue),
          ),
          value: "",
        ),
        DropdownMenuItem(
          child: Text("ILLEGAL CONNECTION"),
          value: "ILLEGAL CONNECTION",
        ),
        DropdownMenuItem(
          child: Text("NEW CUSTOMER"),
          value: "NEW CUSTOMER",
        ),
];

//Applicant Name dropdown list
List<DropdownMenuItem> dropdownItemsOnboardingApplicantName = [
        DropdownMenuItem(
          child: Text(
            "Select Applicant Title**",
            style: TextStyle(color: Colors.blue),
          ),
          value: "",
        ),
        DropdownMenuItem(
          child: Text("CHIEF"),
          value: "CHIEF",
        ),
        DropdownMenuItem(
          child: Text("DR"),
          value: "DR",
        ),
        DropdownMenuItem(
          child: Text("MR"),
          value: "MR",
        ),
        DropdownMenuItem(
          child: Text("MRS"),
          value: "MRS",
        ),
        DropdownMenuItem(
          child: Text("MISS"),
          value: "MISS",
        ),
];



//Dropdownlist: Use of premise
List<DropdownMenuItem> dropdownItemsOnboardingUseOfPremise = [
      DropdownMenuItem(
        child: Text(
          "Use Of Premise**",
          style: TextStyle(color: Colors.blue),
        ),
        value: "",
      ),
      DropdownMenuItem(
        child: Text("RESIDENTIAL"),
        value: "RESIDENTIAL",
      ),
      DropdownMenuItem(
        child: Text("COMMERCIAL"),
        value: "COMMERCIAL",
      ),
      DropdownMenuItem(
        child: Text("OTHERS"),
        value: "OTHERS",
      ),
];


//Dropdownlist: Use of premise
List<DropdownMenuItem> dropdownItemsOnboardingOccupationCat = [
        DropdownMenuItem(
          child: Text(
            "Select MDA(public servants)",
            style: TextStyle(color: Colors.blue),
          ),
          value: "",
        ),
        DropdownMenuItem(
          child: Text("MINISTRY"),
          value: "MINISTRY",
        ),
        DropdownMenuItem(
          child: Text("AGENCY"),
          value: "AGENCY",
        ),
        DropdownMenuItem(
          child: Text("DEPARTMENT"),
          value: "DEPARTMENT",
        ),
];

//Dropdownlist: Means of identification
List<DropdownMenuItem> dropdownItemsOnboardingID = [
      DropdownMenuItem(
        child: Text(
          "Means of Identification",
          style: TextStyle(color: Colors.blue),
        ),
        value: "",
      ),
      DropdownMenuItem(
        child: Text("INTERNATIONAL PASSPORT"),
        value: "INTERNATIONAL PASSPORT",
      ),
      DropdownMenuItem(
        child: Text("DRIVER's LICENSE"),
        value: "DRIVER's LICENSE",
      ),
      DropdownMenuItem(
        child: Text("PVC"),
        value: "PVC",
      ),
      DropdownMenuItem(
        child: Text("NATIONAL ID"),
        value: "NATIONAL ID",
      ),
];


//Dropdownlist: Means of identification
List<DropdownMenuItem> dropdownItemsOnboardingMeterRequired = [
      DropdownMenuItem(
        child: Text(
          "Select Meter Phase",
          style: TextStyle(color: Colors.blue),
        ),
        value: "",
      ),
      DropdownMenuItem(
        child: Text("SINGLE PHASE"),
        value: "SINGLE PHASE",
      ),
      DropdownMenuItem(
        child: Text("THREE PHASE"),
        value: "THREE PHASE",
      )
];


//Dropdown list: Type of premise
List<DropdownMenuItem> dropdownItemsOnboardingTypeOfPremise = [
        DropdownMenuItem(
          child: Text(
            "Select Type of Premise**",
            style: TextStyle(color: Colors.blue),
          ),
          value: "",
        ),
        DropdownMenuItem(
          child: Text("AGRICULTURAL LIFT IRRIGATION PUMP"),
          value: "AGRICULTURAL LIFT IRRIGATION PUMP",
        ),
        DropdownMenuItem(
          child: Text("AGRICULUTRAL TUBE WELL"),
          value: "AGRICULUTRAL TUBE WELL",
        ),
        DropdownMenuItem(
          child: Text("AQUA FARM"),
          value: "AQUA FARM",
        ),
        DropdownMenuItem(
          child: Text("BANK"),
          value: "BANK",
        ),
        DropdownMenuItem(
          child: Text("BAR"),
          value: "BAR",
        ),
        DropdownMenuItem(
          child: Text("BREEDING FARM"),
          value: "BREEDING FARM",
        ),
        DropdownMenuItem(
          child: Text("CEMETERY"),
          value: "CEMETERY",
        ),
        DropdownMenuItem(
          child: Text("CHARITABLE INSTITUTE/NGO/WELFARE"),
          value: "CHARITABLE INSTITUTE/NGO/WELFARE",
        ),
        DropdownMenuItem(
          child: Text("CHURCH"),
          value: "CHURCH",
        ),
         DropdownMenuItem(
          child: Text("CINEMA"),
          value: "CINEMA",
        ),
         DropdownMenuItem(
          child: Text("CLUBS/COMMUNITY HALL/GYM"),
          value: "CLUBS/COMMUNITY HALL/GYM",
        ),
        DropdownMenuItem(
          child: Text("COLLEGE"),
          value: "COLLEGE",
        ),
         DropdownMenuItem(
          child: Text("DAIRY FARM"),
          value: "DAIRY FARM",
        ),
         DropdownMenuItem(
          child: Text("DISPENSARY / CLINIC / LABORATORY -GOVT"),
          value: "DISPENSARY / CLINIC / LABORATORY -GOVT",
        ),
         DropdownMenuItem(
          child: Text("DISPENSARY / CLINIC / LABORATORY- PVT"),
          value: "DISPENSARY / CLINIC / LABORATORY- PVT",
        ),
         DropdownMenuItem(
          child: Text("EDUCATIONAL INSTITUTE"),
          value: "EDUCATIONAL INSTITUTE",
        ),
         DropdownMenuItem(
          child: Text("ENTERTAINMENT PLACES"),
          value: "ENTERTAINMENT PLACES",
        ),
         DropdownMenuItem(
          child: Text("EVENT CENTRE"),
          value: "EVENT CENTRE",
        ),
         DropdownMenuItem(
          child: Text("FAST FOOD"),
          value: "FAST FOOD",
        ),
         DropdownMenuItem(
          child: Text("FISH HATCHERIES"),
          value: "FISH HATCHERIES",
        ),
         DropdownMenuItem(
          child: Text("3BD ROOM FLAT"),
          value: "3BD ROOM FLAT",
        ),
        DropdownMenuItem(
          child: Text("FOREST"),
          value: "FOREST",
        ),
        DropdownMenuItem(
          child: Text("FUEL STATION"),
          value: "FUEL STATION",
        ),
        DropdownMenuItem(
          child: Text("GUEST HOUSE / REST HOUSE"),
          value: "GUEST HOUSE / REST HOUSE",
        ),
        DropdownMenuItem(
          child: Text("HOSPITAL - GOVT"),
          value: "HOSPITAL - GOVT",
        ),
        DropdownMenuItem(
          child: Text("HOSPITAL - PRIVATE"),
          value: "HOSPITAL - PRIVATE",
        ),
        DropdownMenuItem(
          child: Text("HOTEL"),
          value: "HOTEL",
        ),
        DropdownMenuItem(
          child: Text("HOUSE"),
          value: "HOUSE",
        ),DropdownMenuItem(
          child: Text("INDUSTRY"),
          value: "INDUSTRY",
        ),
        DropdownMenuItem(
          child: Text("LIBRARY"),
          value: "LIBRARY",
        ),
        DropdownMenuItem(
          child: Text("MOSQUE"),
          value: "MOSQUE",
        ),
        DropdownMenuItem(
          child: Text("OFFICE - GOVT"),
          value: "OFFICE - GOVT",
        ),
         DropdownMenuItem(
          child: Text("OFFICE - PRIVATE / LAWYERS / SOLICITORS"),
          value: "OFFICE - PRIVATE / LAWYERS / SOLICITORS",
        ),
         DropdownMenuItem(
          child: Text("OTHERS"),
          value: "OTHERS",
        ),
         DropdownMenuItem(
          child: Text("PARKS / PLAYGROUND"),
          value: "PARKS / PLAYGROUND",
        ),
         DropdownMenuItem(
          child: Text("POST OFFICE"),
          value: "POST OFFICE",
        ),
        DropdownMenuItem(
          child: Text("POULTRY FARM"),
          value: "POULTRY FARM",
        ),
         DropdownMenuItem(
          child: Text("RESTAURANT"),
          value: "RESTAURANT",
        ),
         DropdownMenuItem(
          child: Text("SCHOOL"),
          value: "SCHOOL",
        ),
        DropdownMenuItem(
          child: Text("SHOP"),
          value: "SHOP",
        ),
         DropdownMenuItem(
          child: Text("SOFTWARE HOUSE"),
          value: "SOFTWARE HOUSE",
        ),
         DropdownMenuItem(
          child: Text("STREET LIGHT"),
          value: "STREET LIGHT",
        ),
         DropdownMenuItem(
          child: Text("TELECOM TOWER"),
          value: "TELECOM TOWER",
        ),
         DropdownMenuItem(
          child: Text("WAREHOUSE"),
          value: "WAREHOUSE",
        ),
        DropdownMenuItem(
          child: Text("SELF CONTAIN"),
          value: "SELF CONTAIN",
        ),
         DropdownMenuItem(
          child: Text("BOYS QTRS"),
          value: "BOYS QTRS",
        ),
         DropdownMenuItem(
          child: Text("DUPLEX"),
          value: "DUPLEX",
        ),
];
