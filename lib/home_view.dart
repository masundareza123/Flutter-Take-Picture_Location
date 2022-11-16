import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:take_picture_and_location/home_viewmodel.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (model) => model.initState(),
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Take Picture and Location"),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
              ),
              Align(
                child: InkWell(
                  onTap: () async {
                    await model.pickImageC();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white),
                    child: model.isPathNull() == false
                        ? const Center(
                            child: Text(
                              'Take Road Picture',
                            ),
                          )
                        : FittedBox(
                            child: Image.file(File(model.imagePath)),
                            // fit: BoxFit.scaleDown,
                          ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Text("Latitude: ${model.lat}", style: TextStyle(fontSize: 20),),
              Text("Longitude: ${model.long}", style: TextStyle(fontSize: 20),),
              Text("Address: ${model.address}", style: TextStyle(fontSize: 20),),

            ],
          ),
        ),
      ),
    );
  }
}
