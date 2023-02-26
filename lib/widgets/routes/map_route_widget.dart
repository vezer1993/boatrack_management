import 'package:boatrack_management/models/teltonika/TeltonikaGPS.dart';
import 'package:boatrack_management/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'dart:ui' as ui;


class WidgetRouteMap extends StatefulWidget {

  final List<TeltonikaGPS> gpsLocations;
  final double width;
  final double height;
  const WidgetRouteMap({Key? key, required this.gpsLocations, required this.width, required this.height}) : super(key: key);

  @override
  State<WidgetRouteMap> createState() => _WidgetRouteMapState();
}

class _WidgetRouteMapState extends State<WidgetRouteMap> {
  // created controller to display Google Maps
  Completer<GoogleMapController> _controller = Completer();

  //on below line we have set the camera position
  late CameraPosition _kGoogle;

  final Set<Marker> _markers = {};
  final Set<Polyline> _polyline = {};

  @override
  void initState() {
    _kGoogle = CameraPosition(
      target: widget.gpsLocations[0].latLeng,
      zoom: 12,
    );

    super.initState();
  }

  Future loadMarkers() async {
    List<LatLng> listOfCoordinates = [];

    // declared for loop for various locations
    for (int i = 0; i < widget.gpsLocations.length; i++) {
      listOfCoordinates.add(widget.gpsLocations[i].latLeng);

      if (i == 0) {

        Icon c = const Icon(Icons.location_on, color: Colors.green, size: 60,);
        var pic = await createImageFromWidget(c);

        _markers.add(
          // added markers
            Marker(
              markerId: MarkerId(i.toString()),
              position: widget.gpsLocations[i].latLeng,
              infoWindow: InfoWindow(
                title: widget.gpsLocations[i].createdAt,
                snippet: "current location",
              ),
              icon: BitmapDescriptor.fromBytes(pic),
            )
        );
      } else {
        _markers.add(
          // added markers
            Marker(
              markerId: MarkerId(i.toString()),
              position: widget.gpsLocations[i].latLeng,
              infoWindow: InfoWindow(
                title: widget.gpsLocations[i].createdAt,
              ),
              icon: BitmapDescriptor.defaultMarker,
            )
        );
      }


      _polyline.add(
          Polyline(
              polylineId: const PolylineId('1'),
              points: listOfCoordinates,
              color: Colors.red,
              width: 2
          )
      );
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadMarkers(), builder: (context, AsyncSnapshot snapshot) {
      if (snapshot.connectionState == ConnectionState.none) {
        return const Text("NO CONNECTION");
      } else if (!snapshot.hasData) {
        return const Center(child: CircularProgressIndicator());
      } else {
        return Container(
          width: widget.width,
          height: widget.height,
          child: SafeArea(
            child: GoogleMap(
//given camera position
              initialCameraPosition: _kGoogle,
// on below line we have given map type
              mapType: MapType.normal,
// specified set of markers below
              markers: _markers,
// on below line we have enabled location
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
// on below line we have enabled compass location
              compassEnabled: true,
// on below line we have added polylines
              polylines: _polyline,
// displayed google map
              onMapCreated: (GoogleMapController controller){
                _controller.complete(controller);
              },
            ),
          ),
        );
      }
    });
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