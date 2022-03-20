import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_app/backend/repositories/EntityRepository.dart';
import 'package:mobile_app/frontend/components/buttons.dart';
import 'package:mobile_app/frontend/dependentsizes.dart';

class MainMenuOrganization extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainMenuOrganizationState();
  }
}

class MainMenuOrganizationState extends State<MainMenuOrganization> {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<EntityRepository>(
              create: (context) => EntityRepository())
        ],
        child: Builder(
            builder: (context) => Container(
                    child: Center(
                  child: CustomIconButton(
                      () => context
                          .read<EntityRepository>()
                          .getAllEntities()
                          .then((value) => value.forEach((element) {
                                print("entity: ${element.name}");
                                print(element.level.interventionsAreAllowed
                                    .toString());
                                if (element.level.interventionsAreAllowed) {
                                  print(element
                                      .level.allowedInterventions!.length
                                      .toString());
                                  element.level.allowedInterventions!
                                      .forEach((element) {
                                    print(element.intervention.toString());
                                  });
                                }
                              })),
                      FontAwesomeIcons.ad,
                      Size(width(context) * .1, width(context) * .1),
                      true),
                ))));
  }
}
