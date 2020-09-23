import 'package:flutter/material.dart';

class Bill {
  final String IBC_NAME;
  final String BSC_NAME;
  final String CONS_NAME;
  final String METER_NO;
  final String CUSTOMER_NO;
  final String CONS_TYPE;
  final double CURRENT_AMOUNT;
  final String ADDRESS;
  final double TOTAL_BILL;
  final String TARIFFCODE;
  final double ARREAR;

  Bill(
      {@required this.IBC_NAME,
      @required this.BSC_NAME,
      @required this.CONS_NAME,
      @required this.METER_NO,
      @required this.CUSTOMER_NO,
      @required this.CONS_TYPE,
      @required this.CURRENT_AMOUNT,
      @required this.ADDRESS,
      @required this.TOTAL_BILL,
      @required this.ARREAR,
      @required this.TARIFFCODE
      });
}
