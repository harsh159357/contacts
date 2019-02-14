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

import 'dart:async';

import 'package:contacts/models/contact.dart';
import 'package:contacts/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import "package:google_maps_webservice/places.dart";
import "package:flutter_google_places/flutter_google_places.dart";

const kGoogleApiKey = GOOGLE_PLACE_API_KEY;

GoogleMapsPlaces _places = new GoogleMapsPlaces(apiKey:kGoogleApiKey);

final placeSearchPageKey = new GlobalKey<ScaffoldState>();

Future<Null> displayPrediction(Prediction p, ScaffoldState scaffold) async {
  if (p != null) {
    PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);
    String lat = detail.result.geometry.location.lat.toString();
    String lng = detail.result.geometry.location.lng.toString();

    Contact contact =
        new Contact(address: p.description, latitude: lat, longitude: lng);

    Navigator.pop(scaffold.context, contact);
/*
    scaffold.showSnackBar(
        new SnackBar(content: new Text("${p.description} - $lat/$lng")));
*/
  }
}

class PlaceSearchPage extends PlacesAutocompleteWidget {
  PlaceSearchPage()
      : super(
          apiKey: kGoogleApiKey,
          language: "en",
        );

  @override
  _PlaceSearchPageState createState() => new _PlaceSearchPageState();
}

class _PlaceSearchPageState extends PlacesAutocompleteState {
  @override
  Widget build(BuildContext context) {
    timeDilation = 1.0;
    final appBar = new AppBar(title: new AppBarPlacesAutoCompleteTextField());
    final body = new PlacesAutocompleteResult(onTap: (p) {
      displayPrediction(p, placeSearchPageKey.currentState);
    });
    return new Scaffold(key: placeSearchPageKey, appBar: appBar, body: body);
  }

  @override
  void onResponseError(PlacesAutocompleteResponse response) {
    super.onResponseError(response);
    placeSearchPageKey.currentState
        .showSnackBar(new SnackBar(content: new Text(response.errorMessage)));
  }

  @override
  void onResponse(PlacesAutocompleteResponse response) {
    super.onResponse(response);
    if (response != null && response.predictions.isNotEmpty) {}
  }
}
