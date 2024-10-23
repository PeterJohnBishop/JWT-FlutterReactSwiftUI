import 'package:flutter/material.dart';

class AboutView extends StatefulWidget {
  const AboutView({super.key});

  @override
  State<AboutView> createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView> {

  @override
  Widget build(BuildContext context) {

    final Size screenSize = MediaQuery.of(context).size;

    return SizedBox( 
      width: screenSize.height < screenSize.width ? screenSize.width * 0.33 : screenSize.width * 0.9,
      child: const Column(
      children: [
        Padding(padding: EdgeInsets.all(8), child: Text("Hi, I'm Peter!"),),
        Padding(padding: EdgeInsets.all(8), child: Text("I'm a Colorado native holding a BBA in Economics from CUNY Baruch College and a certificate in Full Stack Web Development from the University of Denver. My diverse professional background includes work in various startups, bartending and production at a local distillery, and most recently technical roles at the project management platform ClickUp."),),
        Padding(padding: EdgeInsets.all(8), child: Text("I came out of my coursework in Full Stack Web Development with a passion for learning. From a program based heavily in the MERN stack, I've since developed a body of work that includes applications in Flutter and SwiftUI incorporating a diverse set of tools. These include projects using Swift API frameworks, GTFS-RT data, AWS S3, Ec2, Rekognition, and DynamoDB, to Firebase Authentication, Cloud Storage, Gemini AI, and many more!"),),
        Padding(padding: EdgeInsets.all(8), child: Text("Recent projects include a TOTP Authentication app using SwiftUI, a light rail train tracker in Flutter, and a Heroku deployed Node server with Socket.io websockets, Mongoose backend database, and JSON Web Token authenticated API with identical frontend user authentication examples in SwiftUI, Flutter, and React."),),
        Padding(padding: EdgeInsets.all(8), child: Text("In my current role as a Technical Support Specialist at ClickUp I'm primarily tasked with quickly triaging user identified defects, gathering logs and documenting evidence in detailed reports for our Development team to review and addresss. Since January 2023 I've held the position of API Subject Matter expert, and since April 2024 added roles as the Subject Matter Expert for Mobile and Growth features as well. I'm currently the only member of the Technical Support team that has pushed code to Production for the ClickUp mobile app! I've also collaborated with coworkers to build a private Chrome extension used to gather user data and trace logs for bug reporting. My primary contribution was in supplying code for OAuth authentication, access to private API endpoints, and a Typescript compatible Node server."),),
      ],
      ),
    );
  }
}