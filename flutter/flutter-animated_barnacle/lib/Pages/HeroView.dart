import 'package:flutter/material.dart';

class HeroView extends StatefulWidget {
  const HeroView({super.key});

  @override
  State<HeroView> createState() => _HeroViewState();
}

class _HeroViewState extends State<HeroView> {
  @override
  Widget build(BuildContext context) {

    final Size screenSize = MediaQuery.of(context).size;

    return 
        SizedBox(
      height: screenSize.height,
      child: Column( 
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
              child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: const AssetImage(
                                        "lib/assets/me.png"),
                                    fit: BoxFit.fitHeight,
                              ),
                            ),
              ),
                          ),
                          ],
        ),
    );
  }
}