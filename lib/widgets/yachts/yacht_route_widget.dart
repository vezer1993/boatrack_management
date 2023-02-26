import 'package:boatrack_management/models/yacht.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../models/teltonika/TeltonikaGPS.dart';
import '../../services/yachts_api.dart';
import '../routes/map_route_widget.dart';

class WidgetYachtRoute extends StatefulWidget {
  final Yacht yacht;

  const WidgetYachtRoute({Key? key, required this.yacht}) : super(key: key);

  @override
  State<WidgetYachtRoute> createState() => _WidgetYachtRouteState();
}

class _WidgetYachtRouteState extends State<WidgetYachtRoute> {
  late List<TeltonikaGPS> locations;
  bool dataLoaded = false;

  Future getRouteData() async {
    if (!dataLoaded) {
      locations =
          await getYachtRoute(widget.yacht, DateTime.now(), DateTime.now());
      dataLoaded = true;
    }
    return locations;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getRouteData(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.none) {
            return const Text("NO CONNECTION");
          } else if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return WidgetRouteMap(gpsLocations: locations, width: 1200, height: 500,);
          }
        });
  }
}
