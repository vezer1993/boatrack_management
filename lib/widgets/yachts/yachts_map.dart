import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_web/google_maps_flutter_web.dart'
as googleweb;
import 'dart:ui' as ui;

import '../../models/yacht.dart';
import '../../models/yacht_location.dart';
import '../../services/yachts_api.dart';
import 'maps_marker_widget.dart';

class YachtsMapWidget extends StatefulWidget {
  final List<Yacht> yachts;
  const YachtsMapWidget({Key? key, required this.yachts}) : super(key: key);

  @override
  State<YachtsMapWidget> createState() => _YachtsMapWidgetState();
}

class _YachtsMapWidgetState extends State<YachtsMapWidget> {
  late List<YachtLocation> locations;
  bool dataLoaded = false;

  Future getCharterData() async {
    if (!dataLoaded) {
      locations = await getYachtLocationList(widget.yachts);
      await loadMarkers();
      dataLoaded = true;
    }
    return locations;
  }

  //Google maps
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  LatLng currentLatLng = const LatLng(44.8, 14.59);

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
        future: getCharterData(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.none) {
            return const Text("NO CONNECTION");
          } else if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 500,
              child: GoogleMap(
                initialCameraPosition:
                CameraPosition(
                    target: currentLatLng,
                    zoom: 9),
                onMapCreated: (GoogleMapController
                controller) {
                  setState(() {
                  });
                },
                markers: markers.values.toSet(),
                mapType: MapType.normal,
                myLocationEnabled: true,
                zoomControlsEnabled: true,
                myLocationButtonEnabled: false,
              ),
            );
          }
        });
  }

  Future loadMarkers() async{
    for(YachtLocation loc in locations){
      LatLng latlong = LatLng(loc.lat!, loc.long!);

      var pic = await createImageFromWidget(MapsMarkerWidget(name: loc.yacht!.name.toString(),));

      Marker marker = Marker(
        markerId:
        MarkerId(loc.yacht!.id.toString()),
        position: latlong,
        icon: BitmapDescriptor.fromBytes(pic),
        infoWindow: InfoWindow(
          title: loc.yacht!.name,
        ),
      );
      markers[marker.markerId] = marker;
    }
  }

  Future createImageFromWidget( Widget widget){
    final RenderRepaintBoundary repaintBoundary = RenderRepaintBoundary();
    final RenderView renderView = RenderView(
      child: RenderPositionedBox(alignment: Alignment.center, child: repaintBoundary),
      configuration: ViewConfiguration(size: const Size.square(300.0), devicePixelRatio: ui.window.devicePixelRatio),
      window: WidgetsBinding.instance!.window,
    );

    final PipelineOwner pipelineOwner = PipelineOwner()..rootNode = renderView;
    renderView.prepareInitialFrame();

    final BuildOwner buildOwner = BuildOwner(focusManager: FocusManager());
    final RenderObjectToWidgetElement<RenderBox> rootElement = RenderObjectToWidgetAdapter<RenderBox>(
      container: repaintBoundary,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: IntrinsicHeight(child: IntrinsicWidth(child: widget)),
      ),
    ).attachToRenderTree(buildOwner);
    buildOwner..buildScope(rootElement)..finalizeTree();
    pipelineOwner..flushLayout()..flushCompositingBits()..flushPaint();
    return repaintBoundary.toImage(pixelRatio: ui.window.devicePixelRatio)
        .then((image) => image.toByteData(format: ui.ImageByteFormat.png))
        .then((byteData) => byteData?.buffer.asUint8List());
  }
}
