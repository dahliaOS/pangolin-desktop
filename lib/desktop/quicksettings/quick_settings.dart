/*
Copyright 2019 The dahliaOS Authors
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

import 'dart:ui';
import 'dart:io';
import 'package:Pangolin/internal/locales/locale_strings.g.dart';
import 'package:Pangolin/internal/locales/locales.g.dart';
import 'package:Pangolin/utils/others/functions.dart';
import 'package:Pangolin/desktop/window/model.dart';
import 'package:Pangolin/utils/hiveManager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:Pangolin/main.dart';
import 'package:Pangolin/desktop/settings/settings.dart';
import 'package:Pangolin/utils/others/wifi.dart';

class QuickSettings extends StatefulWidget {
  @override
  QuickSettingsState createState() => QuickSettingsState();
}

class QuickSettingsState extends State<QuickSettings> {
  double brightness = 0.8;
  double volume = 0.5;

  String _dateString;
  String _timeString;

  @override
  void initState() {
    super.initState();
    Pangolin.settingsBox = Hive.box("settings");
    _timeString = _formatDateTime(DateTime.now(), 'h:mm');
    _dateString = _formatDateTime(DateTime.now(), 'E, d MMMM yyyy');
    if (!isTesting)
      Timer.periodic(
          Duration(milliseconds: 100), (Timer t) => _getTime(context));
    else
      print("WARNING: Clock was disabled due to testing flag!");
  }

  void _getTime(BuildContext context) {
    final DateTime now = DateTime.now();
    final String formattedTime = HiveManager.get("showSeconds")
        ? _formatDateTime(now, 'h:mm:ss')
        : _formatDateTime(now, 'h:mm');
    final String formattedDate = _formatLocaleDate(now);
    setState(() {
      _timeString = formattedTime;
      _dateString = formattedDate;
    });
  }

  //Default date format
  String _formatDateTime(DateTime dateTime, String pattern) {
    return DateFormat(pattern).format(dateTime);
  }

  //Format date using language
  String _formatLocaleDate(DateTime dateTime) {
    return DateFormat.yMMMMd(context.locale.languageCode).format(dateTime);
  }

  MaterialButton buildPowerItem(
      IconData icon, String label, String function, String subARG) {
    return MaterialButton(
      onPressed: () {
        Process.run(
          function,
          [subARG],
        );
      },
      child: Column(
        //mainAxisSize: MainAxisSize.min,
        //mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.grey[900],
            size: scale(25.0),
            semanticLabel: 'Power off',
          ),
          Container(
            margin: EdgeInsets.only(top: scale(8)),
            child: Text(
              label,
              style: TextStyle(
                fontSize: scale(15.0),
                color: Colors.grey[900],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _getTime(context);
    var biggerFont = TextStyle(
      fontSize: scale(12.0),
      fontWeight: FontWeight.w400,
      color: Colors.white,
    );
    Widget topSection = Container(
      padding:
          EdgeInsets.symmetric(horizontal: scale(12.0), vertical: scale(5.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /*Expanded(
            child:*/
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: scale(8.0)),
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_timeString, style: biggerFont),
                      //Icon(Icons.brightness_1, size: 10.0,color: Colors.white),
                      Text('  •  ', style: biggerFont),
                      Text(_dateString, style: biggerFont),
                    ],
                  )),
            ),
          ),
          //Spacer(),
          //),
          new IconButton(
            icon: Icon(
              Icons.power_settings_new,
              size: scale(20),
            ),
            onPressed: () {
              showGeneralDialog(
                barrierLabel: "Barrier",
                barrierDismissible: true,
                barrierColor: Colors.black.withOpacity(0.5),
                transitionDuration: Duration(milliseconds: 120),
                context: context,
                pageBuilder: (_, __, ___) {
                  return Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: scale(90),
                      width: scale(400),
                      child: SizedBox.expand(
                        child: new Center(
                            child: new Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: scale(20.0), right: scale(20)),
                              child: buildPowerItem(Icons.power_settings_new,
                                  'Power off', 'poweroff', '-f'),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: scale(20.0), right: scale(20)),
                              child: buildPowerItem(
                                  Icons.refresh, 'Restart', 'reboot', ''),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: scale(20.0), right: scale(20)),
                              child: buildPowerItem(Icons.developer_mode,
                                  'Terminal', 'killall', 'pangolin_desktop'),
                            ),
                          ],
                        )),
                      ),
                      margin: EdgeInsets.only(
                          bottom: scale(75), left: scale(12), right: scale(12)),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                },
                transitionBuilder: (_, anim, __, child) {
                  return FadeTransition(
                    opacity: anim,
                    child: child,
                  );
                },
              );
            },
            color: const Color(0xFFffffff),
          ),

          new IconButton(
            icon: Icon(
              Icons.settings,
              size: scale(20),
            ),
            onPressed: () {
              Provider.of<WindowsData>(context, listen: false)
                  .add(child: Settings(), color: Colors.grey[900]);
              hideOverlays();
            },
            color: const Color(0xFFffffff),
          ),
        ],
      ),
    );

    void changeColor() {}

    Widget sliderSection = Container(
        margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(
                  Icons.brightness_6,
                  size: 20,
                  color: Colors.white,
                ),
                Expanded(
                  child: Slider(
                      value: brightness,
                      divisions: 10,
                      onChanged: (newBrightness) {
                        setState(() {
                          brightness = newBrightness;
                        });
                      }),
                ),
                Container(
                  width: scale(35),
                  child: Center(
                    child: Text(
                      "${(brightness * 100).toInt().toString()}",
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1.2,
                        fontSize: scale(12.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Icon(
                  Icons.volume_up,
                  size: scale(20),
                  color: Colors.white,
                ),
                Expanded(
                  child: Slider(
                    value: volume,
                    divisions: 20,
                    onChanged: (newVolume) {
                      setState(() {
                        volume = newVolume;
                      });
                    },
                  ),
                ),
                Container(
                  width: scale(35),
                  child: Center(
                    child: Text(
                      "${(volume * 100).toInt().toString()}",
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1.2,
                        fontSize: scale(12.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));

    Column buildTile(IconData icon, String label, Function onClick) {
      return Column(
        //mainAxisSize: MainAxisSize.min,
        //mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: scale(50),
            height: scale(50),
            child: FloatingActionButton(
              onPressed: onClick,
              elevation: 0.0,
              disabledElevation: 0.0,
              focusElevation: 0.0,
              highlightElevation: 0.0,
              hoverElevation: 0.0,
              child: Icon(icon, color: Colors.white, size: scale(20.0)),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: scale(10)),
            child: Text(
              label,
              style: biggerFont,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );
    }

    Widget tileSection = Expanded(
      child: Container(
          padding: EdgeInsets.all(scale(10.0)),
          child: GridView.count(
              physics: BouncingScrollPhysics(),
              crossAxisCount: 4,
              childAspectRatio: 3 / 4,
              children: [
                buildTile(Icons.network_wifi, LocaleStrings.pangolin.qsWifi,
                    () {
                  setState(() {
                    HiveManager.set("wifi", false);
                  });
                  Provider.of<WindowsData>(context, listen: false)
                      .add(child: WirelessApp(), color: Colors.deepOrange[700]);
                  hideOverlays();
                }),
                buildTile(
                    Icons.palette, LocaleStrings.pangolin.qsTheme, changeColor),
                buildTile(Icons.battery_full, '85%', changeColor),
                buildTile(Icons.do_not_disturb_off,
                    LocaleStrings.pangolin.qsDnd, changeColor),
                buildTile(Icons.lightbulb_outline,
                    LocaleStrings.pangolin.qsFlashlight, changeColor),
                buildTile(Icons.screen_lock_rotation,
                    LocaleStrings.pangolin.qsAutorotate, changeColor),
                buildTile(Icons.bluetooth, LocaleStrings.pangolin.qsBluetooth,
                    changeColor),
                buildTile(Icons.airplanemode_inactive,
                    LocaleStrings.pangolin.qsAirplanemode, changeColor),
                buildTile(Icons.invert_colors_off,
                    LocaleStrings.pangolin.qsInvertcolors, changeColor),
                buildTile(
                    Icons.language, LocaleStrings.pangolin.qsChangelanguage,
                    () {
                  int index = Locales.supported.indexOf(context.locale);
                  if (index + 1 < Locales.supported.length) {
                    context.locale = Locales.supported[index + 1];
                  } else {
                    context.locale = Locales.supported[0];
                  }
                }),
              ])),
    );

    return Container(
      color: Colors.black.withOpacity(0.0),
      //original color was 29353a, migrated to 2D2D2D
      //padding: const EdgeInsets.all(10.0),
      //alignment: Alignment.centerLeft,
      margin: EdgeInsets.all(scale(15.0)),
      width: scale(320),
      height: scale(500),
      child: Column(
        children: [topSection, sliderSection, tileSection],
      ),
    );
  }
}

void notImplemented(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text(LocaleStrings.pangolin.featurenotimplementedTitle),
        content: new Text(LocaleStrings.pangolin.featurenotimplementedValue),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
