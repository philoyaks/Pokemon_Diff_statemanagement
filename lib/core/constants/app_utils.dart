import 'dart:io';

import 'package:flutter/material.dart';

String capitalize(String s) =>
    (s.length > 1) ? s[0].toUpperCase() + s.substring(1) : s.toUpperCase();

addZerosToId(int id) {
  switch (id.toString().length) {
    case 1:
      return '00$id';
    case 2:
      return '0$id';
    default:
      return id;
  }
}

getExpanedHeight(BuildContext context) {
  return 170.0 +
      MediaQuery.of(context).padding.top +
      kToolbarHeight +
      (Platform.isIOS ? 0 : 22);
}
