/*
Copyright 2021 The dahliaOS Authors
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at
    http://www.apache.org/licenses/LICENSE-2.0
Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

import 'package:dahlia_backend/dahlia_backend.dart';
import 'package:pangolin/internal/locales/locale_strings.g.dart';
import 'package:pangolin/settings/pages/developer_options.dart';
import 'package:pangolin/settings/pages/backup.dart';
import 'package:pangolin/settings/pages/about.dart';
import 'package:pangolin/settings/pages/accounts.dart';
import 'package:pangolin/settings/pages/applications.dart';
import 'package:pangolin/settings/pages/connections.dart';
import 'package:pangolin/settings/pages/customization.dart';
import 'package:pangolin/settings/pages/display.dart';
import 'package:pangolin/settings/pages/general_management.dart';
import 'package:pangolin/settings/pages/security.dart';
import 'package:pangolin/settings/pages/sound.dart';
import 'package:pangolin/settings/pages/updates.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:pangolin/utils/theme.dart';
import 'package:pangolin/widgets/searchbar.dart';
import 'package:provider/provider.dart';

import 'dart:ui';

class Settings extends StatelessWidget {
  static List<TileItem> items = [
    TileItem(
      LocaleStrings.settings.tabsConnections,
      LocaleStrings.settings.tabsConnectionsDescription,
      Icons.wifi,
      Connections(),
    ),
    TileItem(
      LocaleStrings.settings.tabsSound,
      LocaleStrings.settings.tabsSoundDescription,
      Icons.volume_up,
      Sound(),
    ),
    TileItem(
      LocaleStrings.settings.tabsDisplay,
      LocaleStrings.settings.tabsDisplayDescription,
      Icons.brightness_5,
      Display(),
    ),
    TileItem(
      LocaleStrings.settings.tabsCustomization,
      LocaleStrings.settings.tabsCustomizationDescription,
      Icons.color_lens,
      Customization(),
    ),
    TileItem(
      LocaleStrings.settings.tabsApplications,
      LocaleStrings.settings.tabsApplicationsDescription,
      Icons.apps,
      Applications(),
    ),
    TileItem(
      LocaleStrings.settings.tabsSecurity,
      LocaleStrings.settings.tabsSecurityDescription,
      Icons.security,
      Security(),
    ),
    TileItem(
      LocaleStrings.settings.tabsAccounts,
      LocaleStrings.settings.tabsAccountsDescription,
      Icons.people,
      Accounts(),
    ),
    TileItem(
      LocaleStrings.settings.tabsBackup,
      LocaleStrings.settings.tabsBackupDescription,
      Icons.update,
      Backup(),
    ),
    TileItem(
      LocaleStrings.settings.tabsDevoptions,
      LocaleStrings.settings.tabsDevoptionsDescription,
      Icons.developer_mode,
      DeveloperOptions(),
    ),
    TileItem(
      LocaleStrings.settings.tabsGeneral,
      LocaleStrings.settings.tabsGeneralDescription,
      Icons.language,
      GeneralManagement(),
    ),
    TileItem(
      LocaleStrings.settings.tabsUpdates,
      LocaleStrings.settings.tabsUpdatesDescription,
      Icons.system_update,
      Updates(),
    ),
    TileItem(
      LocaleStrings.settings.tabsAbout,
      LocaleStrings.settings.tabsAboutDescription,
      Icons.laptop,
      About(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SettingsProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Settings',
        theme: theme(context),
        initialRoute: '/',
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/': (context) => SettingsPage(title: 'Settings'),
          // When navigating to the "/second" route, build the SecondScreen widget.
          '/search': (context) => Search(),
        },
      ),
    );
  }
}

Widget buildSettings(
    IconData icon, String title, Color color, context, Function() onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 30,
      margin: EdgeInsets.only(
        left: 15,
        top: 15,
      ),
      child: Row(
        children: [
          Padding(
              padding: EdgeInsets.all(5),
              child: Icon(icon, size: 20, color: color)),
          Padding(
            padding: EdgeInsets.all(5),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 15,
                color: Color(0xff000000),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Container buildSettingsHeader(String title) {
  return Container(
    padding: const EdgeInsets.only(
      top: 25,
      left: 15,
    ),
    alignment: Alignment.centerLeft,
    child: Text(
      title,
      style: TextStyle(
        fontSize: 15,
        color: Color(0xff222222),
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Padding settingsTitle(String title) {
  return Padding(
      padding: EdgeInsets.only(left: 25),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w300,
        ),
      ));
}

class SettingsPage extends StatefulWidget {
  final String? title;

  SettingsPage({Key? key, this.title}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final _data = Provider.of<PreferenceProvider>(context, listen: false);
    return Consumer<SettingsProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: <Widget>[
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SizedBox(
                          width: constraints.maxWidth > 768 ? 300 : 90,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Hero(
                                  tag: "search",
                                  child: Material(
                                    color: Theme.of(context)
                                        .cardColor
                                        .withOpacity(0.7),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                    //elevation: 5.0,
                                    child: constraints.maxWidth > 768
                                        ? Searchbar(
                                            hint: "Search Settings",
                                            controller: TextEditingController(),
                                            leading: Icon(Icons.search),
                                            trailing: Icon(Icons.menu),
                                          )
                                        : BoxContainer(
                                            height: 48,
                                            width: 48,
                                            customBorderRadius:
                                                BorderRadius.circular(8),
                                            color: Theme.of(context).cardColor,
                                            child: Icon(Icons.search),
                                          ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 0),
                                  child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    itemCount: Settings.items.length,
                                    itemBuilder: (BuildContext context, int i) {
                                      return Container(
                                        margin: EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          color: provider.pageIndex == i
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .secondary
                                              : Color(
                                                  _data.accentColor,
                                                ).withOpacity(0.0),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: ListTile(
                                          hoverColor: Theme.of(context)
                                              .colorScheme
                                              .secondary
                                              .withOpacity(0.3),
                                          dense: true,
                                          title: Visibility(
                                            visible: constraints.maxWidth > 768
                                                ? true
                                                : false,
                                            child: Text(
                                              Settings.items[i].title,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight:
                                                    provider.pageIndex == i
                                                        ? FontWeight.bold
                                                        : FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                          subtitle: Visibility(
                                            visible: constraints.maxWidth > 768
                                                ? true
                                                : false,
                                            child: Text(
                                              Settings.items[i].subtitle,
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    provider.pageIndex == i
                                                        ? FontWeight.w600
                                                        : FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                          leading: Icon(
                                            Settings.items[i].icon,
                                            color: provider.pageIndex == i
                                                ? Theme.of(context)
                                                    .textTheme
                                                    .bodyText1
                                                    ?.color
                                                : Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                          ),
                                          onTap: () {
                                            setState(
                                              () => provider.pageIndex = i,
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: PageTransitionSwitcher(
                            transitionBuilder:
                                (child, primaryAnimation, secondaryAnimation) {
                              return FadeThroughTransition(
                                animation: primaryAnimation,
                                secondaryAnimation: secondaryAnimation,
                                fillColor: Colors.transparent,
                                child: child,
                              );
                            },
                            child: IndexedStack(
                              key: ValueKey(provider.pageIndex),
                              index: provider.pageIndex,
                              children:
                                  Settings.items.map((e) => e.page).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

class TileItem {
  String title, subtitle;
  IconData icon;
  Widget page;

  TileItem(this.title, this.subtitle, this.icon, this.page);
}

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(builder: (context, provider, _) {
      return Container(
        color: Theme.of(context).backgroundColor,
        child: Center(
          child: Hero(
            tag: "search",
            child: Material(
              color: Theme.of(context).cardColor,
              borderRadius: const BorderRadius.all(Radius.circular(25)),
              //elevation: 5.0,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  width: 700,
                  height: 45.0,
                  margin: EdgeInsets.only(left: 10, right: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Future.delayed(Duration.zero, () {
                            Navigator.of(context).pop();
                          });
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          autofocus: true,
                          style: TextStyle(
                            color: Colors.grey[900],
                            fontSize: 15,
                          ),
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color,
                              fontSize: 15,
                            ),
                            icon: Icon(
                              Icons.search,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            hintText: LocaleStrings.settings.tabsSearch,
                            border: InputBorder.none,
                          ),
                          onSubmitted: null,
                          controller: provider.controller,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

class SettingsProvider extends ChangeNotifier {
  int? _pageIndex = 0;
  final TextEditingController _controller = TextEditingController();

  TextEditingController get controller => _controller;
  int get pageIndex => _pageIndex!;

  set pageIndex(int value) {
    _pageIndex = value;
    notifyListeners();
  }
}
