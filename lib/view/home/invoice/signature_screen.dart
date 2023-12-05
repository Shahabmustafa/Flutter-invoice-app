import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/component/app_button.dart';
import 'package:hand_signature/signature.dart';

class SignaturePage extends StatefulWidget {
  const SignaturePage({Key? key}) : super(key: key);

  @override
  State<SignaturePage> createState() => _SignaturePageState();
}

class _SignaturePageState extends State<SignaturePage> {
  // final GlobalKey<SignatureState> _signatureKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Signature"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: Container(
              height: size.height * 0.4,
              width: size.width * 0.9,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
              child: HandSignature(
                type: SignatureDrawType.line,
                color: Colors.black,
                control: HandSignatureControl(),
              ),
              // SignatureView(
              //   // canvas color
              //   backgroundColor: Colors.white30,
              //   penStyle: Paint()
              //   // pen color
              //     ..color = Color.fromARGB(255,0,0,0)
              //   // type of pen point circular or rounded
              //     ..strokeCap = StrokeCap.round
              //   // pen pointer width
              //     ..strokeWidth = 2.0,
              //   // data of the canvas
              //   onSigned: (data) {
              //   },
              // ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AppButton(
                height: size.height * 0.05,
                width: size.width * 0.4,
                title: "Clear",
                onTap: (){
                  setState(() {});
                },
              ),
              AppButton(
                height: size.height * 0.05,
                width: size.width * 0.4,
                title: "Save",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
