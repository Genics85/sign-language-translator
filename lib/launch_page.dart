import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:signintepreter/buttons.dart';
import 'app_text.dart';
import 'camera_page.dart';
import 'package:tflite/tflite.dart';

import 'learning_page.dart';

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
                                label: "Learn",
                                onpress: () {
                                   Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Learning()));
                                },
                                image: "images/learn.png",
                              ),
                              SizedBox(height: 20),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Button(
                                      label: "From gallery",
                                      image: "images/gallery.png",
                                      onpress: () {
                                        pickImage();
                                      },
                                    ),
                                    const SizedBox(width: 20),
                                    Button(
                                      label: "Live translation",
                                      image: "images/video.png",
                                      onpress: () async {
                                        await availableCameras()
                                            .then((value) => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) => CameraPage(
                                                          cameras: value,
                                                        ))));
                                      },
                                    ),
                                  ]),
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
                                ? AppText(text:"${_outputs[0]["label"]}",size: 60,)
                                : Container(),
                            Container(
                              margin: EdgeInsets.only(bottom: 40,left: 15,right:15 ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Button(
                                    label: 'Learn',
                                    imageHeight: 50,
                                    imageWidth:50,
                                    width: 100,
                                    height:75,
                                    onpress: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Learning()));
                                    },
                                    image: "images/learn.png",
                                  ),
                                  const SizedBox(width: 10,),
                                  Button(
                                    label:"From gallery",
                                    imageHeight: 50,
                                    imageWidth:50,
                                    width: 100,
                                    height:75,
                                    image: "images/gallery.png",
                                    onpress: () {
                                      pickImage();
                                      debugPrint("${_outputs[0]["label"]}");
                                    },
                                  ),
                                  const SizedBox(width: 10),
                                  Button(
                                    label: "Live ",
                                    imageHeight: 50,
                                    imageWidth:50,
                                    width: 100,
                                    height:75,
                                    image: "images/video.png",
                                    onpress: () async {
                                      await availableCameras()
                                          .then((value) => Navigator.push(
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
