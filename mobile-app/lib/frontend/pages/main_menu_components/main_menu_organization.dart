import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile_app/backend/Blocs/inapp/inapp_bloc.dart';
import 'package:mobile_app/backend/Blocs/organization_view/organization_view_bloc.dart';
import 'package:mobile_app/backend/Blocs/organization_view/organization_view_events.dart';
import 'package:mobile_app/backend/Blocs/organization_view/organization_view_state.dart';
import 'package:mobile_app/backend/Blocs/task/task_bloc.dart';
import 'package:mobile_app/backend/Blocs/task/task_state.dart';
import 'package:mobile_app/backend/callableModels/CallableModels.dart';
import 'package:mobile_app/backend/repositories/AppliedInterventionRepository.dart';
import 'package:mobile_app/backend/repositories/EntityRepository.dart';
import 'package:mobile_app/backend/repositories/InterventionRepository.dart';
import 'package:mobile_app/backend/repositories/SurveyRepository.dart';
import 'package:mobile_app/frontend/components/buttons.dart';
import 'package:mobile_app/frontend/components/imageWidget.dart';
import 'package:mobile_app/frontend/components/loadingsign.dart';
import 'package:mobile_app/frontend/dependentsizes.dart';
import 'package:mobile_app/frontend/pages/main_menu_components/main_menu_commonwidgets.dart';
import 'package:mobile_app/frontend/strings.dart' as strings;
import 'package:mobile_app/frontend/common_widgets.dart';

class MainMenuOrganization extends StatelessWidget {
  Widget appBarWidget(BuildContext context,
      EntitiesLoadedOrganizationViewState organizationViewState) {
    return Container(
        height: height(context) * .1,
        width: width(context),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          if (!(organizationViewState.organizationViewType ==
                  OrganizationViewType.LIST &&
              organizationViewState.currentListEntities.first.level.id ==
                  organizationViewState.getLevelsInOrder().first.id))
            Container(
                margin: EdgeInsets.symmetric(vertical: defaultPadding(context)),
                child: CommonWidgets.defaultBackwardButton(
                    context: context,
                    goBack: () => context
                        .read<OrganizationViewBloc>()
                        .add(BackTapEvent()))),
          Expanded(
            child: Container(
                margin: EdgeInsets.only(
                    left: (organizationViewState.organizationViewType ==
                                OrganizationViewType.LIST &&
                            organizationViewState
                                    .currentListEntities.first.level.id ==
                                organizationViewState
                                    .getLevelsInOrder()
                                    .first
                                    .id)
                        ? defaultPadding(context)
                        : 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Container(
                            child: Text(organizationViewState.appBarString,
                                style: Theme.of(context).textTheme.headline2))),
                    if (organizationViewState.organizationViewType ==
                            OrganizationViewType.LIST &&
                        organizationViewState.addEntityPossible)
                      Container(
                          margin: EdgeInsets.symmetric(
                              vertical: defaultPadding(context)),
                          child: CommonWidgets.defaultIconButton(
                              onPressed: () async {
                                Entity? toAdd = await showEntityDialog(
                                    context,
                                    null,
                                    organizationViewState
                                        .currentListEntities.first.level,
                                    organizationViewState.currentListEntities
                                        .first.parentEntityID);
                                if (toAdd != null) {
                                  context
                                      .read<OrganizationViewBloc>()
                                      .add(AddEntity(toAdd));
                                }
                              },
                              context: context,
                              iconData: MdiIcons.plus,
                              buttonSizes: ButtonSizes.small,
                              fillColor:
                                  Theme.of(context).colorScheme.secondary)),
                  ],
                )),
          )
        ]));
  }

  Widget mainWidget(BuildContext context,
      EntitiesLoadedOrganizationViewState organizationViewState) {
    Widget actualWidget() {
      switch (organizationViewState.organizationViewType) {
        case OrganizationViewType.LIST:
          return Container(
              child: ListWidget(
                  key:
                      ValueKey(organizationViewState.currentListEntities.first),
                  entities: organizationViewState.currentListEntities,
                  onInfoTapped: (entity) => context
                      .read<OrganizationViewBloc>()
                      .add(NavigateToEntityInfo(entity)),
                  onChildTapped: (entity) => context
                      .read<OrganizationViewBloc>()
                      .add(NavigateToDaughterView(entity.id!)),
                  organizatiOnViewState: organizationViewState,
                  parentEntityName: organizationViewState
                              .currentListEntities.first.parentEntityID !=
                          null
                      ? organizationViewState
                          .entityByID(organizationViewState
                              .currentListEntities.first.parentEntityID!)
                          .name
                      : ""));
          break;
        case OrganizationViewType.OVERVIEW:
          return OverviewWidget(
              entity: organizationViewState.currentDetailEntity!,
              onTasksTapped: (entity) {
                context
                    .read<OrganizationViewBloc>()
                    .add(NavigateToEntityTasks(entity));
              },
              onSurveysTapped: (entity) {
                context
                    .read<OrganizationViewBloc>()
                    .add(NavigateToEntitySurveys(entity));
              },
              onAppliedInterventionsTapped: (entity) {
                context
                    .read<OrganizationViewBloc>()
                    .add(NavigateToEntityAppliedInterventions(entity));
              },
              onUpdateEntityTapped: (entity) {
                showEntityDialog(
                        context, entity, entity.level, entity.parentEntityID)
                    .then((value) {
                  if (value != null) {
                    context
                        .read<OrganizationViewBloc>()
                        .add(UpdateEntity(value));
                  }
                });
              });
        default:
          return Container();
          break;
      }
    }

    return AnimatedSwitcher(
        duration: Duration(milliseconds: 200), child: actualWidget());
  }

  Widget levelIndicatorWidget(BuildContext context,
      EntitiesLoadedOrganizationViewState organizationViewState) {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<EntityRepository>(
              create: (context) => EntityRepository()),
          RepositoryProvider<SurveyRepository>(
              create: (context) => SurveyRepository()),
          RepositoryProvider<EntityRepository>(
              create: (context) => EntityRepository()),
          RepositoryProvider<AppliedInterventionRepository>(
              create: (context) => AppliedInterventionRepository())
        ],
        child: Builder(
            builder: (context) => BlocProvider<OrganizationViewBloc>(
                  create: (context) => OrganizationViewBloc(
                      context.read<EntityRepository>(),
                      context.read<AppliedInterventionRepository>(),
                      context.read<InAppBloc>()),
                  child:
                      BlocBuilder<OrganizationViewBloc, OrganizationViewState>(
                          builder: (context, state) {
                    if (state is LoadingOrganizationViewState) {
                      return Center(child: loadingSign(context));
                    } else {
                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          appBarWidget(context,
                              state as EntitiesLoadedOrganizationViewState),
                          levelIndicatorWidget(context, state),
                          Expanded(child: mainWidget(context, state))
                        ],
                      );
                    }
                  }),
                )));
  }
}

Future<Entity?> showEntityDialog(BuildContext buildContext, Entity? entity,
    Level level, String? parentEntityID) async {
  return showDialog(
      context: buildContext,
      builder: (context) {
        return EntityDialogWidget(entity, level, parentEntityID);
      });
}

class EntityDialogWidget extends StatefulWidget {
  Entity? entity;
  Level level;
  String? parentEntityID;
  EntityDialogWidget(this.entity, this.level, this.parentEntityID);

  @override
  State<StatefulWidget> createState() {
    return EntityDialogWidgetState();
  }
}

class EntityDialogWidgetState extends State<EntityDialogWidget> {
  final _formKey = GlobalKey<FormState>();

  bool create = true;
  Entity? entity;
  late TextEditingController nameEditingController;
  late TextEditingController descriptionEditingController;
  late List<TextEditingController> customDataControllers;

  File? imageFile;

  Widget customDataField(int index) {
    return Container(
        margin: EdgeInsets.only(
            top: defaultPadding(context),
            left: defaultPadding(context),
            right: defaultPadding(context)),
        child: TextFormField(
          controller: customDataControllers[index],
          decoration: InputDecoration(
              prefixIcon: const Icon(MdiIcons.pen),
              labelText: widget.level.customData[index].name),
          textInputAction: TextInputAction.next,
          keyboardType:
              widget.level.customData[index].type == CustomDataType.INT
                  ? TextInputType.number
                  : null,
          enableSuggestions: true,
          validator: (value) => null,
        ));
  }

  @override
  void initState() {
    nameEditingController = TextEditingController();
    descriptionEditingController = TextEditingController();
    customDataControllers = [];
    widget.level.customData.forEach((element) {
      customDataControllers.add(TextEditingController());
    });
    if (widget.entity != null) {
      create = false;
      entity = widget.entity;
      nameEditingController.text = entity!.name;
      descriptionEditingController.text = entity!.description;
      entity!.customData.forEach((cd) {
        int index = widget.level.customData
            .indexWhere((element) => element.id == cd.customDataID);
        customDataControllers[index].text = cd.type == CustomDataType.INT
            ? (cd.intValue.toString())
            : (cd.stringValue ?? "");
      });
    }
    super.initState();
  }

  void save() async {
    if (_formKey.currentState!.validate()) {
      List<AppliedCustomData> appliedCustomDatas =
          List.generate(widget.level.customData.length, (index) {
        CustomData customData = widget.level.customData[index];
        return AppliedCustomData(
          customDataID: customData.id!,
          type: customData.type,
          name: customData.name,
          intValue: customData.type == CustomDataType.INT
              ? int.fromEnvironment(customDataControllers[index].text)
              : null,
          stringValue: customData.type == CustomDataType.STRING
              ? customDataControllers[index].text.trim()
              : null,
        );
      });

      if (create) {
        Entity toSave = Entity(
            name_ml: I18nString.fromString(string: nameEditingController.text),
            description_ml: I18nString.fromString(
                string: descriptionEditingController.text),
            level: widget.level,
            customData: appliedCustomDatas,
            appliedInterventions: [],
            parentEntityID: widget.parentEntityID);
        Navigator.of(context).pop(toSave);
      } else {
        I18nString nameToSet = widget.entity!.name_ml;
        nameToSet.text = nameEditingController.text;
        I18nString description = widget.entity!.name_ml;
        description.text = descriptionEditingController.text;
        Entity toSave = widget.entity!;
        toSave.name_ml = nameToSet;
        toSave.description_ml = description;
        toSave.customData = appliedCustomDatas;
        Navigator.of(context).pop(toSave);
      }
    }
  }

  void updatePic() async {
    //todo: implement
  }

  String getpicPath() {
    //todo: implement
    return "";
  }

  List<Widget> columnChildren() {
    List<Widget> toReturn = [
      Container(
          margin: EdgeInsets.all(defaultPadding(context)),
          height: height(context) * .2,
          width: width(context) * .92,
          child: Stack(
            fit: StackFit.expand,
            children: [
              ImageWidget(
                  path: getpicPath(),
                  imageFile: imageFile,
                  width: width(context) * .92,
                  height: height(context) * .2,
                  borderRadius: BorderRadius.circular(8)),
              Positioned(
                  right: defaultPadding(context),
                  bottom: defaultPadding(context),
                  child: CustomIconButton(updatePic, MdiIcons.camera,
                      Size(width(context) * .1, width(context) * .1), true))
            ],
          )),
      Container(
          margin: EdgeInsets.only(
              left: defaultPadding(context), right: defaultPadding(context)),
          child: TextFormField(
            controller: nameEditingController,
            decoration: InputDecoration(
                prefixIcon: const Icon(FontAwesomeIcons.user),
                labelText: strings.organization_view_entity_name),
            textInputAction: TextInputAction.next,
            enableSuggestions: true,
            validator: (value) => (value ?? "").isEmpty
                ? strings.organization_view_entity_enter_name
                : null,
          )),
      Container(
          margin: EdgeInsets.only(
              top: defaultPadding(context),
              left: defaultPadding(context),
              right: defaultPadding(context)),
          child: TextFormField(
            controller: descriptionEditingController,
            decoration: InputDecoration(
                prefixIcon: const Icon(MdiIcons.pen),
                labelText: strings.organization_view_entity_description),
            textInputAction: TextInputAction.next,
            enableSuggestions: true,
            validator: (value) => (value ?? "").isEmpty
                ? strings.organization_view_entity_enter_description
                : null,
          ))
    ];
    toReturn.addAll(List.generate(
        widget.level.customData.length, (index) => customDataField(index)));
    return toReturn;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: false,
        top: false,
        child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            body: Container(
              child: Column(
                children: [
                  Container(
                      height: height(context) * .1,
                      width: width(context),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: defaultPadding(context)),
                                child: CommonWidgets.defaultBackwardButton(
                                    context: context,
                                    goBack: () => Navigator.of(context).pop())),
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                              strings
                                                  .organization_view_dialog_add_entity,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline2))),
                                ],
                              ),
                            )
                          ])),
                  Expanded(
                      child: Form(
                          key: _formKey,
                          child: Container(
                              child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: columnChildren(),
                            ),
                          )))),
                  Container(
                      margin: EdgeInsets.all(defaultPadding(context)),
                      child: ElevatedButton(
                          style: ButtonStyle(
                            textStyle: MaterialStateProperty.all(
                                TextStyle(fontSize: 18)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8))),
                            minimumSize: MaterialStateProperty.all(Size(
                                width(context) * .92, width(context) * .12)),
                            backgroundColor: MaterialStateProperty.all(
                                Theme.of(context)
                                    .colorScheme
                                    .secondary), //todo: change
                          ),
                          onPressed: save,
                          child: Center(
                              child: Container(
                                  child: Text(
                                      create
                                          ? strings
                                              .organization_view_entity_save_entity
                                          : strings
                                              .organization_view_entity_save_changes,
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondary))))))
                ],
              ),
            )));
  }
}

class ListWidget extends StatelessWidget {
  final List<Entity> entities;
  final ValueChanged<Entity> onInfoTapped;
  final ValueChanged<Entity> onChildTapped;
  final EntitiesLoadedOrganizationViewState organizatiOnViewState;
  final String parentEntityName;

  ListWidget(
      {required this.entities,
      required this.onInfoTapped,
      required this.onChildTapped,
      required this.organizatiOnViewState,
      required this.parentEntityName,
      required Key key})
      : super(key: key);

  //todo: implement picture access
  String entityImagePath(int index) =>
      EntityRepository.getFilePath(entities[index]);

  Widget listItem(BuildContext buildContext, int index) => Card(
      margin: EdgeInsets.symmetric(
          horizontal: defaultPadding(buildContext),
          vertical: defaultPadding(buildContext) / 2),
      child: Container(
          child: Stack(
        fit: StackFit.passthrough,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ImageWidget(
                path: entityImagePath(index),
                width: width(buildContext) - defaultPadding(buildContext) * 2,
                height: height(buildContext) * .2,
                borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              ),
              Container(
                padding: EdgeInsets.only(
                    left: defaultPadding(buildContext),
                    right: defaultPadding(buildContext),
                    top: defaultPadding(buildContext),
                    bottom: parentEntityName == ""
                        ? defaultPadding(buildContext)
                        : 0),
                child: Text(entities[index].name,
                    style: Theme.of(buildContext).textTheme.headline2),
              ),
              if (parentEntityName != "")
                Container(
                  padding: EdgeInsets.only(
                      left: defaultPadding(buildContext),
                      right: defaultPadding(buildContext),
                      top: defaultPadding(buildContext),
                      bottom: defaultPadding(buildContext)),
                  child: Text(parentEntityName,
                      style: Theme.of(buildContext).textTheme.subtitle2),
                ),
              if (organizatiOnViewState.hasChildren(entities[index].id!))
                Container(
                  child: ElevatedButton(
                      style: ButtonStyle(
                        textStyle:
                            MaterialStateProperty.all(TextStyle(fontSize: 18)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                        minimumSize: MaterialStateProperty.all(Size(
                            width(buildContext) * .84,
                            width(buildContext) * .12)),
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(buildContext)
                                .colorScheme
                                .secondary), //todo: change
                      ),
                      onPressed: () {
                        onChildTapped(entities[index]);
                      },
                      child: Center(
                          child: Icon(FontAwesomeIcons.arrowRight,
                              color: Theme.of(buildContext)
                                  .colorScheme
                                  .onSecondary))),
                  padding: EdgeInsets.only(
                      left: defaultPadding(buildContext),
                      right: defaultPadding(buildContext),
                      bottom: defaultPadding(buildContext)),
                )
              else if (organizatiOnViewState.addChildPossible(entities[index]))
                Container(
                  child: ElevatedButton(
                      style: ButtonStyle(
                        textStyle:
                            MaterialStateProperty.all(TextStyle(fontSize: 18)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                        minimumSize: MaterialStateProperty.all(Size(
                            width(buildContext) * .84,
                            width(buildContext) * .12)),
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(buildContext)
                                .colorScheme
                                .secondary), //todo: change
                      ),
                      onPressed: () async {
                        Entity? toAdd = await showEntityDialog(
                            buildContext,
                            null,
                            organizatiOnViewState
                                .getDaughterLevel(entities[index].level)!,
                            entities[index].id);
                        if (toAdd != null) {
                          buildContext
                              .read<OrganizationViewBloc>()
                              .add(AddEntity(toAdd));
                        }
                      },
                      child: Center(
                          child: Icon(FontAwesomeIcons.plus,
                              color: Theme.of(buildContext)
                                  .colorScheme
                                  .onSecondary))),
                  padding: EdgeInsets.only(
                      left: defaultPadding(buildContext),
                      right: defaultPadding(buildContext),
                      bottom: defaultPadding(buildContext)),
                )
            ],
          ),
          Positioned(
              right: defaultPadding(buildContext),
              top: height(buildContext) * .2 - width(buildContext) * .06,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
                  minimumSize: MaterialStateProperty.all(Size(
                      width(buildContext) * .2, width(buildContext) * .12)),
                  backgroundColor: MaterialStateProperty.all(
                      Theme.of(buildContext)
                          .colorScheme
                          .primary), //todo: change
                ),
                onPressed: () {
                  onInfoTapped(entities[index]);
                },
                child: Center(
                    child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      Icon(MdiIcons.fileDocument,
                          color:
                              Theme.of(buildContext).colorScheme.onSecondary),
                      SizedBox(
                        width: defaultPadding(buildContext),
                      ),
                      Container(
                          child: Text(strings.organization_view_info_button,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Theme.of(buildContext)
                                      .colorScheme
                                      .onPrimary)))
                    ])),
              ))
        ],
      )));

  @override
  Widget build(BuildContext context) {
    return Container(
      child:
          ListView.builder(itemBuilder: listItem, itemCount: entities.length),
    );
  }
}

class OverviewWidget extends StatelessWidget {
  OverviewWidget(
      {Key? key,
      required this.entity,
      required this.onTasksTapped,
      required this.onSurveysTapped,
      required this.onAppliedInterventionsTapped,
      required this.onUpdateEntityTapped})
      : super(key: key);
  ValueChanged<Entity> onTasksTapped;
  ValueChanged<Entity> onSurveysTapped;
  ValueChanged<Entity> onAppliedInterventionsTapped;
  ValueChanged<Entity> onUpdateEntityTapped;
  Entity entity;

  //todo: implement pic
  String getEntityPicPath() => EntityRepository.getFilePath(entity);

  String getSurveyIconPath(Survey survey) =>
      SurveyRepository.getIconFilePath(survey);

  String getInterventionIconPath(Intervention intervention) =>
      InterventionRepository.getInterventionIconPath(intervention);

  Widget generalCardContent(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ImageWidget(
            path: getEntityPicPath(),
            width: width(context) * .92,
            height: height(context) * .2,
            borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
          ),
          Container(
              margin: EdgeInsets.all(defaultPadding(context)),
              child: Row(children: [
                Expanded(
                    child: Text(strings.organization_view_info,
                        style: Theme.of(context).textTheme.headline2)),
                SizedBox(width: defaultPadding(context)),
                CustomIconButton(
                    () => onUpdateEntityTapped(entity),
                    MdiIcons.pen,
                    Size(width(context) * .1, width(context) * .1),
                    true)
              ])),
          if (entity.customData.isNotEmpty)
            Container(
                margin: EdgeInsets.only(
                    left: defaultPadding(context),
                    right: defaultPadding(context),
                    bottom: defaultPadding(context) / 2),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                        entity.customData.length,
                        (index) => Container(
                            margin: EdgeInsets.only(
                                bottom: defaultPadding(context) / 2),
                            child: RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: entity.customData[index].name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: entity.customData[index].type ==
                                          CustomDataType.INT
                                      ? (entity.customData[index].intValue ?? 0)
                                          .toString()
                                      : (entity.customData[index].stringValue ??
                                          ""),
                                  style: Theme.of(context).textTheme.bodyText1)
                            ]))))))
        ]);
  }

  Widget taskCardContent(BuildContext context) {
    TaskState taskState = context.read<TaskBloc>().state;

    List<Task> firstThreeTasks = [];

    if (taskState is LoadedTaskState) {
      firstThreeTasks = taskState.firstThreeUndoneTasks(entityID: entity.id);
    }

    return Container(
        padding: EdgeInsets.all(defaultPadding(context)),
        child: Column(children: [
          Container(
              margin: EdgeInsets.only(bottom: defaultPadding(context) / 2),
              child: Text(strings.main_menu_tasks,
                  style: Theme.of(context).textTheme.headline2)),
          if (firstThreeTasks.isNotEmpty)
            Column(
              children: List.generate(
                  firstThreeTasks.length,
                  (index) => taskRow(context, firstThreeTasks[index],
                      checkChangePossible: false,
                      separator: (index != firstThreeTasks.length - 1))),
            ),
          Container(
              margin: EdgeInsets.only(top: defaultPadding(context) / 2),
              child: defaultGreenButton(context, () => onTasksTapped(entity),
                  icon: MdiIcons.arrowRight, minWidth: width(context) * .84))
        ]));
  }

  Widget surveyCardContent(BuildContext context) {
    List<Survey> firstThreeSurveys = [];
    for (AppliedIntervention appliedIntervention
        in entity.appliedInterventions) {
      for (Survey element in appliedIntervention.intervention.surveys) {
        firstThreeSurveys.add(element);
        if (firstThreeSurveys.length >= 3) {
          break;
        }
      }
      if (firstThreeSurveys.length >= 3) {
        break;
      }
    }

    return Container(
        padding: EdgeInsets.all(defaultPadding(context)),
        child: Column(children: [
          Container(
              margin: EdgeInsets.only(bottom: defaultPadding(context) / 2),
              child: Text(strings.organization_view_surveys,
                  style: Theme.of(context).textTheme.headline2)),
          if (firstThreeSurveys.isNotEmpty)
            Column(
              children: List.generate(
                  firstThreeSurveys.length,
                  (index) => surveyRow(
                      context,
                      firstThreeSurveys[index],
                      SurveyRepository.getIconFilePath(
                          firstThreeSurveys[index]),
                      separator: index != firstThreeSurveys.length - 1)),
            ),
          Container(
              margin: EdgeInsets.only(top: defaultPadding(context) / 2),
              child: defaultGreenButton(context, () => onSurveysTapped(entity),
                  icon: MdiIcons.arrowRight, minWidth: width(context) * .84))
        ]));
  }

  Widget appliedInterventionCardContent(BuildContext context) {
    List<AppliedIntervention> firstThreeAppliedInterventions =
        entity.appliedInterventions;
    if (firstThreeAppliedInterventions.length > 3) {
      firstThreeAppliedInterventions =
          firstThreeAppliedInterventions.sublist(0, 3);
    }
    return Container(
        padding: EdgeInsets.all(defaultPadding(context)),
        child: Column(children: [
          Container(
              margin: EdgeInsets.only(bottom: defaultPadding(context) / 2),
              child: Text(strings.organization_view_applied_interventions,
                  style: Theme.of(context).textTheme.headline2)),
          if (firstThreeAppliedInterventions.isNotEmpty)
            Column(
              children: List.generate(
                  firstThreeAppliedInterventions.length,
                  (index) => interventionRow(
                      context,
                      firstThreeAppliedInterventions[index].intervention,
                      InterventionRepository.getInterventionIconPath(
                          firstThreeAppliedInterventions[index].intervention),
                      separator:
                          index != firstThreeAppliedInterventions.length - 1)),
            ),
          Container(
              margin: EdgeInsets.only(top: defaultPadding(context) / 2),
              child: defaultGreenButton(context, () => onSurveysTapped(entity),
                  icon: MdiIcons.arrowRight, minWidth: width(context) * .84))
        ]));
  }

  Widget childWidget(BuildContext context, int index) {
    return Card(
        margin: EdgeInsets.symmetric(
            horizontal: defaultPadding(context),
            vertical: defaultPadding(context) / 2),
        child: index == 0
            ? generalCardContent(context)
            : index == 1
                ? taskCardContent(context)
                : index == 2
                    ? surveyCardContent(context)
                    : appliedInterventionCardContent(context));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: childWidget, itemCount: 4);
  }
}
