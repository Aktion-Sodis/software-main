import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile_app/backend/Blocs/organization_view/organization_view_bloc.dart';
import 'package:mobile_app/backend/Blocs/task/task_bloc.dart';
import 'package:mobile_app/backend/Blocs/task_form/task_form_cubit.dart';
import 'package:mobile_app/backend/Blocs/user/user_bloc.dart';
import 'package:mobile_app/backend/callableModels/CallableModels.dart';
import 'package:mobile_app/backend/callableModels/localModels/attachment.dart';
import 'package:mobile_app/backend/callableModels/localModels/audio_attachment.dart';
import 'package:mobile_app/frontend/components/audio/recorder_widget.dart';
import 'package:mobile_app/frontend/components/keyboard_dismisser.dart';
import 'package:mobile_app/frontend/components/nisaba_app_bar.dart';
import 'package:mobile_app/frontend/components/shadow_box.dart';
import 'package:mobile_app/frontend/dependentsizes.dart';
import 'package:mobile_app/frontend/pages/main_menu_components/main_menu_commonwidgets.dart';
import 'package:mobile_app/frontend/pages/task_form/attachments_list.dart';
import 'package:mobile_app/frontend/pages/task_form/small_button.dart';
import 'package:mobile_app/frontend/theme.dart';

@immutable
class TaskForm<T extends TaskFormCubit> extends StatelessWidget {
  TaskForm(
      {Key? key,
      required this.title,
      this.task,
      this.entity,
      this.appliedIntervention,
      this.executedSurvey,
      required this.taskBloc,
      required this.organizationViewBloc,
      required this.userBloc,
      this.attachments})
      : super(key: key) {
    if (task != null) {
      _taskTextController.text = task!.title;
    }
  }

  final Task? task;
  final Entity? entity;
  final AppliedIntervention? appliedIntervention;
  final ExecutedSurvey? executedSurvey;
  final TaskBloc taskBloc;
  final OrganizationViewBloc organizationViewBloc;
  final UserBloc userBloc;
  final List<Attachment>? attachments;

  final String title;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _taskTextController = TextEditingController();
  final TextEditingController _searchTextController = TextEditingController();

  // Methods for handling dates
  DateTime get _now => DateTime.now();
  DateTime get _tomorrow => _now.add(Duration(days: 1));
  DateTime get _nextWeek => _now.add(Duration(days: 7));
  DateTime get _nextMonth => _now.add(Duration(days: 30));

  bool _customDateSelected(DateTime date) {
    return !areEqualStandardizedDates(date, _now) &&
        !areEqualStandardizedDates(date, _tomorrow) &&
        !areEqualStandardizedDates(date, _nextWeek) &&
        !areEqualStandardizedDates(date, _nextMonth);
  }

  bool areEqualStandardizedDates(DateTime date1, DateTime date2) {
    return standardizeDate(date1).isAtSameMomentAs(standardizeDate(date2));
  }

  DateTime standardizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  String _formatDate(DateTime deadline) {
    return deadline.day.toString() +
        "." +
        deadline.month.toString() +
        "." +
        deadline.year.toString();
  }

  // Subwidgets
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

  TaskFormCubit? _cubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TaskFormCubit>(
      create: (context) => TaskFormCubit.initialize<T>(
          task: task,
          entity: entity,
          appliedIntervention: appliedIntervention,
          executedSurvey: executedSurvey,
          taskBloc: taskBloc,
          organizationViewBloc: organizationViewBloc,
          userBloc: userBloc,
          attachments: attachments),
      child: BlocConsumer<TaskFormCubit, TaskFormState>(
        listener: (context, state) {
          if (state is TaskFormSuccessfullSubmitted) {
            Navigator.pop(context, state.task);
          }
        },
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
                                _cubit!.addAttachment(AudioAttachment(uri));
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
                          SizedBox(
                            width: defaultPadding(context),
                          ),
                          Expanded(
                              child: Row(
                            children: [
                              _iconButton(MdiIcons.cameraOutline,
                                  () => _cubit!.takePhoto(context)),
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
                    child: ShadowBox(
                      child: DropdownSearch<Entity>(
                        selectedItem: _cubit!.state.entity,
                        searchDelay: const Duration(seconds: 0),
                        onFind: _cubit!.searchForEntities,
                        mode: Mode.MENU,
                        itemAsString: (entity) => entity!.name,
                        isFilteredOnline: true,
                        showSearchBox: true,
                        compareFn: (e1, e2) {
                          return e1?.id! == e2?.id!;
                        },
                        searchFieldProps: TextFieldProps(
                            decoration:
                                const InputDecoration(hintText: "Search here")),
                        emptyBuilder: (context, sss) {
                          return const Center(
                            child: Text("No entities have been found"),
                          );
                        },
                        loadingBuilder: (context, searchEntry) {
                          return const Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        },
                        dropDownButton: const Icon(
                          MdiIcons.accountSearch,
                        ),
                        /*dropdownBuilder: (context, entity) {
                          return entityRow(context, entity!);
                        },*/
                        showClearButton: true,
                        items: [],
                        dropdownSearchDecoration: const InputDecoration(
                            hintText: "Add entity",
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8)),
                        onChanged: (e) {
                          if (e != null) {
                            _cubit!.updateEntity(e);
                          } else {
                            _cubit!.clearEntity();
                          }
                        },
                      ),
                    ),
                  ),
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
                            onPressed: () => _cubit!.setDeadline(_now),
                            iconData: MdiIcons.circleMedium,
                            text: "Today",
                            selected: state.deadline != null &&
                                areEqualStandardizedDates(
                                    state.deadline!, _now),
                          ),
                          SmallButton(
                            onPressed: () => _cubit!.setDeadline(_tomorrow),
                            iconData: MdiIcons.skipNextOutline,
                            text: "Tomorrow",
                            selected: state.deadline != null &&
                                areEqualStandardizedDates(
                                    state.deadline!, _tomorrow),
                          ),
                          SmallButton(
                            onPressed: () => _cubit!.setDeadline(_nextWeek),
                            iconData: MdiIcons.skipForwardOutline,
                            text: "Next week",
                            selected: state.deadline != null &&
                                areEqualStandardizedDates(
                                    state.deadline!, _nextWeek),
                          ),
                          SmallButton(
                            onPressed: () => _cubit!.setDeadline(_nextMonth),
                            iconData: MdiIcons.calendarRefreshOutline,
                            text: "Next month",
                            selected: state.deadline != null &&
                                areEqualStandardizedDates(
                                    state.deadline!, _nextMonth),
                          ),
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
                            onPressed: () =>
                                _cubit!.openCalendarToSetDeadline(context),
                            iconData: MdiIcons.calendarOutline,
                            text: state.deadline != null &&
                                    _customDateSelected(state.deadline!)
                                ? "Deadline: " + _formatDate(state.deadline!)
                                : "Set a date",
                            outlinedWhenSelected: true,
                            keepClickable: true,
                            selected: state.deadline != null &&
                                _customDateSelected(state.deadline!),
                          ),
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
                          onPressed: (state is TaskFormSavingInProgress)
                              ? null
                              : () {
                                  BlocProvider.of<TaskFormCubit>(context)
                                      .submit(
                                    attachments: state.attachments,
                                    entity: state.entity,
                                    deadline: state.deadline,
                                    task: state.task,
                                    appliedIntervention:
                                        state.appliedIntervention,
                                    executedSurvey: state.executedSurvey,
                                    taskBloc: state.taskBloc,
                                    organizationViewBloc:
                                        state.organizationViewBloc,
                                    userBloc: state.userBloc,
                                    text: _taskTextController.text,
                                  );
                                },
                          child: (state is TaskFormSavingInProgress)
                              ? const SizedBox(
                                  width: 17,
                                  height: 17,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : const Text("Save task")))
                ],
              ),
            ),
          ));
        },
      ),
    );
  }
}
