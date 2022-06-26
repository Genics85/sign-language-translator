import "package:flutter/material.dart";

class LaunchPage extends StatefulWidget{
  const LaunchPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {

    return LaunchPageState();
  }

}

class LaunchPageState extends State<LaunchPage>{
  @override
  Widget build(BuildContext context) {

    return const Center(
      child:Text("Start of project"),
    );
  }

}