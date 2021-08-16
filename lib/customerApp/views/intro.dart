import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban/constants.dart';
import 'package:urban/customerApp/components/intro_items.dart';
import 'package:urban/customerApp/views/login_signup.dart';
import 'package:urban/services/sign_in_sign_up.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<SignInSignUpProvider>(context);
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: Stack(
        children: [
          CarouselSlider(
              items: [
                IntroItem(
                    currentPage,
                    Icons.ac_unit,
                    "Book time with a qualified mental health therapist for sessions including Anxiety, Depression, Abuse, Anger Problems, Conduct Disorders, Developmental Disorders, Dissociation, Eating Disorders, Family Problems, Grief, Identity, Mood Disorders, Obsessive Compulsive Disorder, Parenting Issues, Personality Disorders, Phobias, Post-Traumatic Stress Disorder (PTSD), Self-Esteem, Self Harm, Sleep Problems, Stress, Thanatophobia, Trauma and Workplace Stress.",
                    "See a therapist on-demand",
                    page1Color,
                    Colors.white,
                    Colors.white,
                ),
                IntroItem(
                    currentPage,
                    Icons.ac_unit,
                    "All sessions are online, Metis experts are available around the clock anywhere where you have a smartphone, tablet or computer",
                    "You pick the time and therapist",
                    page2Color,
                  Colors.white,
                  Colors.white,
                ),
                IntroItem(
                    currentPage,
                    Icons.ac_unit,
                    "View individual profiles for ratings, session counts and more to find the right pre-vetted expert for you",
                    "Vetted Professionals",
                    page3Color,
                  Colors.black,
                  Colors.black,),
                //  IntroItem(currentPage,Icons.ac_unit,"Book time with a qualified wellness pro for sessions in fitness, beauty,physical wellbeing and more","Qualified Providers",Colors.purpleAccent),
                LoginSignUp()
              ],
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height,
                initialPage: currentPage,
                onPageChanged: (ind, d) {
                  if (ind == 3) {
                    prov.getFCMToken();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginSignUp()));
                  }
                  print(ind);
                  setState(() {
                    currentPage = ind;
                  });
                },
                // aspectRatio: 16/16,
                enableInfiniteScroll: true,
                reverse: false,
                viewportFraction: 1.0,
                aspectRatio: 1.0,
                scrollDirection: Axis.horizontal,
              )),
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0, left: 15, right: 15),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.circle,
                            color:
                                currentPage == 0 ? Colors.white : Colors.grey,
                            size: 10,
                          ),
                          Icon(
                            Icons.circle,
                            color:
                                currentPage == 1 ? Colors.white : Colors.grey,
                            size: 10,
                          ),
                          Icon(
                            Icons.circle,
                            color:
                                currentPage == 2 ? Colors.black : Colors.grey,
                            size: 10,
                          ),
                          Icon(
                            Icons.circle,
                            color:
                                currentPage == 3 ? Colors.white : Colors.grey,
                            size: 10,
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        prov.getFCMToken();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginSignUp()));
                      },
                      child: Text(
                        "Skip",
                        style: TextStyle(color: currentPage == 2 ? Colors.black : Colors.white),
                      ),
                    )
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
