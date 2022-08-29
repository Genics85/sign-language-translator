// import 'dart:io';
// import "package:flutter/material.dart";
// import 'package:image_picker/image_picker.dart';
// import 'package:signintepreter/app_text.dart';
// import 'package:tflite/tflite.dart';

// class Pic extends StatefulWidget {
//   Pic({Key? key}) : super(key: key);

//   @override
//   State<Pic> createState() => _PicState();
// }

// class _PicState extends State<Pic> {
//   late List _outputs;
//   late File _image;
//   bool _loading = false;

//   loadModel() async {
//     await Tflite.loadModel(
//         model: "assets/detect.tflite",
//         labels: "assets/labels.txt",
//         numThreads: 1);
//   }

//   @override
//   void initState() {
//     super.initState();
//     _loading = true;

//     loadModel().then((value) {
//       setState(() {
//         _loading = false;
//       });
//     });
//   }

//   classifyImage(File image) async {
//     var output = await Tflite.runModelOnImage(
//         path: image.path,
//         imageMean: 0.0,
//         imageStd: 255.0,
//         numResults: 2,
//         threshold: 0.2,
//         asynch: true);
//     setState(() {
//       _loading = false;
//       _outputs = output!;
//     });
//   }

//   @override
//   void dispose() {
//     Tflite.close();
//     super.dispose();
//   }

//   pickImage() async {
//     var image = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (image == null) return null;
//     setState(() {
//       _loading = true;
//       _image = image as File;
//     });
//     classifyImage(_image);
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       child: Column(children: [
//         _loading?Container(
//           height: 300,
//           width: 300,
//         ):Container(
//           margin: EdgeInsets.all(20),
//           width: MediaQuery.of(context).size.width,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               _image==null?Container():Image.file(_image),
//               SizedBox(height: 20,),
//               _image==null?Container():_outputs!=null?
//               AppText(text: _outputs[0]["label"]):Container(child: Text(""),)
//             ],
//           ),

//         ),
//         SizedBox(height: 10,),
//         FloatingActionButton(
//           tooltip: "Pick Image",
//           onPressed: pickImage,
//           child: Icon(
//             Icons.add_a_photo,
//             size: 20,
//             color: Colors.white,
//             ),
          
//         )
//       ]),
//     );
//   }
// }
