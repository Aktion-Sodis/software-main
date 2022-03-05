import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_app/backend/Blocs/auth/auth_credentials.dart';
import 'package:mobile_app/backend/Blocs/session/session_cubit.dart';
import 'package:mobile_app/frontend/dependentsizes.dart';

import 'package:mobile_app/frontend/strings.dart' as strings;

class UpdatePasswordView extends StatefulWidget {
  AuthCredentials authCredentials;
  SessionCubit sessionCubit;

  UpdatePasswordView(
      {Key? key, required this.authCredentials, required this.sessionCubit})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return UpdatePasswordViewState();
  }
}

class UpdatePasswordViewState extends State<UpdatePasswordView> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  late TextEditingController textEditingControllerOne;
  late TextEditingController textEditingControllerTwo;

  @override
  void initState() {
    textEditingControllerOne = TextEditingController();
    textEditingControllerTwo = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textEditingControllerOne.dispose();
    textEditingControllerTwo.dispose();
    super.dispose();
  }

  bool passwordOneEmpty() => textEditingControllerOne.text.isEmpty;
  bool passwordTwoEmpty() => textEditingControllerTwo.text.isEmpty;
  bool passwordsEqual() =>
      textEditingControllerOne.text == textEditingControllerTwo.text;
  bool passwordIsValid() {
    String pw = textEditingControllerOne.text;
    bool minLengthDone = pw.length >= 6;
    bool containsNumber = pw.contains(RegExp(r'[0-9]'));
    bool containsUpperCase = pw.contains(RegExp(r'[A-Z]'));
    bool containsLowerCase = pw.contains(RegExp(r'[a-z]'));
    return minLengthDone &&
        containsNumber &&
        containsUpperCase &&
        containsLowerCase;
  }

  void changePassword() async {
    if (!loading) {
      setState(() {
        loading = true;
      });
      if (_formKey.currentState!.validate()) {
        //todo: implement
        AuthCredentials? newCredentials = await widget.sessionCubit.authRepo
            .updatePasswordInitially(
                widget.authCredentials, textEditingControllerOne.text.trim());

        if (newCredentials != null) {
          widget.sessionCubit.showSession(newCredentials);
        } else {
          setState(() {
            loading = false;
          });
          final snackBar =
              SnackBar(content: Text("An error occured. We are sorry!"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      } else {
        setState(() {
          loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.only(
            left: width(context) * .1,
            right: width(context) * .1,
            top: width(context) * .1,
            bottom: width(context) * .1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                child: TextFormField(
              controller: textEditingControllerOne,
              textInputAction: TextInputAction.next,
              autocorrect: false,
              enableSuggestions: false,
              obscureText: true,
              decoration: InputDecoration(
                  prefixIcon: const Icon(FontAwesomeIcons.key),
                  hintText: strings.new_password,
                  labelText: !passwordOneEmpty() ? strings.new_password : null),
              validator: (value) => passwordOneEmpty()
                  ? strings.enterpassword
                  : !passwordIsValid()
                      ? strings.invalid_password
                      : !passwordsEqual()
                          ? strings.not_same_password
                          : null,
            )),
            Container(
                margin: EdgeInsets.only(top: defaultPadding(context)),
                child: TextFormField(
                  controller: textEditingControllerTwo,
                  textInputAction: TextInputAction.go,
                  onFieldSubmitted: (_) => changePassword(),
                  autocorrect: false,
                  enableSuggestions: false,
                  obscureText: true,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(FontAwesomeIcons.key),
                      hintText: strings.new_password_validation,
                      labelText: !passwordTwoEmpty()
                          ? strings.new_password_validation
                          : null),
                  validator: (value) => passwordTwoEmpty()
                      ? strings.enterpassword
                      : !passwordIsValid()
                          ? strings.invalid_password
                          : !passwordsEqual()
                              ? strings.not_same_password
                              : null,
                )),
            Container(
                margin: EdgeInsets.only(top: defaultPadding(context)),
                child: loading
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            CircularProgressIndicator(color: Colors.green)
                          ])
                    : ElevatedButton(
                        style: ButtonStyle(
                          textStyle: MaterialStateProperty.all(
                              TextStyle(fontSize: 18)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          minimumSize: MaterialStateProperty.all(
                              Size(width(context) * .8, width(context) * .12)),
                          backgroundColor: MaterialStateProperty.all(
                              Colors.green), //todo: change
                        ),
                        onPressed: () {
                          changePassword();
                        },
                        child: Text(strings.save_password),
                      ))
          ],
        ),
      ),
    ));
  }
}
