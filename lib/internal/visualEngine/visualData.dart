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
class VisualInformation {
  int taskbarHeight;
  bool opaqueTitlebars;
  bool titleInfo;

  VisualInformation(
      {required this.taskbarHeight,
      required this.opaqueTitlebars,
      required this.titleInfo});

  factory VisualInformation.fromJson(Map<String, dynamic> parsedJson) {

    return VisualInformation(
        taskbarHeight: parsedJson['taskbarHeight'],
        opaqueTitlebars: parsedJson['opaqueTitlebars'],
        titleInfo: parsedJson['titleInfo']);
  }
}