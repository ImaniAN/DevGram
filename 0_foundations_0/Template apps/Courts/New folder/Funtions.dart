import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import '../backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../auth/auth_util.dart';

String getMapUrl(LatLng location) {
  return 'https://www.google.com/maps/search/?api=1&'
      'query=${location.latitude},${location.longitude}';
}

String getAverageRating(List<CommentsRecord> comments) {
  if (comments.isEmpty) {
    return '-';
  }
  var ratingsSum = 0.0;
  for (final comment in comments) {
    ratingsSum += comment.courtQualityRating;
  }
  return '${(ratingsSum / comments.length).toStringAsFixed(1)}';
}

LatLng getInitialMapLocation(LatLng userLocation) {
  if (userLocation == null ||
      (userLocation.latitude == 0 && userLocation.longitude == 0)) {
    return LatLng(40.8295538, -73.9386429);
  }
  return userLocation;
}
