// /// Forward pattern hatch bar chart example
// import 'package:flutter/material.dart';
// import 'package:charts_flutter/flutter.dart' as charts;

// /// Forward hatch pattern horizontal bar chart example.
// ///
// /// The second series of bars is rendered with a pattern by defining a
// /// fillPatternFn mapping function.
// class HorizontalPatternForwardHatchBarChart extends StatelessWidget {
 
//  /* final List<charts.Series> seriesList;
//   final bool animate;
  
//   HorizontalPatternForwardHatchBarChart(this.seriesList, {this.animate});

//   factory HorizontalPatternForwardHatchBarChart.withSampleData() {
//     return new HorizontalPatternForwardHatchBarChart(
//       _createSampleData(),
//       // Disable animations for image tests.
//       animate: false,
//     );
//   }
// */

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
//         padding: EdgeInsets.all(12.0),
//         width: double.infinity,
//         decoration: BoxDecoration(
//           color: Colors.white,
//             borderRadius: BorderRadius.circular(10.0),
//             boxShadow: [
//               BoxShadow(blurRadius: 6.0, offset: Offset(0,2), color: Colors.black12)
//             ]
//         ),
//         child: Column(
//           children: <Widget>[
//             Text("Cumulative Collection Chart as 28th june 2020",
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               color: Colors.blue
//             ),
//             ),
//             Container(
//               height: 250.0,
//               child: new charts.BarChart(
//                 _createSampleData(),
//                 animate: false,
//                 barGroupingType: charts.BarGroupingType.grouped,
//                 vertical: false,
//               ),
//             ),
//             SizedBox(height: 15.0,),
//             Row(
//               children: <Widget>[
//                 Container(
//                   width: 10.0,
//                   height: 10.0,
//                   color: Colors.orange,
//                 ),
//                 Text("Collection"),
//                 SizedBox(width: 15.0,),
//                  Container(
//                   width: 10.0,
//                   height: 10.0,
//                   color: Colors.blue,
//                 ),
//                 Text("Billed Amount"),

//               ],
//             ),
//             SizedBox(height: 12.0,),
//             Container(
//               child: Row(
//                 children: <Widget>[
//                   Text("A => Total"),
//                   SizedBox(width: 8.0,),
//                   Text("B => NonMD Postpaid"),
//                 ],
//               ),
//             ),
//             SizedBox(height: 12.0,),
//             Container(
//               child: Row(
//                 children: <Widget>[
//                   Text("C => PPM"),
//                   SizedBox(width: 15.0,),
//                   Text("D => MD"),
//                 ],
//               ),
//             ),
//             SizedBox(height: 12.0,),
//             Container(
//               child: Row(
//                 children: <Widget>[
//                   Text("E => Bank uncaptured payment"),
//                 ],
//               ),
//             )
//           ],
//         ),
//     );
//   }

//   /// Create series list with multiple series
//   List<charts.Series<OrdinalSales, String>> _createSampleData() {
//     final desktopSalesData = [
//       new OrdinalSales('A', 500),
//       new OrdinalSales('B', 1000),
//       new OrdinalSales('C', 400),
//       new OrdinalSales('D', 3100),
//       new OrdinalSales('E', 1200),
//     ];

//     final mobileSalesData = [
//       new OrdinalSales('A', 750),
//       new OrdinalSales('B', 2600),
//       new OrdinalSales('C', 2000),
//       new OrdinalSales('D', 5000),
//       new OrdinalSales('E', 4100),
//     ];

//     return [
//       new charts.Series<OrdinalSales, String>(
//         id: 'Desktop',
//         domainFn: (OrdinalSales sales, _) => sales.year,
//         measureFn: (OrdinalSales sales, _) => sales.sales,
//         data: desktopSalesData,
//         fillColorFn: (OrdinalSales sales, _) => charts.Color.fromHex(code: "#ffa500")
//       ),
//       new charts.Series<OrdinalSales, String>(
//         id: 'Mobile',
//         domainFn: (OrdinalSales sales, _) => sales.year,
//         measureFn: (OrdinalSales sales, _) => sales.sales,
//         data: mobileSalesData,
//       ),
//     ];
//   }
// }

// /// Sample ordinal data type.
// class OrdinalSales {
//   final String year;
//   final int sales;

//   OrdinalSales(this.year, this.sales);
// }