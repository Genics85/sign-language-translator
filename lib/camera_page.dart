import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:tflite/tflite.dart';
import 'app_text.dart';

class CameraPage extends StatefulWidget {
  CameraPage({
    Key? key,
     required this.cameras
     }) : super(key: key);

  final List<CameraDescription>? cameras;

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  
  double index = 0;
  double confidence = 0;
  String predOne = '';

  setRecognitions(outputs) {
    print(outputs);

    if (outputs[0]['index'] == 0) {
      index = 0;
    } else {
      index = 1;
    }

    confidence = outputs[0]['confidence'];

    setState(() {
      predOne = outputs[0]['label'];
    });
  }

  late CameraController _cameraController;
  bool _isRearCameraSelected = true;
  bool isDetecting = false;

  Future initCamera(CameraDescription cameraDescription) async {
    _cameraController =
        CameraController(cameraDescription, ResolutionPreset.medium);
    try {
      await _cameraController.initialize().then((value) {
        if (!mounted) return;
        setState(() {});
        _cameraController.startImageStream((image) {
          if (!isDetecting) {
            isDetecting = true;
            var _outputs = Tflite.runModelOnFrame(
              bytesList: image.planes.map((plane) {
                return plane.bytes;
              }).toList(),
              imageHeight: image.height,
              imageWidth: image.width,
              numResults: 1,
            ).then((value) {
              if (value!.isNotEmpty) {
                setRecognitions(value);
                isDetecting = false;
              }
            });
          }
        });
      });
    } catch (error) {
      print(error);
    }
  }

  loadTfliteModel() async {
    String? res = await Tflite.loadModel(
        model: "assets/model_unquant.tflite", labels: "assets/labels.txt");
    print(res);
  }


  @override
  void dispose() {
    _cameraController.stopImageStream();
    Tflite.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    loadTfliteModel();
    initCamera(widget.cameras![0]);
    // loadModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(children: [
        (_cameraController.value.isInitialized)
            ? CameraPreview(_cameraController)
            : Container(
                color: Colors.black,
                child: const Center(child: CircularProgressIndicator())),
        Align(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(24)),
              child: Container(
                padding: const EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.20,
                decoration: const BoxDecoration(color: Colors.white),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AppText(text:confidence.toString()),
                      IconButton(
                        padding: EdgeInsets.zero,
                        iconSize: 30,
                        icon: Icon(
                            _isRearCameraSelected
                                ? CupertinoIcons.switch_camera
                                : CupertinoIcons.switch_camera_solid,
                            color: Colors.black),
                        onPressed: () {
                          setState(() =>
                              _isRearCameraSelected = !_isRearCameraSelected);
                          initCamera(
                              widget.cameras![_isRearCameraSelected ? 0 : 1]);
                        },
                      ),
                    ]),
              ),
            )),
      ]),
    ));
  }
}
