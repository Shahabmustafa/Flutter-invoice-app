import 'package:emailjs/emailjs.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class MessageSender{
  void launchWhatsApp({required String phone,required String message,}) async  {
    final _url = Uri.parse("https://wa.me/$phone?text=$message");
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  void launchMessage({required String phone,required String messages,}) async  {
    final url = Uri.parse('sms:${phone}?body=${messages}');
    if (!await canLaunchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  sendMessage(String userName,String userMessage,String email)async{
    try{
      await EmailJS.send(
        "service_dj5j4y6",
        "template_gwcbryc",
        {
          'user_name': userName,
          'user_message': userMessage,
          "user_subject" : "Invoice",
          "user_email" : email,
        },
        const Options(
          publicKey: 'gE3tYnHPa5YJTWzTX',
          privateKey: 'ld8FMFC3s9ZZGIqbfj1ZM',
        ),
      ).then((value){
        Get.back();
      });
      print('SUCCESS!');
    }catch (error) {
      if (error is EmailJSResponseStatus) {
        print('ERROR... ${error.status}: ${error.text}');
      }
      print(error.toString());
    }
  }
}