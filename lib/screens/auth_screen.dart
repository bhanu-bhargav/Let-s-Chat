import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/widgets/auth/auth_form.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  
  var _isLoading = false;

  void _submitAuthForm(
    String email,
    String userName,
    File image,
    String password,
    bool isLogin,
    BuildContext ctx,
    ) async{

    // await Firebase.initializeApp();
    final _auth = FirebaseAuth.instance;
    UserCredential authResult;
    
    
    try {
      setState(() {
        _isLoading = true;
      });
      if(isLogin){
      authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
    }
    else{
      authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      final ref = FirebaseStorage.instance.ref().child('user_image').child('${authResult.user.uid}.jpg');
      await ref.putFile(image);
      final url = await ref.getDownloadURL();

      await FirebaseFirestore.instance
      .collection('users')
      .doc(authResult.user.uid)
      .set({
        'username': userName,
        'email': email,
        'image_url': url
      });
    }
    }
    catch(err) {
      var message = 'An error occured, please check your credientials';

      if(err.message != null){
        message = err.message;
      }
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          // backgroundColor: Theme.of(ctx).errorColor,
          ),);
      setState(() {
        _isLoading = false;
      });
    }
    // catch(err){
    //   print(err);
    // }
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: AuthForm(_submitAuthForm, _isLoading),
    );
    
  }
}