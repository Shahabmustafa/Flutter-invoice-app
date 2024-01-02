import 'package:intl/intl.dart';

class Calculation{

  multiply(String firstNumber,String secondNumber){
    final a = double.parse(firstNumber);
    final b = double.parse(secondNumber);
    var c = a * b;
    return c.toString();
  }

  date(){
    DateTime now = DateTime.now();
    String todayDate = DateFormat('MMMM dd, yyyy').format(now);
    return todayDate;
  }

  doubleConvertInt(String a){
    String val = a.toString();
    val = val.replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "");
    return val;
  }
}