import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/assets/assets_url.dart';
import 'package:flutter_invoice_app/res/colors/app_colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  TextEditingController category = TextEditingController();
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Category"),
      ),
      body: StreamBuilder(
        stream:  FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("categori").snapshots(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            if(snapshot.data!.docs.isEmpty){
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.square_grid_2x2,color: AppColor.primaryColor,size: 100,),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      "Category is Empty",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              );
            }else{
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 7.5),
                    child: Container(
                      height: 60,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: AppColor.whiteColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 0.8,
                            color: Colors.grey,
                            offset: Offset(0.3, 0.2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(snapshot.data!.docs[index]["category"],style: GoogleFonts.lato(fontWeight: FontWeight.w600,fontSize: 16),),
                          Row(
                            children: [
                              IconButton(
                                onPressed: (){
                                  showDialog(
                                    context: context,
                                    builder: (context){
                                      TextEditingController updateCategory = TextEditingController(text: snapshot.data!.docs[index]["category"]);
                                      return AlertDialog(
                                        title: Center(child: Text("Update Category")),
                                        actions: [
                                          Form(
                                            key: _key,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                TextFormField(
                                                  cursorColor: AppColor.primaryColor,
                                                  cursorHeight: 18,
                                                  controller: updateCategory,
                                                  validator: (value){
                                                    return value!.isEmpty ? "Please Enter Category" : null;
                                                  },
                                                  decoration: InputDecoration(
                                                    labelText: "Category",
                                                  ),
                                                ),
                                                SizedBox(height: 20,),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                        backgroundColor: AppColor.whiteColor,
                                                        foregroundColor: AppColor.primaryColor,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(10),
                                                          side: BorderSide(
                                                            color: AppColor.primaryColor,
                                                          ),
                                                        ),
                                                      ),
                                                      onPressed: (){
                                                        Get.back();
                                                      },
                                                      child: Text("Cancel"),
                                                    ),
                                                    ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                        backgroundColor: AppColor.primaryColor,
                                                        foregroundColor: AppColor.whiteColor,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(10),
                                                          side: BorderSide(
                                                            color: AppColor.primaryColor,
                                                          ),
                                                        ),
                                                      ),
                                                      onPressed: (){
                                                        if(_key.currentState!.validate()){
                                                          FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("categori").doc(snapshot.data!.docs[index].id).update({
                                                            "category" : updateCategory.text.trim(),
                                                          }).then((value){
                                                            category.clear();
                                                            Get.back();
                                                          });
                                                        }
                                                      },
                                                      child: Text("Add"),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                icon: AssetsUrl.categoryEditSvgIcon,
                              ),
                              IconButton(
                                onPressed: (){
                                  FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("categori").doc(snapshot.data!.docs[index].id).delete();
                                },
                                icon: Icon(CupertinoIcons.delete,size: 22,color: AppColor.errorColor,),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          }else{
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          showDialog(
            context: context,
            builder: (context){
              return AlertDialog(
                title: Center(child: Text("Add Category")),
                actions: [
                  Form(
                    key: _key,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          cursorColor: AppColor.primaryColor,
                          cursorHeight: 18,
                          controller: category,
                          validator: (value){
                            return value!.isEmpty ? "Please Enter Category" : null;
                          },
                          decoration: InputDecoration(
                            labelText: "Category",
                          ),
                        ),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.whiteColor,
                                foregroundColor: AppColor.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                    color: AppColor.primaryColor,
                                  ),
                                ),
                              ),
                              onPressed: (){
                                Get.back();
                              },
                              child: Text("Cancel"),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.primaryColor,
                                foregroundColor: AppColor.whiteColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                    color: AppColor.primaryColor,
                                  ),
                                ),
                              ),
                              onPressed: (){
                                if(_key.currentState!.validate()){
                                  FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("categori").add({
                                    "category" : category.text.trim(),
                                  }).then((value){
                                    category.clear();
                                    Get.back();
                                  });
                                }
                              },
                              child: Text("Add"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
        label: Text("Add Category"),
      ),
    );
  }
}
