import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:admob_flutter/admob_flutter.dart';

String _appid = "ca-app-pub-1577485202493071~9154466604";
String _idbanner = "ca-app-pub-1577485202493071/9244066135";
String _idintertitial = "ca-app-pub-1577485202493071/6145994033";

void main() {
  Admob.initialize(_appid);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AdmobInterstitial interstitialAd;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0, top: 50),
              child: Text("Tutorial Admob Flutter"),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 150.0, top: 50),
              child: new RaisedButton(
                padding: const EdgeInsets.all(8.0),
                textColor: Colors.white,
                color: Colors.blue,
                onPressed: () {
                  interstitialAd.show();
                },
                child: new Text("Show Intertitial Ads"),
              ),
            ),
            // Container(
            //   child: new FlutterMap(
            //       options: new MapOptions(
            //           center: new LatLng(0.021501, -51.062025), minZoom: 10.0),
            //       layers: [
            //         new TileLayerOptions(
            //             urlTemplate:
            //                 "mapbox://styles/supremoxv/ckjbchj655qu419lathei8a9n",
            //             additionalOptions: {
            //               'accessToken':
            //                   'pk.eyJ1Ijoic3VwcmVtb3h2IiwiYSI6ImNrYnF0djNuNjBseWkyb2thcmp2OHVweXIifQ.JrjNXI6yjodG6aTnOAbN7g',
            //               'id': 'mapbox.mapbox-streets-v8'
            //             }),
            //         new MarkerLayerOptions(markers: [
            //           new Marker(
            //               width: 45.0,
            //               height: 45.0,
            //               point: new LatLng(0.021501, -51.062025),
            //               builder: (context) => new Container(
            //                     child: IconButton(
            //                       icon: Icon(Icons.location_on),
            //                       color: Colors.red,
            //                       iconSize: 45.0,
            //                       onPressed: () {
            //                         Scaffold.of(context).showBottomSheet<void>(
            //                           (BuildContext context) {
            //                             return Container(
            //                               height: 200,
            //                               color: Color(0xFF448AFF),
            //                               child: Center(
            //                                 child: Column(
            //                                   mainAxisAlignment:
            //                                       MainAxisAlignment.center,
            //                                   mainAxisSize: MainAxisSize.min,
            //                                   children: <Widget>[
            //                                     const Text('Cunha & Tavares'),
            //                                     RaisedButton(
            //                                         child: const Text(
            //                                             'Close BottomSheet'),
            //                                         onPressed: () async {
            //                                           if (await interstitialAd
            //                                               .isLoaded) {
            //                                             interstitialAd.show();
            //                                           } else {
            //                                             print(
            //                                                 "######### Interstitial ad is still loading... ###########");
            //                                           }
            //                                           Navigator.pop(context);
            //                                         })
            //                                   ],
            //                                 ),
            //                               ),
            //                             );
            //                           },
            //                         );
            //                       },
            //                     ),
            //                   )),
            //           new Marker(
            //               width: 45.0,
            //               height: 45.0,
            //               point: new LatLng(0.018403, -51.083868),
            //               builder: (context) => new Container(
            //                     child: IconButton(
            //                       icon: Icon(Icons.location_on),
            //                       color: Colors.red,
            //                       iconSize: 45.0,
            //                       onPressed: () {
            //                         Scaffold.of(context).showBottomSheet<void>(
            //                           (BuildContext context) {
            //                             return Container(
            //                               height: 200,
            //                               color: Colors.amber,
            //                               child: Center(
            //                                 child: Column(
            //                                   mainAxisAlignment:
            //                                       MainAxisAlignment.center,
            //                                   mainAxisSize: MainAxisSize.min,
            //                                   children: <Widget>[
            //                                     const Text('My House'),
            //                                     RaisedButton(
            //                                       child: const Text(
            //                                           'Close BottomSheet'),
            //                                       onPressed: () =>
            //                                           Navigator.pop(context),
            //                                     )
            //                                   ],
            //                                 ),
            //                               ),
            //                             );
            //                           },
            //                         );
            //                       },
            //                     ),
            //                   )),
            //         ])
            //       ]),
            // ),
            Align(
              alignment: Alignment.bottomCenter,
              child: AdmobBanner(
                adUnitId: _idbanner,
                adSize: AdmobBannerSize.BANNER,
                listener: (AdmobAdEvent event, Map<String, dynamic> args) {
                  handleEvent(event, args, 'Banner');
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    interstitialAd = AdmobInterstitial(
      adUnitId: _idintertitial,
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        if (event == AdmobAdEvent.closed) interstitialAd.load();
        handleEvent(event, args, 'Interstitial');
      },
    );
    interstitialAd.load();
  }

  void handleEvent(
      AdmobAdEvent event, Map<String, dynamic> args, String adType) {
    switch (event) {
      case AdmobAdEvent.loaded:
        //showSnackBar('New Admob $adType Ad loaded!');
        break;
      case AdmobAdEvent.opened:
        //showSnackBar('Admob $adType Ad opened!');
        break;
      case AdmobAdEvent.closed:
        print("Goto next page");
        break;
      case AdmobAdEvent.failedToLoad:
        //print("Goto next page");
        break;
      case AdmobAdEvent.rewarded:
        break;
      default:
    }
  }
}
