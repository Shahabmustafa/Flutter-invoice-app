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

  addTwoValue(String firstNumber,String secondNumber){
    final a = double.parse(firstNumber);
    final b = int.parse(secondNumber);
    var c = a + b;
    return c.toString();
  }

  stringConvertToIntInList(List stringList) {
    List<String>? stringList;
    List<int> intList = stringList!.map((str) => int.parse(str)).toList();
    return intList;
  }


  int addValueInList(List numbers) {
    List<int>? numbers;
    int sum = numbers!.fold(0, (previousValue, element) => previousValue + element);
    return sum;
  }

  doubleConvertInt(String a){
    String val = a.toString();
    val = val.replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "");
    return val;
  }
}