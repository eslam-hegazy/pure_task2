import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:pure_task2/constants.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  Future<void> initPlatformState() async {
    OneSignal.shared.setLogLevel(OSLogLevel.debug, OSLogLevel.none);
    await OneSignal.shared.setAppId(apiKey);
    OneSignal.shared.setOnWillDisplayInAppMessageHandler((message) {
      print("ON WILL DISPLAY IN APP MESSAGE ${message.jsonRepresentation()}");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlatformState();
  }

  void submitNotification(String title, String des) async {
    var deviceState = await OneSignal.shared.getDeviceState();

    if (deviceState == null || deviceState.userId == null) return;
    var playerId = deviceState.userId!;
    var notification = OSCreateNotification(
      playerIds: [playerId],
      content: des,
      heading: title,
    );
    var response = await OneSignal.shared.postNotification(notification);
    setState(() {
      print(response);
    });
  }

  final TextEditingController titleController = TextEditingController();
  final TextEditingController desController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "One Signal",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.20,
                    child: Lottie.network(notificationImage)),
                const Text(
                  "Notifications",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                TextFormField(
                  controller: titleController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter Title Notification";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Enter Tite Notification",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: desController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter Description Notification";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Enter Description Notification",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      submitNotification(titleController.text.toString(),
                          desController.text.toString());
                      titleController.text = "";
                      desController.text = "";
                      showMyDialog(context);
                    }
                  },
                  child: const Text("Send Notification"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
