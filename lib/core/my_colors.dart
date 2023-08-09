import 'package:flutter/material.dart';

dynamic myOrange = const Color(0xffdb5a42);
dynamic myMaroon = const Color(0xfe6a040f);
dynamic myPurple = const Color(0xff663ab6);

primeColor(BuildContext context) {
  return Theme.of(context).primaryColor;
}
primeColorDark(BuildContext context) {
  return Theme.of(context).primaryColorDark;
}
