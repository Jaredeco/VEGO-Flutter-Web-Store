import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:webstore/constants/controllers.dart';
import 'package:webstore/constants/routes.dart';
import 'package:webstore/controllers/admin_controller.dart';
import 'package:webstore/controllers/bag_controller.dart';
import 'package:webstore/controllers/order_controller.dart';
import 'package:webstore/controllers/product_controller.dart';
import 'package:webstore/screens/landing/home_page.dart';
import 'constants/firebase.dart';

void main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await initialization.then((value) {
    Get.put(ProductController());
    Get.put(BagController());
    Get.put(OrderController());
    Get.put(AdminController());
  });
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FlouroRouter.setupRouter();
    bagController.getStoredProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: FlouroRouter.router.generator,
      debugShowCheckedModeBanner: false,
      title: 'VEGO',
      theme: ThemeData(primarySwatch: primaryBlack, fontFamily: 'Sora'),
      home: const HomePage(),
    );
  }
}

const MaterialColor primaryBlack = MaterialColor(
  _blackPrimaryValue,
  <int, Color>{
    50: Color(0xFF000000),
    100: Color(0xFF000000),
    200: Color(0xFF000000),
    300: Color(0xFF000000),
    400: Color(0xFF000000),
    500: Color(_blackPrimaryValue),
    600: Color(0xFF000000),
    700: Color(0xFF000000),
    800: Color(0xFF000000),
    900: Color(0xFF000000),
  },
);
const int _blackPrimaryValue = 0xFF000000;
