// import 'package:flutter/material.dart';
// import 'package:flutter_config/flutter_config.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:location/location.dart';
//
// class NearbyHospital extends StatefulWidget {
//   NearbyHospital({super.key});
//
//   @override
//   State<NearbyHospital> createState() => _NearbyHospitalState();
// }
//
// class _NearbyHospitalState extends State<NearbyHospital> {
//   Location location = Location();
//
//   late LocationData locationData;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     locationInit();
//     super.initState();
//   }
//
//   locationInit() async {
//     locationData = await location.getLocation();
//     setState(() {
//       locationData = locationData;
//     });
//     print("latitude: ${locationData.latitude}");
//   print("longitude: ${locationData.longitude}");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: locationData.latitude !=null
//           ? Stack(
//               children: [
//                 FlutterMap(
//                   children: [
//                     TileLayer(
//                       urlTemplate:
//                           'https://api.mapbox.com/styles/v1/darpanneve/clsrfnkmz005w01qth2imfmtc/tiles/256/{z}/{x}/{y}@2x?access_token=${FlutterConfig.get('MAPBOX')}',
//                       // additionalOptions: {
//                       //   'accessToken': FlutterConfig.get('MAPBOX'),
//                       // },
//                     ),
//                   ],
//                   options: MapOptions(
//                     minZoom: 5,
//                     maxZoom: 18,
//                     initialZoom: 15.0,
//                   ),
//                   mapController: MapController(),
//                 ),
//               ],
//             )
//           : Center(
//               child: CircularProgressIndicator(),
//             ),
//     );
//   }
// }
