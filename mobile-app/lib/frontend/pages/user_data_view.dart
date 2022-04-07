import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile_app/backend/Blocs/in_app/in_app_bloc.dart';
import 'package:mobile_app/backend/Blocs/in_app/in_app_events.dart';
import 'package:mobile_app/backend/Blocs/session/session_cubit.dart';
import 'package:mobile_app/backend/Blocs/user/user_bloc.dart';
import 'package:mobile_app/backend/Blocs/user/user_events.dart';
import 'package:mobile_app/backend/Blocs/user/user_state.dart';
import 'package:mobile_app/backend/callableModels/CallableModels.dart';
import 'package:mobile_app/backend/repositories/SettingsRepository.dart';
import 'package:mobile_app/backend/repositories/UserRepository.dart';
import 'package:mobile_app/backend/storage/image_synch.dart';
import 'package:mobile_app/frontend/common_widgets.dart';

import 'package:mobile_app/frontend/components/buttons.dart';

import 'package:mobile_app/frontend/strings.dart' as strings;
import 'package:mobile_app/services/photo_capturing.dart';

import '../dependentsizes.dart';

class UserDataView extends StatefulWidget {
  UserDataView({Key? key, required this.userBloc, this.inApp = false})
      : super(key: key);
  UserBloc userBloc;
  bool inApp;

  @override
  State<StatefulWidget> createState() {
    return UserDataViewState();
  }
}

class UserDataViewState extends State<UserDataView> {
  late TextEditingController textEdigtingControllerFirstName;
  late TextEditingController textEditingControllerLastName;
  late String currentLocale;
  final _formKey = GlobalKey<FormState>();
  SyncedFile? userPicSynced;
  File? _userPicFile;

  File? get userPicFile => _userPicFile;

  set userPicFile(File? file) {
    _userPicFile = file;
    userPicKey = ValueKey(DateTime.now());
  }

  @override
  void initState() {
    textEdigtingControllerFirstName = TextEditingController();
    textEditingControllerLastName = TextEditingController();
    currentLocale = strings.currentLanguage;
    if (widget.userBloc.state.user != null) {
      textEdigtingControllerFirstName.text =
          widget.userBloc.state.user!.firstName;
      textEditingControllerLastName.text = widget.userBloc.state.user!.lastName;
      userPicSynced =
          UserRepository.getUserPicFile(widget.userBloc.state.user!);
      userPicSynced!.file().then((value) {
        try {
          setState(() {
            userPicFile = value;
          });
        } catch (e) {
          userPicFile = value;
        }
      });
    } else {
      userPicSynced =
          UserRepository.getUserPicFileByUserID(widget.userBloc.userID);
      userPicSynced!.file().then((value) {
        try {
          setState(() {
            userPicFile = value;
          });
        } catch (e) {
          userPicFile = value;
        }
      });
    }

    super.initState();
  }

  Key userPicKey = ValueKey(DateTime.now());

  void updatePic() async {
    XFile? r = await CameraFunctionality.takePicture(context: context);
    if (r != null) {
      await userPicSynced?.updateAsPic(r);
      userPicFile = await userPicSynced?.file();

      setState(() {
        userPicFile = userPicFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if (widget.inApp) {
            context.read<InAppBloc>().add(MainViewEvent());
          }
          return false;
        },
        child: Scaffold(
            appBar: widget.inApp
                ? PreferredSize(
                    preferredSize: Size(width(context), height(context) * .12),
                    child: Container(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).padding.top),
                        width: width(context),
                        color: Theme.of(context).colorScheme.background,
                        child:
                            Column(mainAxisSize: MainAxisSize.min, children: [
                          Flexible(
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.symmetric(
                                          vertical: defaultPadding(context)),
                                      child:
                                          CommonWidgets.defaultBackwardButton(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      defaultPadding(context)),
                                              context: context,
                                              goBack: () => context
                                                  .read<InAppBloc>()
                                                  .add(MainViewEvent()))),
                                  Expanded(
                                    child: Container(
                                        margin: EdgeInsets.only(
                                            left: defaultPadding(context)),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                                child: Container(
                                                    child:
                                                        Text(strings.profile))),
                                            Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: defaultPadding(
                                                        context)),
                                                child: CommonWidgets
                                                    .defaultIconButton(
                                                        onPressed: () async {
                                                          context
                                                              .read<
                                                                  SessionCubit>()
                                                              .signOut();
                                                        },
                                                        context: context,
                                                        iconData:
                                                            MdiIcons.logout,
                                                        buttonSizes:
                                                            ButtonSizes.small,
                                                        fillColor:
                                                            Theme.of(context)
                                                                .colorScheme
                                                                .error)),
                                          ],
                                        )),
                                  )
                                ]),
                          ),
                          Container(
                              width: width(context),
                              height: 1,
                              color: Colors.grey)
                        ])))
                : null,
            body: SafeArea(child: BlocBuilder<UserBloc, UserState>(
                builder: (buildContext, state) {
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
                                          decoration: userPicFile != null
                                              ? BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                      image: FileImage(
                                                          userPicFile!),
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
                                        Size(width(context) * .15,
                                            width(context) * .15),
                                        true,
                                        padding: EdgeInsets.all(
                                            width(context) * .04)),
                                  )
                                ],
                              )))),
                  if (!widget.inApp)
                    Container(
                        margin: EdgeInsets.only(
                            left: width(context) * .1,
                            right: width(context) * .1,
                            top: width(context) * .1),
                        child: Text(
                          strings.user_create_info,
                          style: Theme.of(context).textTheme.bodyText1,
                        ))
                  else
                    Container(height: height(context) * .1),
                  Container(
                    margin: EdgeInsets.all(width(context) * .1),
                    child: Form(
                      key: _formKey,
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
                              margin:
                                  EdgeInsets.only(top: defaultPadding(context)),
                              child: TextFormField(
                                controller: textEditingControllerLastName,
                                decoration: InputDecoration(
                                    prefixIcon:
                                        const Icon(FontAwesomeIcons.user),
                                    labelText: strings.user_surname),
                                textInputAction: TextInputAction.next,
                                enableSuggestions: true,
                                validator: (value) => (value ?? "").isNotEmpty
                                    ? null
                                    : strings.user_please_enter_surename,
                              )),
                          Container(
                              margin:
                                  EdgeInsets.only(top: defaultPadding(context)),
                              child: _localeChoice(context)),
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
                                                      BorderRadius.circular(
                                                          8))),
                                          minimumSize:
                                              MaterialStateProperty.all(Size(
                                                  width(context) * .8,
                                                  width(context) * .12)),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.green), //todo: change
                                        ),
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            RepositoryProvider.of<
                                                    SettingsRepository>(context)
                                                .locale = currentLocale;

                                            if (widget.inApp) {
                                              User user = context
                                                  .read<UserBloc>()
                                                  .state
                                                  .user!;
                                              user.firstName =
                                                  textEdigtingControllerFirstName
                                                      .text
                                                      .trim();
                                              user.lastName =
                                                  textEditingControllerLastName
                                                      .text
                                                      .trim();
                                              context
                                                  .read<UserBloc>()
                                                  .add(UpdateUserEvent(user));
                                              context
                                                  .read<InAppBloc>()
                                                  .add(MainViewEvent());
                                            } else {
                                              context.read<UserBloc>().add(
                                                  CreateUserEvent(User(
                                                      firstName:
                                                          textEdigtingControllerFirstName
                                                              .text,
                                                      lastName:
                                                          textEditingControllerLastName
                                                              .text,
                                                      id: widget
                                                          .userBloc.userID,
                                                      permissions: [])));
                                            }
                                          }
                                        },
                                        child: Text(widget.inApp
                                            ? strings.user_update
                                            : strings.user_create_save)))
                              ])
                        ],
                      ),
                    ),
                  )
                ],
              );
            }))));
  }

  Widget _localeChoice(BuildContext context) {
    var options = strings.availableLocals.keys
        .map(
          (e) => DropdownMenuItem<String>(
            child: Text(strings.availableLocals[e]!),
            value: e,
          ),
        )
        .toList();

    return DropdownButtonFormField<String>(
      items: options,
      value: currentLocale,
      onChanged: (value) {
        currentLocale = value!;
        if (mounted) setState(() {});
      },
    );
  }
}
