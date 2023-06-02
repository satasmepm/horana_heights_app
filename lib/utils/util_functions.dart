import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
// import 'package:flutter_beautiful_popup/main.dart';

class UtilFuntions {
  //navigation function
  static void navigateTo(BuildContext context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }

  //go back function
  static void goBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  //push and remove navigation function
  static void pushRemoveNavigation(BuildContext context, Widget widget) {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => widget), (route) => false);
  }

  static void pageTransition(
      BuildContext context, Widget widgetchild, Widget widgetcurrent) {
    Navigator.push(
      context,
      PageTransition(
          child: widgetchild,
          childCurrent: widgetcurrent,
          type: PageTransitionType.rightToLeftJoined,
          duration: const Duration(milliseconds: 300),
          reverseDuration: const Duration(milliseconds: 300),
          curve: Curves.easeInCubic,
          alignment: Alignment.topCenter),
    );
  }

  static void pageTransitionwithremove(
      BuildContext context, Widget widgetchild, Widget widgetcurrent) {
    Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
            child: widgetchild,
            childCurrent: widgetcurrent,
            type: PageTransitionType.rightToLeftJoined,
            duration: const Duration(milliseconds: 300),
            reverseDuration: const Duration(milliseconds: 300),
            curve: Curves.easeInCubic,
            alignment: Alignment.topCenter),
        (route) => false);
  }
}
