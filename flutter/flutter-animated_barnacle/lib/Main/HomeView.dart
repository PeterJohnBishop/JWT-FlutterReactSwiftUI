import 'package:animated_barnacle/Main/HomeNavView.dart';
import 'package:animated_barnacle/Pages/About.dart';
import 'package:animated_barnacle/Pages/HeroView.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String pageSelected = "home";

  void selectPage(String page) {
    setState(() {
    pageSelected = page;
    });
  }

  Widget displayPage() {
    switch (pageSelected) {
      case "home":
        return const HeroView();
      case "about":
        return const AboutView();
      case "projects":
        return const Text("Projects Page", style: TextStyle(fontSize: 24));
      case "experience":
        return const Text("Experience Page", style: TextStyle(fontSize: 24));
      case "contact":
        return const Text("Contact Page", style: TextStyle(fontSize: 24));
      default:
        return const Text("Unknown Page", style: TextStyle(fontSize: 24));
    }
  }


  @override
  Widget build(BuildContext context) {

    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.all(8),
            child: screenSize.height < screenSize.width ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Peter John Bishop"),
              HomeNavComponent(onUpdatePage: selectPage,),
              Text("Full Stack Developer")
            ],
          ) : Column(
            children: [
              Padding(padding: EdgeInsets.all(10), child: Text("Peter John Bishop | FULL STACK DEVELOPER"),),
              HomeNavComponent(onUpdatePage: selectPage,),
            ],
          ),
            ),
            displayPage()
        ],),
      ),
    );
  }
}