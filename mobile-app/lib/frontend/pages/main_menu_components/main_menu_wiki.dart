import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/backend/Blocs/content/content_bloc.dart';
import 'package:mobile_app/backend/Blocs/content/content_events.dart';
import 'package:mobile_app/backend/Blocs/content/content_state.dart';
import 'package:mobile_app/backend/callableModels/Content.dart';
import 'package:mobile_app/backend/repositories/ContentRepository.dart';
import 'package:mobile_app/backend/storage/image_synch.dart';
import 'package:mobile_app/frontend/components/loadingsign.dart';
import 'package:mobile_app/frontend/dependentsizes.dart';
import 'package:mobile_app/frontend/pages/main_menu_components/main_menu_app_bar.dart';
import 'package:mobile_app/frontend/pages/main_menu_components/main_menu_commonwidgets.dart';
import 'package:mobile_app/frontend/strings.dart' as strings;
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';

class MainMenuWiki extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MainMenuAppBar(context, () {}, strings.main_menu_wiki),
        Expanded(child:
            BlocBuilder<ContentBloc, ContentState>(builder: (context, state) {
          if (state is LoadedContentState) {
            LoadedContentState loadedContentState = state;
            return Column(
              children: [
                Container(
                    margin: EdgeInsets.all(defaultPadding(context)),
                    child: InterventionFilterWidget(
                      allInterventions: loadedContentState.allInterventions,
                      selectable: true,
                      onSelectionChanged: (selected) {
                        context
                            .read<ContentBloc>()
                            .add(UpdateSelectedInterventions(selected));
                      },
                    )),
                Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: defaultPadding(context)),
                    height: 1,
                    color: Colors.grey),
                Expanded(
                    child: ListView.builder(
                        itemCount: loadedContentState.contentsToDisplay.length,
                        itemBuilder: (context, index) => contentRow(context,
                                loadedContentState.contentsToDisplay[index],
                                () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => PDFViewWidget(
                                        content: loadedContentState
                                            .contentsToDisplay[index],
                                      )));
                            },
                                separator: index !=
                                    (loadedContentState
                                            .contentsToDisplay.length -
                                        1))))
              ],
            );
          } else {
            return Center(child: loadingSign(context));
          }
        }))
      ],
    );
  }
}

class PDFViewWidget extends StatefulWidget {
  PDFViewWidget({Key? key, required this.content}) : super(key: key);
  Content content;

  @override
  State<StatefulWidget> createState() {
    return PDFViewWidgetState();
  }
}

class PDFViewWidgetState extends State<PDFViewWidget> {
  late SyncedFile syncedFile;

  @override
  void initState() {
    //todo: datei
    syncedFile = ContentRepository.getContentPDFFile(widget.content);
    pdfFuture = getPDF();
    super.initState();
  }

  Future<PDFDocument?> getPDF() async {
    File? file = await syncedFile.file();
    if (file != null) {
      return PDFDocument.fromFile(file);
    } else {
      return null;
    }
  }

  late Future<PDFDocument?> pdfFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: [
      MainMenuAppBar(context, () {}, widget.content.name, showBackButton: true),
      Expanded(
          child: FutureBuilder<PDFDocument?>(
              future: pdfFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return PDFViewer(
                      document: snapshot.data!,
                      showNavigation: true,
                      showPicker: false);
                } else {
                  return Center(child: loadingSign(context));
                }
              }))
    ])));
  }
}
