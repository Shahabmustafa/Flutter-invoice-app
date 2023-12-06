import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/colors/app_colors.dart';

class TableWidget extends StatelessWidget {
  TableWidget({Key? key,required this.itemName,required this.itemCost,required this.itemQuantity,required this.total,required this.onTap}) : super(key: key);
  String itemName;
  String itemCost;
  String itemQuantity;
  String total;
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(10),
        height: 250,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          boxShadow: [
            BoxShadow(
              color: AppColor.grayColor,
              blurRadius: 5,
              spreadRadius: 0.01,
              offset: Offset(1,2)
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: onTap,
                  child: Icon(
                    Icons.delete,
                    color: AppColor.errorColor,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Item Name",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  itemName,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Item Cost",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  itemCost,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Item Quantity",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  itemQuantity,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Divider(thickness: 2,color: AppColor.primaryColor,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  total,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
