import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_app/backend/Blocs/user/user_bloc.dart';
import 'package:mobile_app/backend/Blocs/user/user_events.dart';
import 'package:mobile_app/backend/Blocs/user/user_state.dart';
import 'package:mobile_app/backend/callableModels/CallableModels.dart';
import 'package:mobile_app/frontend/buttons.dart';
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
                                  height: width(context) * .45,
                                  decoration: state.userPic != null
                                      ? BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: FileImage(state.userPic!),
                                              fit: BoxFit.fitWidth))
                                      : const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey))),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: CustomIconButton(
                                updatePic,
                                FontAwesomeIcons.camera,
                                Size(
                                    width(context) * .15, width(context) * .15),
                                true,
                                padding: EdgeInsets.all(width(context) * .04)),
                          )
                        ],
                      )))),
          Container(
              margin: EdgeInsets.only(
                  left: width(context) * .1,
                  right: width(context) * .1,
                  top: width(context) * .1),
              child: Text(
                strings.user_create_info,
                style: Theme.of(context).textTheme.bodyText1,
              )),
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
                        controller: textEdigtingControllerFirstName,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(FontAwesomeIcons.user),
                            labelText: strings.user_forename),
                        textInputAction: TextInputAction.next,
                        enableSuggestions: true,
                        validator: (value) => (value ?? "").isNotEmpty
                            ? null
                            : strings.user_please_enter_forename,
                      )),
                      Container(
                          margin: EdgeInsets.only(top: defaultPadding(context)),
                          child: TextFormField(
                            controller: textEditingControllerLastName,
                            decoration: InputDecoration(
                                prefixIcon: const Icon(FontAwesomeIcons.user),
                                labelText: strings.user_surname),
                            textInputAction: TextInputAction.next,
                            enableSuggestions: true,
                            validator: (value) => (value ?? "").isNotEmpty
                                ? null
                                : strings.user_please_enter_surename,
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
                                      minimumSize: MaterialStateProperty.all(
                                          Size(width(context) * .6,
                                              width(context) * .12)),
                                      backgroundColor:
                                          MaterialStateProperty.all(
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
                                    child: Text(strings.user_create_save)))
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
