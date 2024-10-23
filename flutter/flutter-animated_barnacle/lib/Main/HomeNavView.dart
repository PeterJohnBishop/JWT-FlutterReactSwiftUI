import 'package:flutter/material.dart';

class HomeNavComponent extends StatefulWidget {
    
    final Function(String) onUpdatePage;

  const HomeNavComponent({required this.onUpdatePage});

  @override
  State<HomeNavComponent> createState() => _HomeNavComponentState();
}

class _HomeNavComponentState extends State<HomeNavComponent> {

  String page = "home";

  @override
  Widget build(BuildContext context) {

    final Size screenSize = MediaQuery.of(context).size;

    return screenSize.height < screenSize.width ? Row(
                children: [
                  Padding(padding: const EdgeInsets.fromLTRB(0, 0, 4, 0), child: ElevatedButton(onPressed: () {
                      setState(() {
                        page = "home";
                      });
                      widget.onUpdatePage(page); 
                }, child: const Text("home"),),),
                  Padding(padding: const EdgeInsets.fromLTRB(0, 0, 4, 0), child: ElevatedButton(onPressed: () {
                      setState(() {
                        page = "about";
                      });
                      widget.onUpdatePage(page); 
                }, child: const Text("about"),),), 
                  Padding(padding: const EdgeInsets.fromLTRB(0, 0, 4, 0), child: ElevatedButton(onPressed: () {
                      setState(() {
                        page = "projects";
                      });
                      widget.onUpdatePage(page); 
                }, child: const Text("projects"),),),
                  Padding(padding: const EdgeInsets.fromLTRB(0, 0, 4, 0), child: ElevatedButton(onPressed: () {
                      setState(() {
                        page = "experience";
                      });
                      widget.onUpdatePage(page); 
                }, child: const Text("experience"),),),
                  Padding(padding: const EdgeInsets.fromLTRB(0, 0, 4, 0), child: ElevatedButton(onPressed: () {
                      setState(() {
                        page = "contact";
                      });
                      widget.onUpdatePage(page); 
                }, child: const Text("contact"),),),
                ],
    ) : Column(
      children: [
        Padding(padding: const EdgeInsets.all(8), child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(padding: const EdgeInsets.fromLTRB(0, 0, 4, 0), child: ElevatedButton(onPressed: () {
                      setState(() {
                        page = "home";
                      });
                      widget.onUpdatePage(page); 
                }, child: const Text("home"),),),
                  Padding(padding: const EdgeInsets.fromLTRB(0, 0, 4, 0), child: ElevatedButton(onPressed: () {
                      setState(() {
                        page = "about";
                      });
                      widget.onUpdatePage(page); 
                }, child: const Text("about"),),), 
                  Padding(padding: const EdgeInsets.fromLTRB(0, 0, 4, 0), child: ElevatedButton(onPressed: () {
                      setState(() {
                        page = "projects";
                      });
                      widget.onUpdatePage(page); 
                }, child: const Text("projects"),),)
          ],
        ),
        ),
         Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(padding: const EdgeInsets.fromLTRB(0, 0, 4, 0), child: ElevatedButton(onPressed: () {
                      setState(() {
                        page = "experience";
                      });
                      widget.onUpdatePage(page); 
                }, child: const Text("experience"),),),
                  Padding(padding: const EdgeInsets.fromLTRB(0, 0, 4, 0), child: ElevatedButton(onPressed: () {
                      setState(() {
                        page = "contact";
                      });
                      widget.onUpdatePage(page); 
                }, child: const Text("contact"),),)
          ],
        )
      ],
    );
  }
}