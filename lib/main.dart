import 'package:flutter/material.dart';
import 'package:login/Figma.dart';
import 'package:login/login.dart';
import 'package:login/register.dart';
import 'package:login/Home.dart';
import 'package:login/Api.dart';
import 'package:login/ruf.dart';
import 'package:login/splash.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/gestures.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    // initialRoute: "login",
    //  routes: {
    //       "/":(context)=>Api(),
    //       "/login": (context)=>login(),
    //       "/register": (context)=>register(),
    //       "/home": (context)=>Home(),
    //  },
     home: Figma(),
  ));
}

