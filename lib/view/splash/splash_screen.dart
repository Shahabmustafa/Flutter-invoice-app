import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/assets/assets_url.dart';
import 'package:flutter_invoice_app/view%20model/splash%20service/splash_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  SplashService splashService = SplashService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashService.splashService();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
              child: Image.asset(
                AssetsUrl.appLogo,
                height: 150,
                width: 150,
              ),
          ),
          Text(
            "Invoice",
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
