import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class Information extends StatefulWidget {
  const Information({Key? key}) : super(key: key);

  @override
  State<Information> createState() => _InformationState();
}

class _InformationState extends State<Information> {
  late PageController _pageController;
  int _pageIndex = 0;
  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      itemCount: demodata.length,
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _pageIndex = index;
                        });
                      },
                      itemBuilder: (context, index) => InformationContent(
                        image: demodata[index].image,
                        title: demodata[index].title,
                        description: demodata[index].description,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      ...List.generate(
                          demodata.length,
                          (index) => Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: Indicator(isActive: index == _pageIndex),
                              )),
                      const Spacer(),
                      SizedBox(
                        height: 60,
                        width: 60,
                        child: ElevatedButton(
                            onPressed: () {
                              _pageController.nextPage(
                                curve: Curves.ease,
                                duration: const Duration(milliseconds: 300),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                            ),
                            child: Image.asset(
                              "assets/images/arrow.png",
                              color: Colors.white,
                            )),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  const Indicator({
    Key? key,
    this.isActive = false,
  }) : super(key: key);
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: isActive ? 12 : 4,
      width: 4,
      decoration: BoxDecoration(
        color: isActive
            ? Vx.randomPrimaryColor
            : Vx.randomPrimaryColor.withOpacity(0.4),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}

class Info {
  final String image, title, description;

  Info({
    required this.image,
    required this.title,
    required this.description,
  });
}

final List<Info> demodata = [
  Info(
    image: 'assets/images/InfoScreen_jobsearch.png',
    title: "Search for the Jobs/work you've been looking for",
    description:
        'Look for any Artistic jobs that anyone posts on this app and apply directly by clicking on the job of your choice',
  ),
  Info(
    image: 'assets/images/InfoScreen_jobpost.png',
    title: 'Post any kind of work/jobs',
    description:
        'You can post any kind of Artistic work/job by going to the post section in the navigation bar and clicking on Post a Job',
  ),
  Info(
    image: 'assets/images/InfoScree_rentavail2.png',
    title:
        'Rent any Service ranging from Costumes to Studios on hourly/daily basis',
    description:
        'You can post any kind of service that you want to provide on rent by going to the post section in the navigation bar and clicking on Rent a Service',
  ),
  Info(
    image: 'assets/images/InfoScreen_rentservice.png',
    title: 'Get any kind of Service like Studios, Costumes on rent',
    description:
        'Avail any kind of Service on Rent in the Rent Section of Navigation Bar and directly click on rent now button to rent anything of your choice ',
  )
];

class InformationContent extends StatelessWidget {
  const InformationContent({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
  }) : super(key: key);

  final String image, title, description;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Image.asset(
          image,
          height: 250,
        ),
        // const Spacer(),
        const SizedBox(
          height: 40,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.nunito(
            textStyle:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        Text(
          description,
          textAlign: TextAlign.center,
          style: GoogleFonts.nunito(
            textStyle: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
        ),
        const Spacer()
      ],
    );
  }
}
