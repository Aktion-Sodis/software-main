import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_app/backend/repositories/UserRepository.dart';
import 'package:mobile_app/frontend/pages/main_menu_components/main_menu_home.dart';
import 'package:mobile_app/frontend/pages/main_menu_components/main_menu_organization.dart';
import 'package:mobile_app/frontend/pages/main_menu_components/main_menu_tasks.dart';
import 'package:mobile_app/frontend/pages/main_menu_components/main_menu_wiki.dart';

import 'package:mobile_app/frontend/strings.dart' as strings;

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MainMenuState();
  }
}

class MainMenuState extends State<MainMenu> {
  @override
  initState() {
    pageController = PageController(initialPage: 0);
    currentIndex = 0;
    super.initState();
  }

  late PageController pageController;

  late int currentIndex;

  onNavigationTap(int i) {
    setState(() {
      currentIndex = i;
    });
    pageController.animateToPage(i,
        duration: Duration(milliseconds: 300), curve: Curves.easeInOutCubic);
  }

  PageView mainPageView() => PageView(
        controller: pageController,
        pageSnapping: false,
        physics: NeverScrollableScrollPhysics(),
        children: [
          MainMenuHome(onNavigationTap),
          MainMenuOrganization(),
          MainMenuTasks(),
          MainMenuWiki()
        ],
      );

  BottomNavigationBar bottomNavigationBar() => BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onNavigationTap,
          items: [
            BottomNavigationBarItem(
                icon: const Icon(FontAwesomeIcons.home),
                label: strings.main_menu_home),
            BottomNavigationBarItem(
                icon: const Icon(FontAwesomeIcons.folder),
                label: strings.main_menu_organization),
            BottomNavigationBarItem(
                icon: const Icon(FontAwesomeIcons.tasks),
                label: strings.main_menu_tasks),
            BottomNavigationBarItem(
                icon: const Icon(FontAwesomeIcons.handSparkles),
                label: strings.main_menu_wiki),
          ]);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [RepositoryProvider(create: (context) => UserRepository())],
        child: Scaffold(
            bottomNavigationBar: bottomNavigationBar(),
            body: SafeArea(child: mainPageView())));
  }
}
