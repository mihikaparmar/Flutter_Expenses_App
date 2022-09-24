import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp/db/db_service.dart';
import 'package:myapp/models/transaction_account_detail.dart';
import 'package:myapp/models/transaction_model.dart';
import 'package:myapp/screens/splash_screen/splash_screen.dart';
import 'package:myapp/services/app_binding/app_binding.dart';

import 'models/account_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.registerAdapter(TransActionModelAdapter());
  Hive.registerAdapter(AccountModelAdapter());
  Hive.registerAdapter(TransactionAccountDetailAdapter());
  await Hive.initFlutter();
  await Hive.openBox<int>("outerLayer");
  await Hive.openBox<String>(userName);
  await Hive.openBox<AccountModel>(myBalance);
  await Hive.openBox<TransActionModel>(transitionList);
  await Hive.openBox<TransactionAccountDetailModel>(myTransactionAccountDetail);
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return ScreenUtilInit(
      builder: () => GetMaterialApp(
        initialBinding: MyBinding(),
        useInheritedMediaQuery: true,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(brightness: Brightness.dark),
        // ignore: prefer_const_constructors

        home: const SplashScreen(),
      ),
    );
  }
}
