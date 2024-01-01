

import 'package:intl/intl.dart';

class Calculation{

  multiply(String firstNumber,String secondNumber){
    final a = int.parse(firstNumber);
    final b = int.parse(secondNumber);
    var c = a * b;
    return c.toString();
  }

  date(){
    DateTime now = DateTime.now();
    String todayDate = DateFormat('MMMM dd, yyyy').format(now);
    return todayDate;
  }
}