import 'package:customer_app/scoped-model/bill.dart';
import 'package:customer_app/scoped-model/user.dart';
import 'package:scoped_model/scoped_model.dart';
import './bill.dart';
import './user.dart';

class MainModel extends Model with UserModel,BillModel{

}