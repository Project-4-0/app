
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';

class LocationMap extends StatefulWidget {
  final double lat;
  final double lng;
  LocationMap(this.lat, this.lng);

  @override
  State<StatefulWidget> createState() => _LocationMap(lat, lng);
}

class _LocationMap extends State<LocationMap> {
double lat;
double lng;
  _LocationMap(this.lat, this.lng);

  LocationData _currentLocation;
  MapController _mapController;

  int count = 0;

  bool _liveUpdate = true;
  bool _permission = false;
  bool getCurrentLoc = true;

  String _serviceError = '';

  final Location _locationService = Location();

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    initLocationService();
  }

  void initLocationService() async {
    print("Init Location Service");
    await _locationService.changeSettings(
      accuracy: LocationAccuracy.HIGH,
      interval: 1000,
    );

    LocationData location;
    bool serviceEnabled = true;
    bool serviceRequestResult;

    try {
      serviceEnabled = await _locationService.serviceEnabled();

      if (serviceEnabled && (getCurrentLoc == true) && (_liveUpdate == true)) {
        var permission = await _locationService.requestPermission();
        _permission = permission == PermissionStatus.GRANTED;

        if (_permission && (_liveUpdate == true)) {
          location = await _locationService.getLocation();

          _currentLocation = location;
          _locationService
              .onLocationChanged()
              .listen((LocationData result) async {
            if (mounted && (_liveUpdate == true)) {
              setState(() {
                _currentLocation = result;

                // If Live Update is enabled, move map center to the current location
                if (_liveUpdate) {

                  _mapController.move(
                      LatLng(_currentLocation.latitude,
                          _currentLocation.longitude),
                      _mapController.zoom);
                  serviceEnabled = false;
                }
              });
            }
          });
        }
      } else {
        serviceRequestResult = await _locationService.requestService();
        if (serviceRequestResult && getCurrentLoc) {
          initLocationService();
          return;
        }
      }
    } on PlatformException catch (e) {
      print(e);
      if (e.code == 'PERMISSION_DENIED') {
        _serviceError = e.message;
      } else if (e.code == 'SERVICE_STATUS_ERROR') {
        _serviceError = e.message;
      }
      location = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    LatLng currentLatLng = LatLng(this.lat, this.lng);

    var markers = <Marker>[
        // Current location marker
        Marker(
          width: 80.0,
          height: 80.0,
          point: currentLatLng,
          builder: (ctx) => new Container(
            child: Icon(
              Icons.my_location,
              color:  Theme.of(context).accentColor,
              size: 30.0,
            ),
          ),
        ),
    ];

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 0, bottom: 5.0, left: 5.0, right: 5.0),
        child: currentLatLng == null
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Flexible(
                    child: FlutterMap(
                      mapController: _mapController,
                      options: MapOptions(
                        center: LatLng(
                            currentLatLng.latitude, currentLatLng.longitude),
                        zoom: 16.0,
                      ),
                      layers: [
                        TileLayerOptions(
                          urlTemplate:
                              'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                          subdomains: ['a', 'b', 'c'],
                          // For example purposes. It is recommended to use
                          // TileProvider with a caching and retry strategy, like
                          // NetworkTileProvider or CachedNetworkTileProvider
                          tileProvider: NonCachingNetworkTileProvider(),
                        ),
                        // markers.length == itemsOfMapList.length
                        //     ? MarkerLayerOptions(markers: markers)
                        //     : null,
                        MarkerLayerOptions(markers: markers),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
} // End of class
