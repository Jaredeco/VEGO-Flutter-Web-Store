import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:webstore/models/order_model.dart';
import 'package:webstore/constants/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminController extends GetxController {
  static AdminController instance = Get.find();
  var pickedImages = <XFile>[].obs;
  var country = "Select your country".obs;
  var orders = <OrderModel>[].obs;
  var isCreating = false.obs;

  @override
  void onInit() async {
    orders.bindStream(loadOrders());
    super.onInit();
  }

  void loading(bool isl){
    isCreating.value = isl;
    update();
  }

  Stream<List<OrderModel>> loadOrders() {
    Stream<QuerySnapshot> ordersStream =
        firebaseFirestore.collection("Orders").snapshots();
    return ordersStream.map((qSnap) => qSnap.docs
        .map((docSnap) => OrderModel.fromDocSnapshot(docSnap))
        .toList());
  }

  void addImages(List<XFile> imgs) {
    pickedImages += imgs;
    update();
  }

  void setCountry(String val){
    country.value = val;
    update();
  }

  Future uploadImages(List<XFile> images) async {
    List<String> imagesUrls = [];
    await Future.forEach(images, (XFile _image) async {
      Reference storageReference = FirebaseStorage.instance
          .refFromURL("gs://webstore-70cda.appspot.com")
          .child('products/${_image.name}');
      UploadTask uploadTask =
          storageReference.putData(await _image.readAsBytes());
      await uploadTask.whenComplete(() async {
        await storageReference
            .getDownloadURL()
            .then((value) => imagesUrls.add(value));
      });
    });
    return imagesUrls;
  }
}
