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
import 'package:mobile_app/backend/storage/image_synch.dart';
import 'package:mobile_app/frontend/components/audio/recorder_widget.dart';
import 'package:mobile_app/frontend/components/buttons.dart';
import 'package:mobile_app/frontend/components/keyboard_dismisser.dart';
import 'package:mobile_app/frontend/components/nisaba_app_bar.dart';
import 'package:mobile_app/frontend/components/shadow_box.dart';
import 'package:mobile_app/frontend/dependentsizes.dart';
import 'package:mobile_app/frontend/pages/main_menu_components/main_menu_commonwidgets.dart';
import 'package:mobile_app/frontend/pages/task_form/attachments_list.dart';
import 'package:mobile_app/frontend/pages/task_form/small_button.dart';
import 'package:mobile_app/frontend/theme.dart';

import 'package:mobile_app/frontend/strings.dart' as strings;

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
      _taskDescriptionController.text = task!.text ?? "";
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
  final TextEditingController _taskDescriptionController =
      TextEditingController();
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

  static String formatDate(DateTime deadline) {
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
                  NisabaAppBar(
                      title: task != null
                          ? strings.task_update_title
                          : strings.task_create_title),
                  const SizedBox(
                    height: 19,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: defaultPadding(context)),
                    child: _subtitle(strings.task_dialog_what_task),
                  ),
                  Padding(
                    padding: EdgeInsets.all(defaultPadding(context)),
                    child: ShadowBox(
                      child: TextField(
                        controller: _taskTextController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 2,
                        decoration: InputDecoration(
                            /*border: OutlineInputBorder(
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
                            prefixIcon: const Icon(MdiIcons.pencilOutline),*/
                            labelText: strings.task_dialog_title),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: defaultPadding(context),
                        right: defaultPadding(context),
                        bottom: defaultPadding(context)),
                    child: ShadowBox(
                      child: TextField(
                        controller: _taskDescriptionController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 10,
                        minLines: 4,
                        decoration: InputDecoration(
                            /*border: OutlineInputBorder(
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
                            prefixIcon: const Icon(MdiIcons.pencilOutline),*/
                            labelText: strings.task_dialog_description),
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
                              Expanded(
                                  child: Text(
                                strings.task_dialog_record_audio,
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
                              Expanded(
                                  child: Text(
                                strings.task_dialog_take_foto,
                                overflow: TextOverflow.visible,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ))
                            ],
                          )),
                        ],
                      )),
                  Padding(
                      padding: EdgeInsets.all(defaultPadding(context)),
                      child: _subtitle(strings.task_dialog_entity_choose)),
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
                            decoration: InputDecoration(
                                hintText: strings.task_dialog_entity_search)),
                        emptyBuilder: (context, sss) {
                          return Center(
                            child: Text(
                                strings.task_dialog_entity_search_no_result),
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
                        dropdownSearchDecoration: InputDecoration(
                            hintText: strings.task_dialog_entity_search_hint,
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
                      child: _subtitle(strings.task_dialog_when)),
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
                            text: strings.task_today,
                            selected: state.deadline != null &&
                                areEqualStandardizedDates(
                                    state.deadline!, _now),
                          ),
                          SmallButton(
                            onPressed: () => _cubit!.setDeadline(_tomorrow),
                            iconData: MdiIcons.skipNextOutline,
                            text: strings.task_tomorrow,
                            selected: state.deadline != null &&
                                areEqualStandardizedDates(
                                    state.deadline!, _tomorrow),
                          ),
                          SmallButton(
                            onPressed: () => _cubit!.setDeadline(_nextWeek),
                            iconData: MdiIcons.skipForwardOutline,
                            text: strings.task_next_week,
                            selected: state.deadline != null &&
                                areEqualStandardizedDates(
                                    state.deadline!, _nextWeek),
                          ),
                          SmallButton(
                            onPressed: () => _cubit!.setDeadline(_nextMonth),
                            iconData: MdiIcons.calendarRefreshOutline,
                            text: strings.task_next_month,
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
                      child: Text(strings.task_or)),
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
                                ? strings.task_deadline +
                                    ": " +
                                    formatDate(state.deadline!)
                                : strings.task_set_date,
                            outlinedWhenSelected: true,
                            keepClickable: true,
                            selected: state.deadline != null &&
                                _customDateSelected(state.deadline!),
                          ),
                        ],
                      )),
                  Padding(
                      padding: EdgeInsets.all(defaultPadding(context)),
                      child: defaultGreenButton(
                        context,
                        (state is TaskFormSavingInProgress)
                            ? () {}
                            : () {
                                BlocProvider.of<TaskFormCubit>(context).submit(
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
                                  description: _taskDescriptionController.text,
                                );
                              },
                        minWidth: width(context) * .92,
                        minHeight: width(context) * .12,
                        text: task != null
                            ? strings.task_update_task
                            : strings.task_save_task,
                      ))
                ],
              ),
            ),
          ));
        },
      ),
    );
  }
}
