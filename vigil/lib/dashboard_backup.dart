import 'package:flutter/material.dart';

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
                      padding:
                          const EdgeInsets.only(top: 40, left: 15, right: 15),
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
                  //physics: NeverScrollableScrollPhysics(),
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {},
                      child: Container(
                         margin: EdgeInsets.symmetric(vertical: 8,horizontal: 20),
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
                            Text(settingsTitles[index],
                              textAlign: TextAlign.center,
                               style: TextStyle(fontSize: 12,color: Color.fromARGB(255, 41, 11, 177)),
                            ),
                          ],
                         ),
                      ),
                    );
                  } ,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
