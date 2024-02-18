import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_map/flutter_map.dart';

class NearbyHospital extends StatelessWidget {
  const NearbyHospital({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            children: [
              TileLayer(
                urlTemplate:
                    'https://api.mapbox.com/styles/v1/darpanneve/clsrfnkmz005w01qth2imfmtc/wmts?access_token=${FlutterConfig.get('MAPBOX')}',
                // additionalOptions: {
                //   'accessToken': FlutterConfig.get('MAPBOX'),
                  // 'id': 'mapbox/streets-v11',
                // },
              ),
            ],
            options: MapOptions(
              minZoom: 5,
              maxZoom: 18,
              initialZoom: 15.0,
            ),
            mapController: MapController(),
          ),
        ],
      ),
    );
  }
}
