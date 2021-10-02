import 'package:flutter/material.dart';
import 'package:shopapp/models/bordingModel.dart';
import 'package:shopapp/moduels/login/login_screen.dart';
import 'package:shopapp/shared/local/componante.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  bool isLast = false;
  @override
  Widget build(BuildContext context) {
    var boardcontroller = PageController();
    List<BoardingModel> boarding = [
      BoardingModel(
        image: 'assets/images/onboard1.png',
        title: 'Screen Title 1',
        body: 'Screen Body 1',
      ),
      BoardingModel(
        image: 'assets/images/onboard3.png',
        title: 'Screen Title 2',
        body: 'Screen Body 2',
      ),
      BoardingModel(
        image: 'assets/images/onboard2.png',
        title: 'Screen Title 3',
        body: 'Screen Body 3',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LogInScreen()),
              );
            },
            child: Text(
              'SKIP',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardcontroller,
                onPageChanged: (index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) =>
                    buildOnBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardcontroller,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Colors.blue,
                    spacing: 7.0,
                    dotHeight: 12,
                    dotWidth: 12,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast == true) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LogInScreen()),
                      );
                    } else {
                      boardcontroller.nextPage(
                        duration: Duration(seconds: 1),
                        curve: Curves.decelerate,
                      );
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
