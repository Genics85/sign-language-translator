import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:signintepreter/buttons.dart';
import 'camera_page.dart';
import 'package:tflite/tflite.dart';

class LaunchPage extends StatefulWidget {
  const LaunchPage({Key? key}) : super(key: key);

  @override
  State<LaunchPage> createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> {
  late List _outputs;
  bool _loading = false;

  XFile? _image;

  pickImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return null;
    setState(() {
      _loading = true;
      _image = image;
    });
    classifyImage(image);
  }

  @override
  void initState() {
    super.initState();
    _loading = true;

    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  File convertToFile(XFile xFile) => File(xFile.path);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading
          ? Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: Container(
                  
                  child: _image == null
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Button(
                                icon: const Icon(Icons.book),
                                onpress:(){}
                              ),
                              Row(
                                children:[
                                  Button(
                                icon: const Icon(Icons.image),
                                onpress: () {
                                  pickImage();
                                },
                              ),
                              const SizedBox(height: 20),
                              Button(
                                icon: const Icon(Icons.video_camera_front),
                                color: Colors.green,
                                onpress: () async {
                                  await availableCameras().then((value) => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => CameraPage(
                                                cameras: value,
                                              ))));
                                },
                              ),
                                ]
                              ),
                            ],
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                margin: EdgeInsets.only(top: 40),
                                height: 500,
                                width: MediaQuery.of(context).size.width * 0.9,
                                decoration: BoxDecoration(
                                    
                                    borderRadius: BorderRadius.circular(20)),
                                child: _image != null
                                    ? Image.file(File(_image!.path))
                                    : Container()),
                            _outputs != null
                                ? Text("${_outputs[0]["label"]}")
                                : Container(),
                            Container(
                              margin: EdgeInsets.only(bottom: 40),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Button(
                                     icon: const Icon(Icons.book),
                                     onpress:(){}
                                  ),
                                  Button(
                                    icon: const Icon(
                                      Icons.image
                                    ),
                                    onpress: () {
                                      pickImage();
                                      debugPrint("${_outputs[0]["label"]}");
                                    },
                                  ),
                                  const SizedBox(width: 20),
                                  Button(
                                    icon: const Icon(Icons.video_camera_front),
                                    color: Colors.green,
                                    onpress: () async {
                                      await availableCameras().then((value) => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => CameraPage(
                                                    cameras: value,
                                                  ))));
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
            ),
    );
  }

  loadModel() async {
    await Tflite.loadModel(
        model: "assets/model_unquant.tflite", labels: "assets/labels.txt");
  }

  classifyImage(XFile image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 2,
        threshold: 0.8,
        imageMean: 127.5,
        imageStd: 127.5);
    setState(() {
      _loading = false;
      _outputs = output!;
    });
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }
}
