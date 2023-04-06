import 'dart:io';
import 'package:chat_app/widgets/pickers/user_image_picker.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {

  AuthForm(this.submitFn, this.isLoading);
  var isLoading;
  
  void Function(
    String email,
    String userName,
    File image,
    String password,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';
  File _userImageFile;

  void _pickedImage(File image) {
    _userImageFile = image;
  }
  
  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if(_userImageFile == null && !_isLogin){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please pick an image')));
      return;
    }

    if(isValid){
      _formKey.currentState.save();
      widget.submitFn(
        _userEmail.trim(),
        _userName.trim(),
        _userImageFile,
        _userPassword,
        _isLogin,
        context
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
          color: Colors.black,
          shadowColor: Theme.of(context).colorScheme.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
          elevation: 100,
          margin: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if(!_isLogin)
                    UserImagePicker(_pickedImage),
                    TextFormField(
                      key: const ValueKey('email'),
                      textCapitalization: TextCapitalization.none,
                      validator: (value) {
                        if(value.isEmpty || !value.contains('@')){
                          return 'Please enter a valid Email';
                        }
                        return null;
                      },
                       onSaved: (value) {
                        _userEmail = value;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(
                          color: Colors.black,
                          width: 1
                          )
                        )
                      ),
                    ),
                    const SizedBox(height: 10,),
                    if(!_isLogin)
                    TextFormField(
                      key: const ValueKey('username'),
                      textCapitalization: TextCapitalization.words,
                       validator: (value) {
                        if(value.isEmpty){
                          return 'Please enter a valid Username';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _userName = value;
                      },
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(
                          color: Colors.black,
                          width: 1
                          )
                        )
                      ),
                    ),

                    const SizedBox(height: 10,),
                    TextFormField(
                      key: const ValueKey('password'),
                       validator: (value) {
                        if(value.isEmpty || value.length < 7){
                          return 'Password must have at least 7 characters';
                        }
                        return null;
                      },
                       onSaved: (value) {
                        _userPassword = value;
                      },
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.key),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(
                          color: Colors.black,
                          width: 1
                          )
                        )
                      ),
                    ),
                    const SizedBox(height: 12,),
                    if(widget.isLoading) const CircularProgressIndicator(),
                    if(!widget.isLoading)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                          )
                      ),
                      onPressed: _trySubmit, 
                      child: Text(_isLogin ?'LogIn': 'SignUp')),
                    if(!widget.isLoading)
                    TextButton(
                      onPressed: (){
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      }, 
                      child: Text( _isLogin ? 'Create new account' : 'I already have an Account'))
                  ],
                ),
                ),
              ),
          ),
        ),
      );
  }
}