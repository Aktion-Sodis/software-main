import 'dart:io';

import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile_app/backend/Blocs/in_app/in_app_bloc.dart';
import 'package:mobile_app/backend/Blocs/organization_view/organization_view_bloc.dart';
import 'package:mobile_app/backend/Blocs/organization_view/organization_view_events.dart';
import 'package:mobile_app/backend/Blocs/organization_view/organization_view_state.dart';
import 'package:mobile_app/backend/Blocs/task/task_bloc.dart';
import 'package:mobile_app/backend/Blocs/task/task_state.dart';
import 'package:mobile_app/backend/Blocs/user/user_bloc.dart';
import 'package:mobile_app/backend/callableModels/CallableModels.dart';
import 'package:mobile_app/backend/repositories/AppliedInterventionRepository.dart';
import 'package:mobile_app/backend/repositories/EntityRepository.dart';
import 'package:mobile_app/backend/repositories/InterventionRepository.dart';
import 'package:mobile_app/backend/repositories/SurveyRepository.dart';
import 'package:mobile_app/backend/storage/image_synch.dart';
import 'package:mobile_app/frontend/components/buttons.dart';
import 'package:mobile_app/frontend/components/imageWidget.dart';
import 'package:mobile_app/frontend/components/loadingsign.dart';
import 'package:mobile_app/frontend/dependentsizes.dart';
import 'package:mobile_app/frontend/pages/main_menu_components/main_menu_commonwidgets.dart';
import 'package:mobile_app/frontend/pages/main_menu_components/main_menu_tasks.dart';
import 'package:mobile_app/frontend/strings.dart' as strings;
import 'package:mobile_app/frontend/common_widgets.dart';
import 'package:mobile_app/services/photo_capturing.dart';
import 'package:mobile_app/frontend/pages/survey.dart' as surveyarea;

class MainMenuOrganization extends StatelessWidget {
  Widget appBarWidget(BuildContext context,
      EntitiesLoadedOrganizationViewState organizationViewState) {
    return Container(
        height: height(context) * .11,
        width: width(context),
        child: Column(children: [
          Expanded(
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            if (!(organizationViewState.organizationViewType ==
                    OrganizationViewType.LIST &&
                organizationViewState.currentListEntities.first.level.id ==
                    organizationViewState.getLevelsInOrder().first.id))
              Container(
                  alignment: Alignment.center,
                  margin:
                      EdgeInsets.symmetric(vertical: defaultPadding(context)),
                  child: CommonWidgets.defaultBackwardButton(
                      padding: EdgeInsets.symmetric(
                          horizontal: defaultPadding(context)),
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
                             padding: EdgeInsets.symmetric(
                               vertical: defaultPadding(context)
                             ),
                              child: Text(organizationViewState.appBarString,
                                  style:
                                      Theme.of(context).textTheme.headline2, overflow: TextOverflow.ellipsis,))),
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
                      if (organizationViewState.organizationViewType ==
                              OrganizationViewType.SURVEYS ||
                          organizationViewState.organizationViewType ==
                              OrganizationViewType.HISTORY)
                        Container(
                            child: CustomIconButton(
                          () {
                            if (organizationViewState.organizationViewType ==
                                OrganizationViewType.SURVEYS) {
                              context.read<OrganizationViewBloc>().add(
                                  NavigateToEntityHistory(organizationViewState
                                      .currentDetailEntity!));
                            } else {
                              context
                                  .read<OrganizationViewBloc>()
                                  .add(BackTapEvent());
                            }
                          },
                          MdiIcons.history,
                          Size(width(context) * .1, width(context) * .1),
                          true,
                          selected:
                              organizationViewState.organizationViewType ==
                                  OrganizationViewType.HISTORY,
                        ))
                    ],
                  )),
            )
          ])),
          Container(width: width(context), height: 1, color: Colors.grey)
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
                      .add(NavigateToEntityOverview(entity)),
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
          return Container(
              child: OverviewWidget(
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
                    showEntityDialog(context, entity, entity.level,
                            entity.parentEntityID)
                        .then((value) {
                      if (value != null) {
                        context
                            .read<OrganizationViewBloc>()
                            .add(UpdateEntity(value));
                      }
                    });
                  }));
        case OrganizationViewType.APPLIEDINTERVENTIONS:
          return Container(
              child: AppliedInterventionOverviewPage(
                  key: ValueKey(organizationViewState.currentDetailEntity)));
        case OrganizationViewType.APPLIEDINTERVENTIONDETAIL:
          return Container(
              child: AppliedInterventionPage(
                  key: ValueKey(
                      organizationViewState.currentDetailAppliedIntervention)));
        case OrganizationViewType.SURVEYS:
          return Container(
              child: SurveyWidget(
                  key: ValueKey(organizationViewState.currentDetailEntity)));
          break;
        case OrganizationViewType.TASKS:
          return Container(
              child: TaskWidget(
                  entity: organizationViewState.currentDetailEntity,
                  key: ValueKey(organizationViewState.currentDetailEntity)));
          break;
        case OrganizationViewType.HISTORY:
          return ExecutedSurveyHistory(
              entity: organizationViewState.currentDetailEntity!);
        case OrganizationViewType.EXECUTEDSURVEY:
          return ExecutedSurveyWidget(
              organizationViewState.executedSurveyToDisplay!,);

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
    return BlocBuilder<OrganizationViewBloc, OrganizationViewState>(
        builder: (context, state) {
      if (state is LoadingOrganizationViewState) {
        return Center(child: loadingSign(context));
      } else {
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            appBarWidget(context, state as EntitiesLoadedOrganizationViewState),
            levelIndicatorWidget(context, state),
            Expanded(child: mainWidget(context, state))
          ],
        );
      }
    });
  }
}

Future<Entity?> showEntityDialog(BuildContext buildContext, Entity? entity,
    Level level, String? parentEntityID) async {
  return showDialog(
      context: buildContext,
      builder: (context) {
        return EntityDialogWidget(entity, level, parentEntityID, buildContext);
      });
}

class EntityDialogWidget extends StatefulWidget {
  Entity? entity;
  Level level;
  String? parentEntityID;
  BuildContext buildContext;
  EntityDialogWidget(
      this.entity, this.level, this.parentEntityID, this.buildContext);

  @override
  State<StatefulWidget> createState() {
    return EntityDialogWidgetState();
  }
}

class EntityDialogWidgetState extends State<EntityDialogWidget> {
  final _formKey = GlobalKey<FormState>();

  bool create = true;
  Entity? entity;
  String? _preliminaryEntityId;

  String? get preliminaryEntityId => entity?.id ?? _preliminaryEntityId;
  set preliminaryEntityId(String? entityId) => _preliminaryEntityId = entityId;

  late TextEditingController nameEditingController;
  late TextEditingController descriptionEditingController;
  late List<TextEditingController> customDataControllers;

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
        print("input: ${customDataControllers[index].text.trim()}");
        return AppliedCustomData(
          customDataID: customData.id!,
          type: customData.type,
          name_ml: customData.name_ml,
          intValue: customData.type == CustomDataType.INT
              ? int.tryParse(customDataControllers[index].text.trim()) ?? 0
              : null,
          stringValue: customData.type == CustomDataType.STRING
              ? customDataControllers[index].text.trim()
              : null,
        );
      });
      print("saving entity: customData");
      appliedCustomDatas.forEach((element) {
        print(element.name +
            " " +
            element.intValue.toString() +
            " " +
            (element.stringValue ?? "e"));
      });
      if (create) {
        Entity toSave = Entity(
            id: preliminaryEntityId,
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
    XFile? r = await CameraFunctionality.takePicture(context: context);
    if (r != null) {
      if (entity == null && preliminaryEntityId == null) {
        preliminaryEntityId = UUID.getUUID();
      }
      SyncedFile syncedFile = getEntityPic()!;
      await syncedFile.updateAsPic(r);
      setStateIfMounted(() {});
    }
  }

  SyncedFile? getEntityPic() {
    if (entity != null) {
      return EntityRepository.getEntityPic(entity!);
    }
    if (preliminaryEntityId != null) {
      return EntityRepository.getEntityPicByID(preliminaryEntityId!);
    }
    return null;
  }

  void setStateIfMounted(Function function) {
    if (mounted) {
      setState(() {
        function();
      });
    } else {
      function();
    }
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
                width: width(context) * .92,
                height: height(context) * .2,
                borderRadius: BorderRadius.circular(8),
                imageFile: getEntityPic(),
              ),
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
                                alignment: Alignment.center,
                                margin: EdgeInsets.symmetric(
                                    vertical: defaultPadding(context)),
                                child: CommonWidgets.defaultBackwardButton(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: defaultPadding(context)),
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
                              child: Scrollbar(
                                  child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: columnChildren(),
                            ),
                          ))))),
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
                imageFile: EntityRepository.getEntityPic(entities[index]),
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
      child: Scrollbar(
          child: ListView.builder(
              itemBuilder: listItem, itemCount: entities.length)),
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
            imageFile: EntityRepository.getEntityPic(entity),
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
                  true,
                )
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
                                  text: entity.customData[index].name + ": ",
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
    return BlocBuilder<TaskBloc, TaskState>(builder: (context, state) {
      List<Task> firstThreeTasks = [];

      if (state is LoadedTaskState) {
        firstThreeTasks = state.firstThreeUndoneTasks(entityID: entity.id);
      }

      return Container(
          padding: EdgeInsets.all(defaultPadding(context)),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                child: defaultGreenButton(context, () {
                  if (firstThreeTasks.isNotEmpty) {
                    onTasksTapped(entity);
                  } else {
                    addTask(context, entity: entity);
                  }
                },
                    icon: firstThreeTasks.isNotEmpty
                        ? MdiIcons.arrowRight
                        : MdiIcons.plus,
                    minWidth: width(context) * .84))
          ]));
    });
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
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              margin: EdgeInsets.only(bottom: defaultPadding(context) / 2),
              child: Text(strings.organization_view_surveys,
                  style: Theme.of(context).textTheme.headline2)),
          if (firstThreeSurveys.isNotEmpty)
            Column(
              children: List.generate(
                  firstThreeSurveys.length,
                  (index) => surveyRow(context, firstThreeSurveys[index],
                      image: SyncedFile(SurveyRepository.getIconFilePath(
                          firstThreeSurveys[index])),
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

    return Container(
        padding: EdgeInsets.all(defaultPadding(context)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              margin: EdgeInsets.only(bottom: defaultPadding(context) / 2),
              child: Text(strings.organization_view_applied_interventions,
                  style: Theme.of(context).textTheme.headline2)),
          if (firstThreeAppliedInterventions.isNotEmpty)
            Container(
                margin: EdgeInsets.only(
                    bottom: defaultPadding(context) / 2,
                    left: defaultPadding(context),
                    right: defaultPadding(context)),
                child: InterventionFilterWidget(
                    allInterventions: List.generate(
                        firstThreeAppliedInterventions.length,
                        (index) =>
                            firstThreeAppliedInterventions[index].intervention),
                    selectable: false)),
          Container(
              margin: EdgeInsets.only(top: defaultPadding(context) / 2),
              child: defaultGreenButton(context, () async {
                if (firstThreeAppliedInterventions.isEmpty) {
                  AppliedIntervention? aI = await showAppliedInterventionDialog(
                      context,
                      entity,
                      null,
                      context.read<UserBloc>().state.user!);
                  if (aI != null) {
                    context
                        .read<OrganizationViewBloc>()
                        .add(AddAppliedIntervention(entity, aI));
                  }
                } else {
                  onAppliedInterventionsTapped(entity);
                }
              },
                  icon: firstThreeAppliedInterventions.isEmpty
                      ? MdiIcons.plus
                      : MdiIcons.arrowRight,
                  minWidth: width(context) * .84))
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
    return Scrollbar(
        child: ListView.builder(itemBuilder: childWidget, itemCount: 4));
  }
}

class AppliedInterventionOverviewPage extends StatelessWidget {
  const AppliedInterventionOverviewPage({Key? key}) : super(key: key);

  Widget listItem(BuildContext buildContext, int index) {
    List<AppliedIntervention> interventions = (buildContext
            .read<OrganizationViewBloc>()
            .state as EntitiesLoadedOrganizationViewState)
        .currentDetailEntity!
        .appliedInterventions;
    Intervention intervention = interventions[index].intervention;
    return interventionRow(buildContext, intervention,
        image: SyncedFile(
            InterventionRepository.getInterventionIconPath(intervention)),
        separator: interventions.length - 1 != index,
        pressable: true, onPressed: () async {
      buildContext
          .read<OrganizationViewBloc>()
          .add(NavigateToEntityAppliedInterventionDetail(interventions[index]));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Expanded(
            child: Scrollbar(
                child: ListView.builder(
                    itemBuilder: listItem,
                    itemCount: (context.read<OrganizationViewBloc>().state
                            as EntitiesLoadedOrganizationViewState)
                        .currentDetailEntity!
                        .appliedInterventions
                        .length))),
        Container(
          margin: EdgeInsets.all(
            defaultPadding(context),
          ),
          child: CommonWidgets.defaultIconButton(
              context: context,
              iconData: MdiIcons.plus,
              fillColor: Theme.of(context).colorScheme.secondary,
              buttonSizes: ButtonSizes.large,
              onPressed: () async {
                User user = context.read<UserBloc>().state.user!;
                Entity entity = (context.read<OrganizationViewBloc>().state
                        as EntitiesLoadedOrganizationViewState)
                    .currentDetailEntity!;
                AppliedIntervention? appliedIntervention =
                    await showAppliedInterventionDialog(
                        context, entity, null, user);
                if (appliedIntervention != null) {
                  context
                      .read<OrganizationViewBloc>()
                      .add(AddAppliedIntervention(entity, appliedIntervention));
                }
              }),
        )
      ],
    ));
  }
}

class AppliedInterventionPage extends StatefulWidget {
  const AppliedInterventionPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AppliedInterventionPageState();
  }
}

class AppliedInterventionPageState extends State<AppliedInterventionPage> {
  late AppliedIntervention appliedIntervention;
  late Entity entity;

  late SyncedFile imageFileSynced;
  File? imageFile;

  updatePic() async {
    XFile? r = await CameraFunctionality.takePicture(context: context);
    if (r != null) {
      await imageFileSynced.updateAsPic(r);
      imageFileSynced.file().then((value) {
        setState(() {
          imageFile = value;
        });
      });
    }
  }

  void updateState(bool? okay) async {
    setState(() {
      appliedIntervention.isOkay = okay ?? false;
    });
    context
        .read<OrganizationViewBloc>()
        .add(UpdateAppliedIntervention(entity, appliedIntervention));
  }

  @override
  void initState() {
    appliedIntervention = (context.read<OrganizationViewBloc>().state
            as EntitiesLoadedOrganizationViewState)
        .currentDetailAppliedIntervention!;
    entity = (context.read<OrganizationViewBloc>().state
            as EntitiesLoadedOrganizationViewState)
        .currentDetailEntity!;
    imageFileSynced = SyncedFile(
        AppliedInterventionRepository.getFotoPath(appliedIntervention));
    imageFileSynced.file().then((value) {
      setState(() {
        imageFile = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        child: SingleChildScrollView(
            child: Column(
      children: [
        Card(
          margin: EdgeInsets.all(defaultPadding(context)),
          child: Container(
              height: height(context) * .3,
              width: width(context) * .92,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ImageWidget(
                      imageFile: imageFileSynced,
                      width: width(context) * .92,
                      height: height(context) * .3,
                      borderRadius: BorderRadius.circular(8)),
                  Positioned(
                      right: defaultPadding(context),
                      bottom: defaultPadding(context),
                      child: CustomIconButton(
                          updatePic,
                          MdiIcons.camera,
                          Size(width(context) * .15, width(context) * .15),
                          true))
                ],
              )),
        ),
        if (appliedIntervention.intervention.interventionType ==
            InterventionType.TECHNOLOGY)
          Card(
              margin: EdgeInsets.symmetric(horizontal: defaultPadding(context)),
              child: Container(
                  padding: EdgeInsets.all(defaultPadding(context)),
                  child: Column(
                      children: [
                        Container(
                            margin: EdgeInsets.only(
                                bottom: defaultPadding(context)),
                            child: Text(
                                strings
                                    .organization_view_appliedintervention_detail_techonology_working,
                                style: Theme.of(context).textTheme.headline2)),
                        RadioListTile(
                            value: true,
                            groupValue: appliedIntervention.isOkay,
                            onChanged: updateState,
                            title: Text(strings.yes,
                                style: Theme.of(context).textTheme.bodyText1)),
                        RadioListTile(
                            value: false,
                            groupValue: appliedIntervention.isOkay,
                            onChanged: updateState,
                            title: Text(strings.no,
                                style: Theme.of(context).textTheme.bodyText1))
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min))),
        if (appliedIntervention.intervention.surveys.isNotEmpty)
          Card(
              margin: EdgeInsets.all(defaultPadding(context)),
              child: Container(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                          appliedIntervention.intervention.surveys.length + 1,
                          (index) => index == 0
                              ? Container(
                                  margin:
                                      EdgeInsets.all(defaultPadding(context)),
                                  child: Text(strings.organization_view_surveys,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline2))
                              : surveyRow(
                                  context,
                                  appliedIntervention
                                      .intervention.surveys[index - 1],
                                  image: SyncedFile(
                                      SurveyRepository.getIconFilePath(
                                          appliedIntervention.intervention
                                              .surveys[index - 1])),
                                  pressable: true,
                                  onPressed: () {
                                    context.read<OrganizationViewBloc>().add(
                                        StartSurvey(
                                            appliedIntervention.intervention
                                                .surveys[index - 1],
                                            appliedIntervention));
                                  },
                                )))))
      ],
    )));
  }
}

Future<AppliedIntervention?> showAppliedInterventionDialog(
    BuildContext buildContext,
    Entity entity,
    AppliedIntervention? appliedIntervention,
    User user) async {
  return showDialog(
      context: buildContext,
      builder: (context) {
        return AppliedInterventionDialog(
            entity, appliedIntervention, buildContext, user);
      });
}

class AppliedInterventionDialog extends StatefulWidget {
  Entity entity;

  AppliedIntervention? appliedIntervention;
  BuildContext buildContext;
  User user;

  AppliedInterventionDialog(
      this.entity, this.appliedIntervention, this.buildContext, this.user);

  @override
  State<StatefulWidget> createState() {
    return AppliedInterventionDialogState();
  }
}

class AppliedInterventionDialogState extends State<AppliedInterventionDialog> {
  final _formKey = GlobalKey<FormState>();

  bool create = true;
  AppliedIntervention? _appliedIntervention;
  Intervention? intervention;

  SyncedFile? syncedFile;
  File?
      imageFile; //datei erst verfügbar wenn appliedIntervention ungleich null (zweites view, weil dann id vorliegt)

  List<Intervention>? interventions;

  bool loaded = false;

  AppliedIntervention? get appliedIntervention => _appliedIntervention;

  set appliedIntervention(AppliedIntervention? appliedIntervention) {
    _appliedIntervention = appliedIntervention;
    syncedFile = SyncedFile(
        AppliedInterventionRepository.getFotoPath(appliedIntervention!));
    syncedFile!.file().then((value) {
      setStateIfMounted(() {
        imageFile = value;
      });
    });
  }

  updatePic() async {
    XFile? r = await CameraFunctionality.takePicture(context: context);
    if (r != null && appliedIntervention != null) {
      syncedFile ??= SyncedFile(
          AppliedInterventionRepository.getFotoPath(appliedIntervention!));
      await syncedFile!.updateAsPic(r);
      syncedFile?.file().then((value) {
        setStateIfMounted(() {
          imageFile = value;
        });
      });
    }
  }

  void setStateIfMounted(Function function) {
    if (mounted) {
      setState(() {
        function();
      });
    } else {
      function();
    }
  }

  @override
  void initState() {
    if (widget.appliedIntervention != null) {
      create = false;
      appliedIntervention = widget.appliedIntervention;
      syncedFile = SyncedFile(
          AppliedInterventionRepository.getFotoPath(appliedIntervention!));
      syncedFile!.file().then((value) {
        setStateIfMounted(() {
          imageFile = value;
          loaded = true;
        });
      });
    }
    super.initState();
    if (widget.appliedIntervention == null) {
      InterventionRepository.getInterventionsByLevelConnections(
              widget.entity.level.allowedInterventions!)
          .then((value) => setState(() {
                interventions = value;
                loaded = true;
              }));
    }
  }

  Widget interventionItem(BuildContext buildContext, int index) {
    //todo: implement localization
    return interventionRow(context, interventions![index],
        separator: (index != interventions!.length - 1),
        image: SyncedFile(InterventionRepository.getInterventionIconPath(
            interventions![index])),
        pressable: true, onPressed: () {
      AppliedIntervention toCreate = AppliedIntervention(
          id: UUID.getUUID(),
          whoDidIt: widget.user,
          intervention: interventions![index],
          executedSurveys: [],
          isOkay: true);
      setState(() {
        appliedIntervention = toCreate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: false,
        top: false,
        child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            body: Column(children: [
              Flexible(
                child: Container(
                    height: height(context) * .1,
                    width: width(context),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.symmetric(
                                  vertical: defaultPadding(context)),
                              child: CommonWidgets.defaultBackwardButton(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: defaultPadding(context)),
                                  context: context,
                                  goBack: () => Navigator.of(context)
                                      .pop(appliedIntervention))),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                    child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                            widget.appliedIntervention == null
                                                ? strings
                                                    .organization_view_dialog_add_appliedintervention
                                                : strings
                                                    .organization_view_dialog_update_appliedintervention,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline2))),
                              ],
                            ),
                          )
                        ])),
              ),
              !loaded
                  ? Center(child: loadingSign(context))
                  : appliedIntervention == null
                      ? Container(
                          child: Scrollbar(
                              child: ListView.builder(
                                  itemBuilder: interventionItem,
                                  itemCount: interventions!.length,
                                  shrinkWrap: true)))
                      : Container(
                          child: Column(
                          children: [
                            Card(
                              margin: EdgeInsets.all(defaultPadding(context)),
                              child: Container(
                                  height: height(context) * .3,
                                  width: width(context) * .92,
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      ImageWidget(
                                        width: width(context) * .92,
                                        height: height(context) * .3,
                                        borderRadius: BorderRadius.circular(8),
                                        imageFile: syncedFile,
                                      ),
                                      Positioned(
                                          right: defaultPadding(context),
                                          bottom: defaultPadding(context),
                                          child: CustomIconButton(
                                              updatePic,
                                              MdiIcons.camera,
                                              Size(width(context) * .15,
                                                  width(context) * .15),
                                              true))
                                    ],
                                  )),
                            ),
                            Container(
                                margin: EdgeInsets.all(defaultPadding(context)),
                                child: defaultGreenButton(
                                    context,
                                    () => Navigator.of(context)
                                        .pop(appliedIntervention),
                                    text: strings
                                        .organization_view_entity_save_entity,
                                    minWidth: width(context) * .92))
                          ],
                        ))
            ])));
  }
}

class SurveyWidget extends StatefulWidget {
  const SurveyWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SurveyWidgetState();
  }
}

class SurveyWidgetState extends State<SurveyWidget> {
  late Entity entity;
  late List<Map<String, dynamic>> currentlyDisplayedSurveys;
  late List<Intervention> currentlySelectedInterventions;

  void updateCurrentlySelectedInterventions(List<Intervention> selected) {
    if (selected.isEmpty) {
      List<Map<String, dynamic>> toSet = [];
      entity.appliedInterventions.forEach((element) {
        for (Survey survey in element.intervention.surveys) {
          toSet.add({"appliedIntervention": element, "survey": survey});
        }
      });
      setState(() {
        currentlyDisplayedSurveys = toSet;
      });
    } else {
      List<Map<String, dynamic>> toSet = [];
      entity.appliedInterventions.forEach((element) {
        if (selected.any((obj) => obj.id == element.intervention.id)) {
          for (Survey survey in element.intervention.surveys) {
            toSet.add({"appliedIntervention": element, "survey": survey});
          }
        }
      });
      setState(() {
        currentlyDisplayedSurveys = toSet;
      });
    }
  }

  @override
  void initState() {
    entity = (context.read<OrganizationViewBloc>().state
            as EntitiesLoadedOrganizationViewState)
        .currentDetailEntity!;
    currentlySelectedInterventions = [];
    currentlyDisplayedSurveys = [];
    for (var element in entity.appliedInterventions) {
      for (Survey survey in element.intervention.surveys) {
        currentlyDisplayedSurveys
            .add({"appliedIntervention": element, "survey": survey});
      }
    }
    super.initState();
  }

  Widget listItem(BuildContext buildContext, int i) {
    return surveyRow(context, currentlyDisplayedSurveys[i]["survey"],
        image: SyncedFile(SurveyRepository.getIconFilePath(
            currentlyDisplayedSurveys[i]["survey"])),
        pressable: true, onPressed: () {
      buildContext.read<OrganizationViewBloc>().add(StartSurvey(
          currentlyDisplayedSurveys[i]["survey"],
          currentlyDisplayedSurveys[i]["appliedIntervention"]));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: EdgeInsets.all(defaultPadding(context)),
            child: InterventionFilterWidget(
              allInterventions: List.generate(
                  entity.appliedInterventions.length,
                  (i) => entity.appliedInterventions[i].intervention),
              selectable: true,
              onSelectionChanged: (newList) =>
                  updateCurrentlySelectedInterventions(newList),
            )),
        Expanded(
            child: Scrollbar(
                child: ListView.builder(
                    itemBuilder: listItem,
                    itemCount: currentlyDisplayedSurveys.length)))
      ],
    );
  }
}

class ExecutedSurveyHistory extends StatelessWidget {
  const ExecutedSurveyHistory({Key? key, required this.entity})
      : super(key: key);
  final Entity entity;

  @override
  Widget build(BuildContext context) {
    List<ExecutedSurvey> executedSurveys = entity.executedSurveysDescending();
    return Container(
        child: Scrollbar(
            child: ListView.builder(
                itemBuilder: (context, index) {
                  return executedSurveyRow(context, executedSurveys[index],
                      () async {
                    context
                        .read<OrganizationViewBloc>()
                        .add(NavigateToExecutedSurvey(executedSurveys[index]));
                  });
                },
                itemCount: executedSurveys.length)));
  }
}

class ExecutedSurveyWidget extends StatelessWidget {
  final ExecutedSurvey executedSurvey;

  Map<Question, QuestionAnswer> mappedAnswers = {};

  ExecutedSurveyWidget(this.executedSurvey) {
    for (Question question in executedSurvey.survey.questions) {
      var answers = executedSurvey.answers
          .where((element) => element.questionID == question.id);
      QuestionAnswer? answer = answers.length > 0 ? answers.first : null;
      if (answer != null) {
        mappedAnswers[question] = answer;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return surveyarea.SurveyWidgetState.summaryWidget(
      survey: executedSurvey.survey,
      appliedIntervention: executedSurvey.appliedIntervention,
      executedSurveyId: executedSurvey.id!,
      answers: mappedAnswers,
      context: context,
    );
  }
}
