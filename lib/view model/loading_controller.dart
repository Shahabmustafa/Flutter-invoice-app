import 'package:get/get.dart';

class LoadingController extends GetxController{

  RxBool loading = false.obs;

  setLoading(bool value){
    loading.value = value;
  }
}