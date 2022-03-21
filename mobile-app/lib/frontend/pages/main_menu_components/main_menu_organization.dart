import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_app/backend/Blocs/inapp/inapp_bloc.dart';
import 'package:mobile_app/backend/Blocs/organization_view/organization_view_bloc.dart';
import 'package:mobile_app/backend/Blocs/organization_view/organization_view_events.dart';
import 'package:mobile_app/backend/Blocs/organization_view/organization_view_state.dart';
import 'package:mobile_app/backend/callableModels/CallableModels.dart';
import 'package:mobile_app/backend/repositories/AppliedInterventionRepository.dart';
import 'package:mobile_app/backend/repositories/EntityRepository.dart';
import 'package:mobile_app/backend/repositories/SurveyRepository.dart';
import 'package:mobile_app/frontend/components/buttons.dart';
import 'package:mobile_app/frontend/components/imageWidget.dart';
import 'package:mobile_app/frontend/components/loadingsign.dart';
import 'package:mobile_app/frontend/dependentsizes.dart';
import 'package:mobile_app/frontend/strings.dart' as strings;

class MainMenuOrganization extends StatelessWidget {
  Widget appBarWidget(BuildContext context,
      EntitiesLoadedOrganizationViewState organizationViewState) {
    return Container(
        height: height(context) * .1,
        width: width(context),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(margin: EdgeInsets.all(defaultPadding(context))),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
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
  String entityImagePath(int index) => "test";

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
                height: height(buildContext) * .15,
                borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              ),
              Container(
                padding: EdgeInsets.only(
                    left: defaultPadding(buildContext),
                    right: defaultPadding(buildContext),
                    top: defaultPadding(buildContext)),
                child: Text(entities[index].name,
                    style: Theme.of(buildContext).textTheme.headline2),
              ),
              Container(
                padding: EdgeInsets.only(
                    left: defaultPadding(buildContext),
                    right: defaultPadding(buildContext),
                    top: defaultPadding(buildContext),
                    bottom: defaultPadding(buildContext)),
                child: Text(parentEntityName,
                    style: Theme.of(buildContext).textTheme.bodyText1),
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
            ],
          ),
          Positioned(
              right: defaultPadding(buildContext),
              top: height(buildContext) * .15 - width(buildContext) * .06,
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
                      Icon(FontAwesomeIcons.arrowRight,
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
