import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile_app/backend/Blocs/task_form/task_form_cubit.dart';
import 'package:mobile_app/backend/callableModels/localModels/audio_attachment.dart';
import 'package:mobile_app/frontend/components/audio/recorder_widget.dart';
import 'package:mobile_app/frontend/components/keyboard_dismisser.dart';
import 'package:mobile_app/frontend/components/nisaba_app_bar.dart';
import 'package:mobile_app/frontend/components/shadow_box.dart';
import 'package:mobile_app/frontend/dependentsizes.dart';
import 'package:mobile_app/frontend/pages/task_category_search.dart';
import 'package:mobile_app/frontend/pages/task_form/attachments_list.dart';
import 'package:mobile_app/frontend/pages/task_form/small_button.dart';
import 'package:mobile_app/frontend/theme.dart';

class TaskForm<T extends TaskFormCubit> extends StatelessWidget {
  TaskForm({Key? key, required this.title}) : super(key: key);

  final String title;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _taskTextController = TextEditingController();
  final TextEditingController _searchTextController = TextEditingController();

  TaskFormCubit _cubit = TaskFormCubit.initialize<T>();

  Widget _subtitle(String text) => Text(
        text,
        style: const TextStyle(fontSize: 22),
      );

  Widget _iconButton(IconData iconData, Function() onPressed) {
    BorderRadius borderRadius = BorderRadius.circular(15);
    return Container(
      height: 60,
      width: 60,
      decoration:
          BoxDecoration(boxShadow: [defaultShadow], borderRadius: borderRadius),
      child: Material(
        borderRadius: borderRadius,
        child: InkWell(
          onTap: onPressed,
          borderRadius: borderRadius,
          child: Icon(
            iconData,
            size: 33,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TaskFormCubit>(
      create: (context) => TaskFormCubit.initialize<T>(),
      child: BlocBuilder<TaskFormCubit, TaskFormState>(
        builder: (context, state) {
          _cubit = BlocProvider.of<TaskFormCubit>(context);

          return KeyboardDismisser(
              child: Material(
            child: Scrollbar(
              controller: _scrollController,
              child: ListView(
                padding: MediaQuery.of(context).padding,
                controller: _scrollController,
                children: [
                  NisabaAppBar(title: title),
                  const SizedBox(
                    height: 19,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: defaultPadding(context)),
                    child: _subtitle("What is the task?"),
                  ),
                  Padding(
                    padding: EdgeInsets.all(defaultPadding(context)),
                    child: ShadowBox(
                      child: TextField(
                        controller: _taskTextController,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.transparent, width: 0),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.transparent, width: 0),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.transparent, width: 0),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: ThemeColors.green, width: 2),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            prefixIcon: const Icon(MdiIcons.pencilOutline),
                            hintText: "Write down your task"),
                      ),
                    ),
                  ),
                  state.attachments.isNotEmpty
                      ? const AttachmentsList()
                      : const SizedBox.shrink(),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: defaultPadding(context)),
                      child: Row(
                        children: [
                          Expanded(
                              child: Row(
                            children: [
                              RecorderWidget(
                                  restingViewBuilder: (startPlaying) {
                                return _iconButton(
                                    MdiIcons.microphoneOutline, startPlaying);
                              }, recordingViewBuilder: (stopPlaying) {
                                return _iconButton(
                                    MdiIcons.stopCircleOutline, stopPlaying);
                              }, onAudioRecorded: (uri) {
                                _cubit.addAttachment(AudioAttachment(uri));
                              }, loadingViewBuilder: () {
                                return _iconButton(MdiIcons.microphoneOutline,
                                    () {
                                  // TODO: add explaining toast, that widget is not ready yet
                                  debugPrint(
                                      "Recorder widget is not ready yet");
                                });
                              }),
                              SizedBox(
                                width: defaultPadding(context),
                              ),
                              const Expanded(
                                  child: Text(
                                "Record an audio",
                                overflow: TextOverflow.visible,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ))
                            ],
                          )),
                          Expanded(
                              child: Row(
                            children: [
                              _iconButton(MdiIcons.cameraOutline, () {}),
                              SizedBox(
                                width: defaultPadding(context),
                              ),
                              const Expanded(
                                  child: Text(
                                "Take a photo",
                                overflow: TextOverflow.visible,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ))
                            ],
                          )),
                        ],
                      )),
                  Padding(
                      padding: EdgeInsets.all(defaultPadding(context)),
                      child: _subtitle("Where is the task?")),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: defaultPadding(context)),
                      child: Row(
                        children: [
                          Expanded(
                            child: ShadowBox(
                                child: TextField(
                              controller: _searchTextController,
                              decoration: const InputDecoration(
                                  hintText: "Search here"),
                            )),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: defaultPadding(context)),
                            child: _iconButton(
                              MdiIcons.magnify,
                              () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            TaskCategorySearch(
                                                textEditingController:
                                                    _searchTextController)));
                              },
                            ),
                          )
                        ],
                      )),
                  Padding(
                      padding: EdgeInsets.all(defaultPadding(context)),
                      child: _subtitle("When will you do it?")),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: defaultPadding(context)),
                      child: Wrap(
                        spacing: 20,
                        runSpacing: 7,
                        children: [
                          SmallButton(
                              onPressed: () {},
                              iconData: MdiIcons.circleMedium,
                              text: "Today",
                              selected: true,
                              color: ThemeColors.red),
                          SmallButton(
                              onPressed: () {},
                              iconData: MdiIcons.skipNextOutline,
                              text: "Tomorrow",
                              textColor: ThemeColors.black,
                              color: ThemeColors.yellow),
                          SmallButton(
                              onPressed: () {},
                              iconData: MdiIcons.skipForwardOutline,
                              text: "Next week",
                              color: ThemeColors.darkGrey),
                          SmallButton(
                              onPressed: () {},
                              iconData: MdiIcons.calendarRefreshOutline,
                              text: "Next month",
                              color: ThemeColors.mobster),
                        ],
                      )),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: defaultPadding(context),
                          horizontal: 2.0 * defaultPadding(context)),
                      child: const Text("or")),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: defaultPadding(context)),
                      child: Wrap(
                        children: [
                          SmallButton(
                              onPressed: () {},
                              iconData: MdiIcons.calendarOutline,
                              text: "Set a date",
                              isOutlined: true,
                              textColor: ThemeColors.black,
                              color: ThemeColors.black),
                        ],
                      )),
                  Padding(
                      padding: EdgeInsets.all(defaultPadding(context)),
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(ThemeColors.green),
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.all(18)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ))),
                          onPressed: () {},
                          child: const Text("Save task")))
                ],
              ),
            ),
          ));
        },
      ),
    );
  }
}
