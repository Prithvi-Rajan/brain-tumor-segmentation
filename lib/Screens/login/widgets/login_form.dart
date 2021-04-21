import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../login_service.dart';

class LoginForm extends StatefulWidget {
  final paddingTopForm,
      fontSizeTextField,
      fontSizeTextFormField,
      spaceBetweenFields,
      iconFormSize;
  final spaceBetweenFieldAndButton,
      widthButton,
      fontSizeButton,
      fontSizeForgotPassword,
      fontSizeSnackBar,
      errorFormMessage;

  LoginForm(
      this.paddingTopForm,
      this.fontSizeTextField,
      this.fontSizeTextFormField,
      this.spaceBetweenFields,
      this.iconFormSize,
      this.spaceBetweenFieldAndButton,
      this.widthButton,
      this.fontSizeButton,
      this.fontSizeForgotPassword,
      this.fontSizeSnackBar,
      this.errorFormMessage);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();

  final _passwordController = TextEditingController();

  bool isLoggingIn = false;
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    final double widthSize = MediaQuery.of(context).size.width;
    final double heightSize = MediaQuery.of(context).size.height;

    return Form(
        key: _formKey,
        child: Padding(
            padding: EdgeInsets.only(
                left: widthSize * 0.05,
                right: widthSize * 0.05,
                top: heightSize * widget.paddingTopForm),
            child: Column(children: <Widget>[
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('E-mail',
                      style: TextStyle(
                          fontSize: widthSize * widget.fontSizeTextField,
                          fontFamily: 'Poppins',
                          color: Colors.white))),
              TextFormField(
                  controller: _usernameController,
                  validator: (value) {
                    return value.isEmpty ? 'E-mail cannot be empty!' : null;
                  },
                  cursorColor: Colors.white,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 2)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2)),
                    labelStyle: TextStyle(color: Colors.white),
                    errorStyle: TextStyle(
                        color: Colors.white,
                        fontSize: widthSize * widget.errorFormMessage),
                    prefixIcon: Icon(
                      Icons.person,
                      size: widthSize * widget.iconFormSize,
                      color: Colors.white,
                    ),
                  ),
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: widget.fontSizeTextFormField)),
              SizedBox(height: heightSize * widget.spaceBetweenFields),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Password',
                      style: TextStyle(
                          fontSize: widthSize * widget.fontSizeTextField,
                          fontFamily: 'Poppins',
                          color: Colors.white))),
              TextFormField(
                  controller: _passwordController,
                  validator: (value) {
                    return value.isEmpty ? 'Password cannot be empty!' : null;
                  },
                  cursorColor: Colors.white,
                  keyboardType: TextInputType.text,
                  obscureText: hidePassword,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 2)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2)),
                      labelStyle: TextStyle(color: Colors.white),
                      errorStyle: TextStyle(
                          color: Colors.white,
                          fontSize: widthSize * widget.errorFormMessage),
                      prefixIcon: Icon(
                        Icons.lock,
                        size: widthSize * widget.iconFormSize,
                        color: Colors.white,
                      ),
                      suffixIcon: IconButton(
                          icon: Icon(
                            Icons.remove_red_eye,
                            color: Colors.white,
                          ),
                          onPressed: () => setState(() {
                                hidePassword = !hidePassword;
                              }))),
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: widget.fontSizeTextFormField)),
              SizedBox(height: heightSize * widget.spaceBetweenFieldAndButton),
              FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  padding: EdgeInsets.fromLTRB(
                      widget.widthButton, 15, widget.widthButton, 15),
                  color: Colors.white,
                  onPressed: tryLogIn,
                  child: isLoggingIn
                      ? CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Color.fromRGBO(41, 187, 255, 1)),
                        )
                      : Text('Login',
                          style: TextStyle(
                              fontSize: widthSize * widget.fontSizeButton,
                              fontFamily: 'Poppins',
                              color: Color.fromRGBO(41, 187, 255, 1)))),
              SizedBox(height: heightSize * 0.01),
              Text('Forgot my Password',
                  style: TextStyle(
                      fontSize: widthSize * widget.fontSizeForgotPassword,
                      fontFamily: 'Poppins',
                      color: Colors.white))
            ])));
  }

  void tryLogIn() async {
    Navigator.pushNamed(context, '/main');
    if (_formKey.currentState.validate()) {
      try {
        setState(() {
          isLoggingIn = true;
        });
        LoginService loginService = LoginService();
        await loginService.loginWithEmailPassword(
            email: _usernameController.text,
            password: _passwordController.text);
        // setState(() {
        //   isLoggingIn = false;
        // });
        Navigator.pushNamed(context, '/main');
      } catch (e) {
        setState(() {
          isLoggingIn = false;
        });
        print(e.toString());
      }
    }
  }
}
