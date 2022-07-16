import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'camera_page.dart';

class LaunchPage extends StatefulWidget {
  const LaunchPage({Key? key}) : super(key: key);

  @override
  State<LaunchPage> createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(
        child: Center(
            child: GestureDetector(
              onTap: () async {
                await availableCameras().then((value) => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => CameraPage(cameras: value))));
              },
              child: Container(
                width:200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle
                ),
                child: Icon(Icons.camera)
              ),
            )
            // ElevatedButton(
            //   onPressed: () async {
            //     await availableCameras().then((value) => Navigator.push(context,
            //         MaterialPageRoute(builder: (_) => CameraPage(cameras: value))));
            //   },
            //   child: const Text("Take a Picture"),
            // )
          ),
      ),
    );
  }
}