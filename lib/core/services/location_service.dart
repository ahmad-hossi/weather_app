import 'package:dartz/dartz.dart';
import 'package:location/location.dart';
import '../constants/enum.dart';

abstract class AppLocation {
  Future<Either<LocationFailureType, LocationData>>  getCurrentLocation();
}

class AppLocationImpl implements AppLocation {
  final Location _location;
  AppLocationImpl(this._location);

  @override
  Future<Either<LocationFailureType, LocationData>>
       getCurrentLocation() async {
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        return const Left(LocationFailureType.serviceLocationNotEnable);
      }
    }

    PermissionStatus permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted == PermissionStatus.denied) {
        return const Left(LocationFailureType.denied);
      } else if (permissionGranted == PermissionStatus.deniedForever) {
        return const Left(LocationFailureType.deniedForever);
      }
    }

    LocationData currPosition = await _location.getLocation();
    return Right(currPosition);
  }
}
