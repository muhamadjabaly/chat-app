import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './screens/chat_screen.dart';
import './screens/auth_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        backgroundColor: Colors.pink,
        accentColor: Colors.deepPurple,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.pink,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      home: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (ctx, userSnapshot) {
          if(userSnapshot.connectionState == ConnectionState.waiting){
            return Center(
                  child: CircularProgressIndicator(),
                );
          } return StreamBuilder(
                  stream: FirebaseAuth.instance.idTokenChanges(),
                  builder: (ctx, steamSnapshot) {
                    if(steamSnapshot.hasData){
                      return ChatScreen();
                    }
                    return AuthScreen();
                  },
                );
        },
      ),
    );
  }
}
