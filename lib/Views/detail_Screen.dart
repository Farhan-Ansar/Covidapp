import 'package:covid_app/Views/Home.dart';
import 'package:flutter/material.dart';

class Detials_Screen extends StatefulWidget {
  String image;
  String name;
  int totalCases,
      totalDeaths,
      totalRecovered,
      active,
      critical,
      todayRecovered,
      test;
  Detials_Screen(
      {required this.name,
      required this.image,
      required this.totalCases,
      required this.totalDeaths,
      required this.totalRecovered,
      required this.todayRecovered,
      required this.active,
      required this.critical,
      required this.test,
      Key? key})
      : super(key: key);

  @override
  State<Detials_Screen> createState() => _Detials_ScreenState();
}

class _Detials_ScreenState extends State<Detials_Screen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(widget.name,style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w500),),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height * .067),
                child: Card(
                  color: Colors.grey,
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * .06,),
                      ReuseableRow(title: "Cases", value: widget.totalCases.toDouble()),
                      ReuseableRow(title: "Recovered", value: widget.totalRecovered.toDouble()),
                      ReuseableRow(title: "Deaths", value: widget.totalDeaths.toDouble()),
                      ReuseableRow(title: "Today", value: widget.todayRecovered.toDouble()),
                      ReuseableRow(title: "Active", value: widget.active.toDouble()),
                      ReuseableRow(title: "Critical", value: widget.critical.toDouble()),
                      ReuseableRow(title: "Test", value: widget.test.toDouble()),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          )
        ],
      ),
    ));
  }
}
