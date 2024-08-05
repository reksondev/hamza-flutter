import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:contacts_service/contacts_service.dart';
import 'dart:developer';

// ignore: must_be_immutable
class Dashboard extends StatelessWidget {
  var height, width;
  List imgSrc = [
    "assets/images/icons/gps.png",
    "assets/images/icons/sms.png",
    "assets/images/icons/call_logs.png",
    "assets/images/icons/contacts.png",
    "assets/images/icons/calendar.png",
    "assets/images/icons/passwords.png",
    "assets/images/icons/brawsers.png",
    "assets/images/icons/camera.png",
  ];

  List settingsTitles = [
    "Location",
    "Access to msg",
    "Call log",
    "Contacts",
    "Calendar",
    "Access to passwords ( on Android)",
    "Access to the browsers",
    "Access to the cameras",
  ];

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.indigo,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(),
                height: height * 0.25,
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40, left: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Icon(
                              Icons.sort,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: Colors.white,
                              image: DecorationImage(
                                  image: AssetImage("assets/images/hamza.jpg")),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        left: 30,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Children Dashboard",
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Last Login 7/31/2024",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white54,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                height: height * 0.75,
                width: width,
                padding: EdgeInsets.symmetric(vertical: 20),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.1,
                    mainAxisSpacing: 25,
                  ),
                  shrinkWrap: true,
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        if (index == 0) {
                          // Location
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LocationPage(),
                            ),
                          );
                        } else if (index == 3) {
                          // Contacts
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ContactsPage(),
                            ),
                          );
                        } else {
                          // Other actions for other indices
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              spreadRadius: 1,
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              imgSrc[index],
                              width: 100,
                            ),
                            Text(
                              settingsTitles[index],
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12, color: Color.fromARGB(255, 41, 11, 177)),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  late GoogleMapController mapController;
  LatLng _currentPosition = LatLng(0, 0);

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  Future<void> _checkLocationPermission() async {
    var status = await Permission.location.status;
    if (!status.isGranted) {
      await Permission.location.request();
    }
    if (await Permission.location.isGranted) {
      _getCurrentLocation();
    }
  }

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
    });
    mapController.animateCamera(CameraUpdate.newLatLng(_currentPosition));
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Current Location'),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _currentPosition,
          zoom: 15.0,
        ),
        myLocationEnabled: true,
      ),
    );
  }
}

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List<Contact> _contacts = [];

  @override
  void initState() {
    super.initState();
    _checkContactsPermission();
  }

  Future<void> _checkContactsPermission() async {
    var status = await Permission.contacts.status;
    if (!status.isGranted) {
      await Permission.contacts.request();
    }
    if (await Permission.contacts.isGranted) {
      _getContacts();
    }
  }

  Future<void> _getContacts() async {
    List<Contact> contacts = (await ContactsService.getContacts()).toList();
    setState(() {
      _contacts = contacts;
    });
    for (var contact in contacts) {
      log('Name: ${contact.displayName}, Phone: ${contact.phones?.map((e) => e.value).join(', ')}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      body: ListView.builder(
        itemCount: _contacts.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_contacts[index].displayName ?? 'No Name'),
            subtitle: Text(_contacts[index].phones?.map((e) => e.value).join(', ') ?? 'No Phone'),
          );
        },
      ),
    );
  }
}
