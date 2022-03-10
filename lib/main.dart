import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoom/compnement/const.dart';
import 'package:zoom/cubit/cubit.dart';
import 'package:zoom/cubit/state.dart';
import 'package:zoom/moduels/home/home.dart';
import 'package:zoom/moduels/login/login.dart';
import 'package:zoom/share/cache_elper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  uid = CacheHelper.getData(key: kUid);
  print(uid);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) => HomeCubit()..getUserData(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            home: uid != null ? Home() : Login(),
          );
        },
      ),
    );
  }
}
