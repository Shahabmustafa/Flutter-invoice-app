import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/app_api/app_api_service.dart';
import 'package:flutter_invoice_app/res/component/app_button.dart';
import 'package:flutter_invoice_app/utils/utils.dart';
import 'package:hand_signature/signature.dart';
import 'dart:ui' as ui;

import 'package:signature/signature.dart';

class SignaturePage extends StatefulWidget {
  const SignaturePage({Key? key}) : super(key: key);

  @override
  State<SignaturePage> createState() => _SignaturePageState();
}

class _SignaturePageState extends State<SignaturePage> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

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
            child: Signature(
              controller: _controller,
              height: size.height * 0.35,
              width: size.width * 0.9,
              backgroundColor: Colors.grey.shade300,
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
                  _controller.clear();
                },
              ),
              AppButton(
                height: size.height * 0.05,
                width: size.width * 0.4,
                title: "Save",
                onTap: (){
                  uploadSignatureToFirebase();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
  Future<void> uploadSignatureToFirebase() async {
    try {
      // Convert signature to image
      ui.Image? image = await _controller.toImage(
        width: 250,
        height: 250,
        // color: Colors.black,
        // size: Size(200.0, 100.0),
      );
      ByteData? byteData = await image!.toByteData(format: ui.ImageByteFormat.png);
      Uint8List imageData = byteData!.buffer.asUint8List();
      // Upload image data to Firebase Storage
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref(AppApiService.userId).child().child("signature");
      UploadTask uploadTask = ref.putData(imageData);
      await uploadTask.whenComplete(() => null);

      String imageUrl = await ref.getDownloadURL();
      await AppApiService.invoice.doc(formattedDate).update({
        "signature" : imageUrl,
      });
      Utils.flutterToast('Signature uploaded to Firebase Storage: $imageUrl');
    } catch (e) {
      Utils.flutterToast('Error uploading signature: $e');
    }
  }
}
