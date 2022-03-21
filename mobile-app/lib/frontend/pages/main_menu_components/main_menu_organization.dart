import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_app/backend/Blocs/inapp/inapp_bloc.dart';
import 'package:mobile_app/backend/Blocs/organization_view/organization_view_bloc.dart';
import 'package:mobile_app/backend/Blocs/organization_view/organization_view_state.dart';
import 'package:mobile_app/backend/callableModels/CallableModels.dart';
import 'package:mobile_app/backend/repositories/AppliedInterventionRepository.dart';
import 'package:mobile_app/backend/repositories/EntityRepository.dart';
import 'package:mobile_app/backend/repositories/SurveyRepository.dart';
import 'package:mobile_app/frontend/components/buttons.dart';
import 'package:mobile_app/frontend/components/loadingsign.dart';
import 'package:mobile_app/frontend/dependentsizes.dart';

class MainMenuOrganization extends StatelessWidget {
  Widget appBarWidget(BuildContext context,
      EntitiesLoadedOrganizationViewState organizationViewState) {}

  Widget mainWidget(BuildContext context,
      EntitiesLoadedOrganizationViewState organizationViewState) {}

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
                        children: [
                          appBarWidget(context,
                              state as EntitiesLoadedOrganizationViewState),
                          mainWidget(context, state)
                        ],
                      );
                    }
                  }),
                )));
  }
}
