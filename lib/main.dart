import 'package:flutter/material.dart';

import 'module-13/module_13_class_1_crud.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(
          appBarTheme: AppBarTheme(
              backgroundColor: Colors.amber,
              foregroundColor: Colors.white,
              centerTitle: true,
              titleTextStyle: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
              )
          )
      ),
      debugShowCheckedModeBanner: false,
      title: 'Rest API',
      home: Module13Class1Crud(),
    );
  }
}
