import 'package:artist_icon/screens/signIn.dart';
import 'package:artist_icon/screens/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'widgets/category_card.dart';

class Artistpage extends StatelessWidget {
  const Artistpage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size; //this gonna give us total height and with of our device
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            // Here the height of the container is 45% of our total height
            height: size.height * .45,
            decoration: const BoxDecoration(
              color: Color(0xFFF5CEB8),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      alignment: Alignment.center,
                      height: 52,
                      width: 52,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF2BEA1),
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset("assets/images/dancing.svg"),
                    ),
                  ),
                  const Text(
                    "Welcome \nUser",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SearchBar(),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: .85,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: <Widget>[
                        CategoryCard(
                          title: "Dance",
                          svgSrc: "assets/images/dancing.svg",
                          press: () {},
                        ),
                        CategoryCard(
                          title: "Singing",
                          svgSrc: "assets/images/drummer.svg",
                          press: () {},
                        ),
                        CategoryCard(
                          title: "Costumes",
                          svgSrc: "assets/images/costume.svg",
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return SignInPage();
                              }),
                            );
                          },
                        ),
                        CategoryCard(
                          title: "Studios",
                          svgSrc: "assets/images/shop.svg",
                          press: () {},
                        ),
                        CategoryCard(
                          title: "Photography",
                          svgSrc: "assets/images/camera.svg",
                          press: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
