import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Hey!",
                style: GoogleFonts.pacifico(
                  textStyle: TextStyle(
                    fontSize: 30
                  )
                ),
              ),

              Text("User",
                style: GoogleFonts.nunito(
                  textStyle: TextStyle(
                    fontSize: 35,
                  )
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: SizedBox(
                  height: 500,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4, 
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25)
                        ),
                        width: MediaQuery.of(context).size.width/1.2,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Center(
                            child:Image.network('https://atelierdanse-albi.fr/wp-content/uploads/2015/12/ainsidanse_2016_tableau12_1ere_partie_19.jpg'),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}