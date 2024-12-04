import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../res/routes/routes.dart';

class DeleteAccountController extends GetxController{

  RxBool _loading = false.obs;
  RxBool get loading => _loading;

  setLoading(bool value){
    _loading.value = value;
  }

  deleteAccount()async{
    setLoading(true);
    try{
      /// delete category
      CollectionReference category = FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("categori");
      QuerySnapshot querySnapshot = await category.get();
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        await doc.reference.delete();
      }

      /// delete dashboard
      CollectionReference dashboard = FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("dashboard");
      QuerySnapshot queryDashboard = await dashboard.get();
      for (QueryDocumentSnapshot doc in queryDashboard.docs) {
        await doc.reference.delete();
      }

      /// delete items
      CollectionReference items = FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("items");
      QuerySnapshot queryItems = await items.get();
      for (QueryDocumentSnapshot doc in queryItems.docs) {
        await doc.reference.delete();
      }

      /// delete saleInvoice
      CollectionReference saleInvoice = FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("saleInvoice");
      QuerySnapshot querySaleInvoice = await saleInvoice.get();
      for (QueryDocumentSnapshot doc in querySaleInvoice.docs) {
        await doc.reference.delete();
      }

      /// delete supplier
      CollectionReference supplier = FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("supplier");
      QuerySnapshot querySupplier = await supplier.get();
      for (QueryDocumentSnapshot doc in querySupplier.docs) {
        await doc.reference.delete();
      }

      /// delete customer
      CollectionReference customer = FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("customer");
      QuerySnapshot queryCustomer = await customer.get();
      for (QueryDocumentSnapshot doc in queryCustomer.docs) {
        await doc.reference.delete();
      }

      /// delete supplier installment
      CollectionReference supplierInstallment = FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("supplierInstallment");
      QuerySnapshot querySupplierInstallment = await supplierInstallment.get();
      for (QueryDocumentSnapshot doc in querySupplierInstallment.docs) {
        await doc.reference.delete();
      }

      /// delete customer installment
      CollectionReference customerInstallment = FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("customerInstallment");
      QuerySnapshot queryCustomerInstallment = await customerInstallment.get();
      for (QueryDocumentSnapshot doc in queryCustomerInstallment.docs) {
        await doc.reference.delete();
      }

      /// delete customer installment
      CollectionReference withDraw = FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("withdrawHistory");
      QuerySnapshot querywithDraw = await withDraw.get();
      for (QueryDocumentSnapshot doc in querywithDraw.docs) {
        await doc.reference.delete();
      }

      /// delete order
      CollectionReference order = FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("orders");
      QuerySnapshot querywithOrder = await order.get();
      for (QueryDocumentSnapshot doc in querywithOrder.docs) {
        await doc.reference.delete();
      }

      /// delete expense
      CollectionReference expense = FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("expense");
      QuerySnapshot querywithExpense = await expense.get();
      for (QueryDocumentSnapshot doc in querywithExpense.docs) {
        await doc.reference.delete();
      }


      FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).delete();
      await FirebaseAuth.instance.currentUser!.delete();
      setLoading(false);
      Get.toNamed(AppRoutes.loginScreen);
    }catch(e){
      setLoading(false);
    }
  }
}