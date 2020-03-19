import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'src/locations.dart' as locations;
import 'package:permission_handler/permission_handler.dart';
import 'package:fluttertoast/fluttertoast.dart';




void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  locations.ParkingSlots parkingSlots;
  final List<Marker> _markers = [];
  GoogleMapController controller;
  final LatLng _center = const LatLng(28.6862738, 77.2217831);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Map App"),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.refresh), onPressed:setMarkers)
          ],
        ),
        body: GoogleMap(
          onMapCreated: onMapCreated,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          markers: _markers.toSet(),
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 2,
          ),
        ),
      ),
    );
  }

  void onMapCreated(GoogleMapController controller) async{
    bool status = await requestLocationPermission();
    print("status:"+status.toString());
    if(!status) {
      return;
    }
    setMarkers();
    this.controller = controller;
  }


  void setMarkers() async
  {
    parkingSlots = await locations.getParkingSlots();
    String message="";
    bool flag = true;
    setState(() {
      _markers.clear();
      for(final parkingSlot in parkingSlots.parkingSlots)
      {
        if(flag && int.parse(parkingSlot.space) > 0)
          {
            flag = false;
            message = "Space Available";
          }
        else if(flag)
          {
            message = "No Space Available";
          }
        final marker = Marker(markerId: MarkerId(parkingSlot.lat),
            position: LatLng(double.parse(parkingSlot.lat),double.parse(parkingSlot.lng)),
            infoWindow: InfoWindow(
              title: "Available Spaces",
              snippet: parkingSlot.space,
            ));
        _markers.add(marker);
      }
      print("message:"+message);
      Fluttertoast.showToast(msg: message);
    });
  }

  Future<bool> requestLocationPermission() async
  {
    PermissionStatus status = await PermissionHandler().checkPermissionStatus(PermissionGroup.contacts);
    if(status == PermissionStatus.granted)
      {
        return true;
      }
    else
      {
        Map<PermissionGroup, PermissionStatus> permissions = await PermissionHandler().requestPermissions([PermissionGroup.location]);
        if(permissions[PermissionGroup.location] == PermissionStatus.granted)
          {
            return true;
          }
        else {
          Fluttertoast.showToast(msg: "You can not use this app without permission. Go to settings and allow permissions.");
          return false;
        }
      }
  }

}
