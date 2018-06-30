/*
 * Copyright 2018 Harsh Sharma
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'dart:convert';

import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  Avatar({Key key, this.contactImage, this.color, this.onTap})
      : super(key: key);

  final String contactImage;
  final Color color;
  final VoidCallback onTap;

  Widget build(BuildContext context) {
    return new Material(
      child: new InkWell(
        onTap: onTap,
        child: new Image.memory(
          base64.decode(contactImage),
          height: 100.0,
          width: 100.0,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
