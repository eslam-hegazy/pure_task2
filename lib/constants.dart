import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

const apiKey = "22d118d3-0c37-44a6-86f9-52c7064494c5";
const correctImage =
    "https://assets5.lottiefiles.com/packages/lf20_xdwtt5zc.json";
const notificationImage =
    "https://assets7.lottiefiles.com/packages/lf20_5ivqhhnz.json";
Future<void> showMyDialog(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.transparent,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(500),
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
        ),
        title: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Lottie.network(correctImage)),
      );
    },
  );
}
