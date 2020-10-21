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

import 'package:Pangolin/applications/clock/main.dart';
import 'package:Pangolin/utils/localization/localization.dart';
import 'package:Pangolin/utils/hiveManager.dart';
import 'package:flutter/material.dart';
import 'package:Pangolin/applications/calculator/calculator.dart';
import 'package:Pangolin/applications/containers/containers.dart';
import 'package:Pangolin/applications/files/main.dart';
import 'package:Pangolin/applications/editor/editor.dart';
import 'package:Pangolin/applications/terminal/main.dart';
import 'package:Pangolin/applications/browser/main.dart';
import 'package:Pangolin/applications/terminal/root/main.dart';
import 'package:Pangolin/applications/developer/developer.dart';
import 'package:Pangolin/desktop/settings/settings.dart';
import 'package:Pangolin/applications/monitor/monitor.dart';
import 'package:Pangolin/utils/widgets/app_launcher.dart';
import 'package:Pangolin/applications/welcome/welcome.dart';
import 'package:Pangolin/utils/others/functions.dart';
import 'package:Pangolin/applications/logging/logging.dart';

Expanded tileSection(BuildContext context) {
  Localization local = Localization.of(context);
  return Expanded(
    child: Container(
        padding: EdgeInsets.all(15.0),
        margin: EdgeInsets.symmetric(
            horizontal: HiveManager.get("launcherWideMode") ? 100 : 350),
        child: SingleChildScrollView(
          child: Wrap(spacing: 18.0, children: [
            AppLauncherButton(
              type: AppLauncherButtonType.Drawer,
              app: TerminalApp(),
              icon: 'assets/Images/Icons/PNG/terminal.png',
              label: local.get("app_terminal"),
              color: Colors.grey[900],
              callback: toggleCallback,
            ),
            AppLauncherButton(
              type: AppLauncherButtonType.Drawer,
              app: Tasks(),
              icon: 'assets/Images/Icons/PNG/task.png',
              label: local.get("app_taskmanager"),
              color: Colors.cyan[900],
              callback: toggleCallback,
            ),
            AppLauncherButton(
                type: AppLauncherButtonType.Drawer,
                app: Settings(),
                icon: 'assets/Images/Icons/PNG/settings.png',
                label: local.get("app_settings"),
                color: Colors.deepOrange[700],
                callback: toggleCallback),
            AppLauncherButton(
                type: AppLauncherButtonType.Drawer,
                app: RootTerminalApp(),
                icon: 'assets/Images/Icons/PNG/root.png',
                label: local.get("app_rootterminal"),
                color: Colors.red[700],
                callback: toggleCallback),
            AppLauncherButton(
                type: AppLauncherButtonType.Drawer,
                app: TextEditorApp(),
                icon: 'assets/Images/Icons/PNG/notes.png',
                label: local.get("app_notes"),
                color: Colors.amber[700],
                callback: toggleCallback),
            AppLauncherButton(
                type: AppLauncherButtonType.Drawer,
                icon: 'assets/Images/Icons/PNG/note_mobile.png',
                label: local.get("app_notesmobile"),
                appExists: false),
            AppLauncherButton(
                type: AppLauncherButtonType.Drawer,
                app: Logs(),
                icon: 'assets/Images/Icons/PNG/logs.png',
                label: local.get("app_systemlogs"),
                color: Colors.red[700],
                callback: toggleCallback),
            AppLauncherButton(
                type: AppLauncherButtonType.Drawer,
                app: Files(),
                icon: 'assets/Images/Icons/PNG/files.png',
                label: local.get("app_files"),
                color: Colors.deepOrange[800],
                callback: toggleCallback),
            AppLauncherButton(
                type: AppLauncherButtonType.Drawer,
                icon: 'assets/Images/Icons/PNG/disks.png',
                label: local.get("app_disks"),
                appExists: false),
            AppLauncherButton(
                type: AppLauncherButtonType.Drawer,
                app: Calculator(),
                icon: 'assets/Images/Icons/PNG/calculator.png',
                label: local.get("app_calculator"),
                color: Colors.green,
                callback: toggleCallback),
            AppLauncherButton(
                type: AppLauncherButtonType.Drawer,
                app: Containers(),
                icon: 'assets/Images/Icons/PNG/containers.png',
                label: local.get("app_containers"),
                color: Colors.blue[800],
                callback: toggleCallback),
            AppLauncherButton(
                type: AppLauncherButtonType.Drawer,
                app: Welcome(),
                icon:
                    'assets/Images/Logos/dahliaOS/PNG/dahliaOS_logo_drop_shadow.png',
                label: local.get("app_welcome"),
                color: Colors.grey[900],
                callback: toggleCallback),
            AppLauncherButton(
                type: AppLauncherButtonType.Drawer,
                app: DeveloperApp(),
                icon: 'assets/Images/Icons/PNG/developer.png',
                label: 'Developer Options',
                color: Colors.red[700],
                callback: toggleCallback),
            AppLauncherButton(
                type: AppLauncherButtonType.Drawer,
                app: BrowserApp(),
                icon: 'assets/Images/Icons/PNG/web.png',
                label: local.get("app_web"),
                color: Colors.grey[500],
                callback: toggleCallback),
            AppLauncherButton(
                type: AppLauncherButtonType.Drawer,
                icon: 'assets/Images/Icons/PNG/clock.png',
                label: local.get("app_clock"),
                color: Colors.blue[900],
                callback: toggleCallback,
                app: Clock()),
            AppLauncherButton(
                type: AppLauncherButtonType.Drawer,
                icon: 'assets/Images/Icons/PNG/messages.png',
                label: local.get("app_messages"),
                appExists: false),
            AppLauncherButton(
                type: AppLauncherButtonType.Drawer,
                icon: 'assets/Images/Icons/PNG/music.png',
                label: local.get("app_music"),
                appExists: false),
            AppLauncherButton(
                type: AppLauncherButtonType.Drawer,
                icon: 'assets/Images/Icons/PNG/photos.png',
                label: local.get("app_media"),
                appExists: false),
            AppLauncherButton(
                type: AppLauncherButtonType.Drawer,
                icon: 'assets/Images/Icons/PNG/help.png',
                label: local.get("app_help"),
                appExists: false),
          ]),
        )),
  );
}
