import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mvp/repositories/Steam/abstract_lib_steam.dart';
import 'package:mvp/repositories/Steam/lib_steam.dart';
import 'app.dart';

import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



void main() async{

  void initFirebase() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  GetIt.I.registerLazySingleton<AbstractLibSteam>
    (() => LibSteam(dio: Dio()));
  initFirebase();
  runApp(const mvp());
}


