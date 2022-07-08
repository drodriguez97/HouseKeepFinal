import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
 
 MaterialColor white = const MaterialColor(
  0xFFFFFFFF,
   <int, Color>{
    50:  Color(0xFFFFFFFF),
    100:  Color(0xFFFFFFFF),
    200:  Color(0xFFFFFFFF),
    300:  Color(0xFFFFFFFF),
    400:  Color(0xFFFFFFFF),
    500:  Color(0xFFFFFFFF),
    600:  Color(0xFFFFFFFF),
    700:  Color(0xFFFFFFFF),
    800:  Color(0xFFFFFFFF),
    900:  Color(0xFFFFFFFF),
  },
);


class FAQPage extends StatelessWidget {
  @override
  
  Widget build(BuildContext context) => Scaffold(

    body: ExpandableTheme(
        data: const ExpandableThemeData(
          iconColor: Colors.blue,
          useInkWell: true,
        ),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: <Widget>[
            Card1(),
            Card2(),
          ],
        ),
      ),
    );
}
const wifiHelp = "Help Guests Login to CPPGuest!";
const wifiQuestion = """
Step 1: Have the user to their WiFi settings on their device and select the 'CPPGuest' network.

Step 2: Once the guest connects, they should be redirected to a page where it you'll see a button asking to 'Obtain Acess Code'

Step 3: The guest will enter their phone number then press 'Submit', an access code will then be sent to their mobile device.

Step 4: Once the guest enters their unique access code, they gain access to CPPGuest for 24 hours. They will need to log back in daily.
""";


class Card1 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 150,
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  image: DecorationImage(image: AssetImage('assets/wifi.jpg'),
                  fit: BoxFit.contain,
                  )
                  
                ),
              ),
            ),
            ScrollOnExpand(
              scrollOnExpand: true,
              scrollOnCollapse: false,
              child: ExpandablePanel(
                theme: const ExpandableThemeData(
                  iconColor: Colors.blue,
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToCollapse: true,
                
                ),
                header: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "CPPGuest Wifi Troubleshooting",
                      style: Theme.of(context).textTheme.bodyText1,
                    )),
                collapsed: const Text(
                  wifiHelp,
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                expanded: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    for (var _ in Iterable.generate(1))
                      const Padding(
                          padding: EdgeInsets.only(bottom: 0),
                          child: Text(
                            wifiQuestion,
                            softWrap: true,
                            overflow: TextOverflow.fade,
                          )),
                  ],
                ),
                builder: (_, collapsed, expanded) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: Expandable(
                      collapsed: collapsed,
                      expanded: expanded,
                      theme: const ExpandableThemeData(crossFadePoint: 0),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
const locationHelp = " When Guests Ask About Building Locations";

const buildingDesc = """You can find the location of the MPR and Center Pointe buildings here.

 MPR Building 52: It's attahced to the Vista Market.

 MPR Building 72: Across the way from building 54.

 Center Pointe: Right nextdoor to building 72 and building 54. Red building with metal panels.

 Link to Campus Map:  https://www.cpp.edu/maps/""";

class Card2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 150,
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.lightGreen,
                  image: DecorationImage(image: AssetImage('assets/mpr.jpg'))
                ),
              ),
            ),
            ScrollOnExpand(
              scrollOnExpand: true,
              scrollOnCollapse: false,
              child: ExpandablePanel(
                theme: const ExpandableThemeData(
                  iconColor: Colors.lightGreen,
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToCollapse: true,
                
                ),
                header: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "MPR Building Locations",
                      style: Theme.of(context).textTheme.bodyText1,
                    )),
                collapsed: const Text(
                  locationHelp,
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                expanded: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    for (var _ in Iterable.generate(1))
                      const Padding(
                          padding: EdgeInsets.only(bottom: 0),
                          child: Text(
                            buildingDesc,
                            softWrap: true,
                            overflow: TextOverflow.fade,
                          )),
                  ],
                ),
                builder: (_, collapsed, expanded) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: Expandable(
                      collapsed: collapsed,
                      expanded: expanded,
                      theme: const ExpandableThemeData(crossFadePoint: 0),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

   
