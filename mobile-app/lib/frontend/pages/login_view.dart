import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_app/backend/Blocs/auth/auth_cubit.dart';
import 'package:mobile_app/backend/Blocs/auth/auth_repository.dart';
import 'package:mobile_app/backend/Blocs/auth/form_submission_status.dart';
import 'package:mobile_app/backend/Blocs/auth/login/login_bloc.dart';
import 'package:mobile_app/backend/Blocs/auth/login/login_event.dart';
import 'package:mobile_app/backend/Blocs/auth/login/login_state.dart';
import 'package:mobile_app/frontend/dependentsizes.dart';
import 'package:mobile_app/frontend/strings.dart' as strings;

class LoginView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: BlocProvider(
        create: (context) => LoginBloc(
          authRepo: context.read<AuthRepository>(),
          authCubit: context.read<AuthCubit>(),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _logo(context),
            _pic(context),
            _loginForm(),
          ],
        ),
      )),
    );
  }

  Widget _logo(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(width(context) * .1),
        constraints: BoxConstraints(maxHeight: height(context) * .07),
        child: Hero(
            tag: 'Logo_Hero',
            child: ClipRRect(
                child: Image.asset("assets/test/logo.png"),
                borderRadius: BorderRadius.circular(8))));
  }

  Widget _pic(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: width(context) * .1),
        child: ClipRRect(
            child: Image.asset("assets/test/demo_pic.jpg"),
            borderRadius: BorderRadius.circular(8)));
  }

  Widget _loginForm() {
    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          final formStatus = state.formStatus;
          if (formStatus is SubmissionFailed) {
            _showSnackBar(context, formStatus.exception.toString());
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) => Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: width(context) * .1,
                        right: width(context) * .1,
                        top: width(context) * .1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _loginText(),
                        _emailOrPhoneNumberField(),
                        _passwordField(),
                        _loginButton(),
                        //_loadingSign(),
                        _googleLogin()
                      ],
                    ),
                  ),
                )));
  }

  Widget _loginText() => Container(
      margin: EdgeInsets.only(left: 8),
      child: Text(strings.login, style: TextStyle(fontSize: 26)));

  Widget _emailOrPhoneNumberField() {
    String? labelText(LoginState loginState) {
      if (loginState.emailOrPhoneNotEmpty) {
        if (loginState.isPhoneNumber) {
          return strings.phonenumber;
        } else {
          return strings.email;
        }
      } else {
        return null;
      }
    }

    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return Container(
          margin: EdgeInsets.only(top: defaultPadding(context)),
          child: TextFormField(
            decoration: InputDecoration(
              prefixIcon: const Icon(FontAwesomeIcons.user),
              hintText: strings.emailorphonenumber,
              labelText: labelText(state),
            ),
            textInputAction: TextInputAction.next,
            enableSuggestions: true,
            validator: (value) => state.isPhoneNumber
                ? (state.isValidPhoneNumber
                    ? null
                    : strings.malformedphonenumber)
                : (state.isValidEmail ? null : strings.malformedemailmessage),
            onChanged: (value) => context.read<LoginBloc>().add(
                  LoginEmailOrPhoneNumberChanged(emailOrPhoneNumber: value),
                ),
          ));
    });
  }

  Widget _passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return Container(
          margin: EdgeInsets.only(top: defaultPadding(context)),
          child: TextFormField(
            textInputAction: TextInputAction.go,
            autocorrect: false,
            enableSuggestions: false,
            obscureText: true,
            decoration: InputDecoration(
                prefixIcon: const Icon(FontAwesomeIcons.key),
                hintText: strings.password,
                labelText: state.passwordNotEmpty ? strings.password : null),
            validator: (value) =>
                state.passwordNotEmpty ? null : strings.enterpassword,
            onChanged: (value) => context.read<LoginBloc>().add(
                  LoginPasswordChanged(password: value),
                ),
          ));
    });
  }

  Widget _loginButton() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                margin: EdgeInsets.only(top: defaultPadding(context)),
                child: state.formStatus is FormSubmitting
                    ? const CircularProgressIndicator(color: Colors.green)
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
                          if (_formKey.currentState!.validate()) {
                            context.read<LoginBloc>().add(LoginSubmitted());
                          }
                        },
                        child: Text(strings.login),
                      ))
          ]);
    });
  }

  Widget _googleLogin() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return Container(
          width: width(context) * .8,
          margin: EdgeInsets.only(top: defaultPadding(context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  margin: EdgeInsets.only(bottom: defaultPadding(context)),
                  child: Text(strings.or, style: TextStyle(fontSize: 18))),
              ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                  textStyle: MaterialStateProperty.all(
                      TextStyle(fontSize: 18, color: Colors.black)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
                  minimumSize: MaterialStateProperty.all(
                      Size(width(context) * .8, width(context) * .1)),
                  maximumSize: MaterialStateProperty.all(
                      Size(width(context) * .8, width(context) * .12)),
                  backgroundColor:
                      MaterialStateProperty.all(Colors.white), //todo: change
                ),
                onPressed: () {
                  context.read<LoginBloc>().add(GoogleLogin());
                },
                child: Container(
                    padding: EdgeInsets.all(2),
                    child: Row(children: [
                      Container(
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                  "assets/fixAssets/google_light.png"))),
                      Expanded(
                          child: Center(
                              child: Text(strings.google_sign_in,
                                  style: TextStyle(color: Colors.black))))
                    ])),
              )
            ],
          ));
    });
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
