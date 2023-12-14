import 'package:flutter/material.dart';

class CustomerContainer extends StatelessWidget {
  CustomerContainer({Key? key,required this.onTap,required this.customerName,required this.customerNumber}) : super(key: key);
  String customerName;
  String customerNumber;
  VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: Container(
          height: size.height * 0.1,
          width: size.width * 0.5,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade500,
                spreadRadius: 0.1,
                blurRadius: 3,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Customer Name",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                    customerName,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Divider(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Phone Number",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      customerNumber,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
