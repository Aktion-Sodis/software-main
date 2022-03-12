import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_app/backend/Blocs/user/user_bloc.dart';
import 'package:mobile_app/backend/Blocs/user/user_events.dart';
import 'package:mobile_app/backend/Blocs/user/user_state.dart';
import 'package:mobile_app/backend/callableModels/CallableModels.dart';
import 'package:mobile_app/frontend/strings.dart' as strings;

import '../dependentsizes.dart';

class UserDataView extends StatefulWidget {
  UserDataView({Key? key, required this.userBloc}) : super(key: key);
  UserBloc userBloc;

  @override
  State<StatefulWidget> createState() {
    return UserDataViewState();
  }
}

class UserDataViewState extends State<UserDataView> {
  late TextEditingController textEdigtingControllerFirstName;
  late TextEditingController textEditingControllerLastName;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    textEdigtingControllerFirstName = TextEditingController();
    textEditingControllerLastName = TextEditingController();
    if (widget.userBloc.state.user != null) {
      textEdigtingControllerFirstName.text =
          widget.userBloc.state.user!.firstName;
      textEditingControllerLastName.text = widget.userBloc.state.user!.lastName;
    }
    super.initState();
  }

  void updatePic() async {
    //todo: implement
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<UserBloc, UserState>(builder: (buildContext, state) {
      return Column(
        children: [
          Expanded(
              child: Center(
                  child: Container(
                      width: width(context) * .5,
                      height: width(context) * .5,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Align(
                              alignment: Alignment.center,
                              child: Container(
                                  width: width(context) * .45,
                                  height: height(context) * .45,
                                  decoration: state.userPic != null
                                      ? BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: FileImage(state.userPic!),
                                              fit: BoxFit.fitWidth))
                                      : const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey))),
                          Align(
                            alignment: Alignment.centerRight,
                            child: MaterialButton(
                                onPressed: updatePic,
                                child: Container(
                                  alignment: Alignment.center,
                                  width: width(context) * .1,
                                  height: width(context) * .1,
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      color: Colors.white),
                                  child: Icon(FontAwesomeIcons.camera,
                                      color: Colors.grey,
                                      size: width(context) * .07),
                                )),
                          )
                        ],
                      )))),
          Container(
              margin: EdgeInsets.all(width(context) * .1),
              child: Form(
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
                      Container(
                          child: TextFormField(
                        decoration: InputDecoration(
                            prefixIcon: const Icon(FontAwesomeIcons.user),
                            hintText: "Forname",
                            labelText:
                                textEdigtingControllerFirstName.text.isEmpty
                                    ? ""
                                    : "Forname"),
                        textInputAction: TextInputAction.next,
                        enableSuggestions: true,
                        validator: (value) =>
                            (value ?? "").isNotEmpty ? null : "Please enter",
                      )),
                      Container(
                          margin: EdgeInsets.only(top: defaultPadding(context)),
                          child: TextFormField(
                            decoration: InputDecoration(
                                prefixIcon: const Icon(FontAwesomeIcons.user),
                                hintText: "Surname",
                                labelText:
                                    textEdigtingControllerFirstName.text.isEmpty
                                        ? ""
                                        : "Surname"),
                            textInputAction: TextInputAction.next,
                            enableSuggestions: true,
                            validator: (value) => (value ?? "").isNotEmpty
                                ? null
                                : "Please enter",
                          )),
                      Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                margin: EdgeInsets.only(
                                    top: defaultPadding(context)),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    textStyle: MaterialStateProperty.all(
                                        TextStyle(fontSize: 18)),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8))),
                                    minimumSize: MaterialStateProperty.all(Size(
                                        width(context) * .6,
                                        width(context) * .12)),
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.green), //todo: change
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      context.read<UserBloc>().add(
                                          CreateUserEvent(User(
                                              firstName:
                                                  textEdigtingControllerFirstName
                                                      .text,
                                              lastName:
                                                  textEditingControllerLastName
                                                      .text,
                                              id: widget.userBloc.userID,
                                              permissions: [])));
                                    }
                                  },
                                  child: Text(strings.login),
                                ))
                          ])
                    ],
                  ),
                ),
              ))
        ],
      );
    }));
  }
}
