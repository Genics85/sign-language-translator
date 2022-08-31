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

  // Future takePicture() async {
  //   if (!_cameraController.value.isInitialized) {
  //     return null;
  //   }
  //   if (_cameraController.value.isTakingPicture) {
  //     return null;
  //   }
  //   try {
  //     await _cameraController.setFlashMode(FlashMode.off);
  //     XFile picture = await _cameraController.takePicture();
  //     // Navigator.push(
  //     //     context,
  //     //     MaterialPageRoute(
  //     //         builder: (context) => PreviewPage(
  //     //           picture: picture,
  //     //         )));
  //   } on CameraException catch (e) {
  //     debugPrint('Error occured while taking picture: $e');
  //     return null;
  //   }
  // }

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
            // setState(() {
            //   outputs = _outputs as List;
            // });
          }
        });
      });
    } catch (error) {
      print(error);
    }
  }

  // Future initCamera(CameraDescription cameraDescription) async {
  //   _cameraController =
  //       CameraController(cameraDescription, ResolutionPreset.medium);
  //   try {
  //     await _cameraController.initialize().then((_) {
  //       if (!mounted) return;
  //       setState(() {});

  //       _cameraController.startImageStream((image) => {
  //         if(!isDetecting){

  //         }
  //               // if (!isDetecting){

  //               //     isDetecting=true;
  //               //   var? _outputs=Tflite.runModelOnFrame(
  //               //       bytesList: image.planes.map((plane) {
  //               //         return plane.bytes;
  //               //       }).toList(),
  //               //       imageHeight: image.height,
  //               //       imageWidth: image.width,
  //               //       numResults: 1,
  //               //     ).then((value) {
  //               //       if (value!.isNotEmpty) {
  //               //         setRecognitions(value);
  //               //         isDetecting = false;
  //               //       }
  //               //     }),
  //               //   }
  //             });

  //     });
  //   } on CameraException catch (e) {
  //     debugPrint("camera error $e");
  //   }
  // }

  loadTfliteModel() async {
    String? res = await Tflite.loadModel(
        model: "assets/model_unquant.tflite", labels: "assets/labels.txt");
    print(res);
  }

  // runModel() async {
  //   widget.recognitionList = await Tflite.detectObjectOnFrame(
  //     bytesList: widget.cameraImage.planes.map((plane) {
  //       return plane.bytes;
  //     }).toList(),
  //     imageHeight: widget.cameraImage.height,
  //     imageWidth: widget.cameraImage.width,
  //     imageMean: 127.5,
  //     imageStd: 127.5,
  //     numResultsPerClass: 1,
  //     threshold: 0.4,
  //   );
  //   setState(() {
  //     widget.cameraImage;
  //   });
  // }

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

                      // Expanded(
                      //     child: IconButton(
                      //       onPressed: takePicture,
                      //       iconSize: 50,
                      //       padding: EdgeInsets.zero,
                      //       constraints: const BoxConstraints(),
                      //       icon: const Icon(Icons.circle, color: Colors.white),
                      //     )),
                    ]),
              ),
            )),
      ]),
    ));
  }
}
