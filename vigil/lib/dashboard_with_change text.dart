import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/* void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Dashboard(),
    );
  }
} */

abstract class DashboardPage extends StatelessWidget {
  String get title;
  String get icon;
}

// ignore: must_be_immutable
class Dashboard extends StatelessWidget {
  var height, width;
  List<DashboardPage> pages = [
    LocationPage(),
    AccessToMsgPage(),
    CallLogPage(),
    ContactsPage(),
    CalendarPage(),
    AccessToPasswordsPage(),
    AccessToBrowsersPage(),
    AccessToCamerasPage(),
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
                  itemCount: pages.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => pages[index],
                          ),
                        );
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
                              pages[index].icon,
                              width: 100,
                            ),
                            Text(
                              pages[index].title,
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

class LocationPage extends StatelessWidget implements DashboardPage {
  @override
  String get title => "Location";

  @override
  String get icon => "assets/images/icons/gps.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text('Details for $title'),
      ),
    );
  }
}

class AccessToMsgPage extends StatelessWidget implements DashboardPage {
  @override
  String get title => "Access to msg";

  @override
  String get icon => "assets/images/icons/sms.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text('Details for $title'),
      ),
    );
  }
}

class CallLogPage extends StatelessWidget implements DashboardPage {
  @override
  String get title => "Call log";

  @override
  String get icon => "assets/images/icons/call_logs.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text('Details for $title'),
      ),
    );
  }
}

class ContactsPage extends StatelessWidget implements DashboardPage {
  @override
  String get title => "Contacts";

  @override
  String get icon => "assets/images/icons/contacts.png";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => Model(),child: Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Consumer<Model>(builder: (context, model, child) {
        return Column(
        children: [
          Container(
            child: Column(
              children: [
                Center(child: Text(" ${model.title} ")),
                SizedBox(height: 100),
                MaterialButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(color: Colors.blue, width: 2.0),
              ),
                  onPressed: () => {
                    model.changetName(),
                    print("developer name hamza do ${model.title} is clicked"),
                  },
                  child: Text('Enable Contacts Permession'),
                  ),
              ],
            ),
            ),
        ],
      );
      }
      ),
    ),);
  }
}

class Model extends ChangeNotifier{
  String title = "The Contact Permession is Disabled";
  changetName(){
    title = 'The Contact Permession is Enabled';
    notifyListeners();
  }
}

class CalendarPage extends StatelessWidget implements DashboardPage {
  @override
  String get title => "Calendar";

  @override
  String get icon => "assets/images/icons/calendar.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text('Details for $title'),
      ),
    );
  }
}

class AccessToPasswordsPage extends StatelessWidget implements DashboardPage {
  @override
  String get title => "Access to passwords (on Android)";

  @override
  String get icon => "assets/images/icons/passwords.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text('Details for $title'),
      ),
    );
  }
}

class AccessToBrowsersPage extends StatelessWidget implements DashboardPage {
  @override
  String get title => "Access to the browsers";

  @override
  String get icon => "assets/images/icons/brawsers.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: [
          Container(
            child: Text('Details for $title'),

          ),
        ],
      ),
    );
  }
}

class AccessToCamerasPage extends StatelessWidget implements DashboardPage {
  @override
  String get title => "Access to the cameras";

  @override
  String get icon => "assets/images/icons/camera.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text('Details for $title'),
      ),
    );
  }
}
