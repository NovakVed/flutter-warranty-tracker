import 'package:flutter/material.dart';

class Shape {
  static final shapeRoundedLarge = RoundedRectangleBorder(
    side: BorderSide.none,
    borderRadius: BorderRadius.circular(12.0),
  );
  
  static final shapeSmall = RoundedRectangleBorder(
    side: BorderSide.none,
    borderRadius: BorderRadius.circular(8.0),
  );
}
