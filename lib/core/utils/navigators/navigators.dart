import 'package:flutter/material.dart';
Future push(
    BuildContext context,
    Widget screen,
    ) async {
  return await Navigator.of(context).push(
    MaterialPageRoute(builder: (context)=> screen),
  );
}


Future pushReplacement(
    BuildContext context,
    Widget screen,
    ) async {
  return await Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (context)=> screen),
  );
}


Future pushNamedAndRemoveUntil(
    BuildContext context,
    Widget screen,
    ) async {

  return await Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (context)=> screen),(route) {
      return  false;
    },
  );
}




Future pop(
    BuildContext context,

    ) async {
  return Navigator.of(context).pop(

  );
}
