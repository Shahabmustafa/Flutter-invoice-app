

class Calculation{

  multiply(String firstNumber,String secondNumber){
    final a = int.parse(firstNumber);
    final b = int.parse(secondNumber);
    var c = a * b;
    return c.toString();
  }
}