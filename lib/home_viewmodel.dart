import 'dart:io';

import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:take_picture_and_location/base_model.dart';
import 'package:take_picture_and_location/location_permission_service.dart';
import 'package:take_picture_and_location/location_service.dart';

class HomeViewModel extends BaseModel {
  LocationService _locationService = LocationService();
  LocationPermissionService _locationPermissionService = LocationPermissionService();

  String imagePath = '';
  double lat = 0.0;
  double long = 0.0;
  String address = '';
  File? image;

  void initState() async{
    await _locationPermissionService.checkService();
    await getLocation();
  }

  Future<void> getLocation() async {
    setBusy(true);
    try {
      final userLocation = await _locationService.getCurrentLocation();
      lat = userLocation.latitude!;
      long = userLocation.longitude!;
      address = userLocation.addressLine!;
    } catch (e) {
      address = "cannot get your address";
    }
    setBusy(false);
  }

  Future pickImageC() async {
    try {
      await getLocation();
      var image = await ImagePicker().pickImage(
          source: ImageSource.camera,
          preferredCameraDevice: CameraDevice.rear);

      if (image == null) return;
      final imageTemp = await saveImageLocal(image.path);
      imagePath = imageTemp.path;
      setBusy(false);
      print('[imageTemp] $imagePath');
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
    setBusy(false);
  }

  Future<File> saveImageLocal(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final image = File('${directory.path}.png');

    return File(imagePath).copy(image.path);
  }

  bool isPathNull() {
    if (imagePath.isEmpty) {
      return false;
    }
    return true;
  }
}