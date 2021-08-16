import 'package:flutter/material.dart';
class AboutApp extends StatefulWidget {
  @override
  _AboutAppState createState() => _AboutAppState();
}

class _AboutAppState extends State<AboutApp> {
  Widget sizeB(){
    return SizedBox(height: 10,);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("About the App",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                sizeB(),
                Text("With Metis; someone to talk to, someone to listen and to help will always be at your fingertips. Just open the app and within seconds a therapist or counsellor can be there for you and ready to help."),
                sizeB(),
                Text("Talk to a counsellor or therapist from almost anywhere you are. Get help any time day or night; at home, at school or in the office. The Metis app is a great way to always feel your best and to know that you are not alone. Find a new therapist or counsellor or reconnect with one who you’ve talked to before the choice is yours. No need to wait for months to see a specialist or be left with a limited choice. Find the therapist or counsellor who meets your needs most precisely and can understand you best."),
                sizeB(),
                Text("Metis can help you find the ideal professional to fit your needs; Anxiety, Depression, Abuse, Anger Problems, Conduct Disorders, Developmental Disorders, Dissociation, Eating Disorders, Family Problems, Grief, Identity, Mood Disorders, Obsessive-Compulsive Disorder, Parenting Issues, Personality Disorders, Phobias, Post-Traumatic Stress Disorder (PTSD), Self-Esteem, Self Harm, Sleep Problems, Stress, Thanatophobia, Trauma and Workplace Stress."),
                sizeB(),
                Text("All these options and more are available in one place with the Metis app."),
                sizeB(),
                Text("See price estimates, with Metis you can see price estimates upfront before booking. You’ll know what it’s going to cost you and what the options are as you choose between different therapists and counsellors."),
                sizeB(),
                Text("You can also check for copies of counsellor or therapist qualifications which will be available for you to look at as well as reviews from past clients."),
                sizeB(),
                Text("Rate your therapist or counsellor after every consultation. You can submit an anonymous rating along with comments and you can also let your counsellor or therapist know you appreciated the experience."),
                sizeB(),
                Text("Not sure exactly what you need? Want to talk in general to the therapist to find out more in an introductory session? Haven’t got a suitable place to talk? Metis experts totally get it.")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
