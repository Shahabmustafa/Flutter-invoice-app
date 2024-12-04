import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/assets/assets_url.dart';
import 'package:flutter_invoice_app/res/colors/app_colors.dart';
import 'package:flutter_invoice_app/view%20model/splash%20service/splash_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

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
      backgroundColor: Theme.of(context).splashColor,
      body: Shimmer.fromColors(
        baseColor: AppColor.primaryColor,
        highlightColor: Colors.grey.shade200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
                child: Image.asset(
                  AssetsUrl.appLogo,
                  height: 150,
                  width: 150,
                ),
            ),
            Column(
              children: [
                Text(
                  "Invoice",
                  style: GoogleFonts.abhayaLibre(
                    fontSize: 40,
                  ),
                ),
                // SizedBox(
                //   height: 40,
                // ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 100),
                //   child: LinearProgressIndicator(
                //     color: AppColor.primaryColor,
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
