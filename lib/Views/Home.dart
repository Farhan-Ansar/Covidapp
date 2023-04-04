import 'package:covid_app/Model/WorldStatesModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import '../Services/states_services.dart';
import 'countrylist.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  StatesServices st = StatesServices();
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 5), vsync: this)
        ..repeat();

  void dispose() {
    super.dispose();
    _controller.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final Colorlist = <Color>[
    const Color(0xff4285f4),
    const Color(0xff1aa260),
    const Color(0xffde5246)
  ];

  @override
  Widget build(BuildContext context) {


    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .02,
              ),
              // Container(
              //   child: InkWell(
              //     onTap: () async{
              //       await st.getapidata();
              //     },
              //     child: Text("get data", style: TextStyle(
              //       color: Colors.red
              //     ),),
              //   ),
              // ),

              FutureBuilder(
                future: st.getapidata(),
                  builder: (context,AsyncSnapshot<WorldStatesModel> snapshot) {
                if (!snapshot.hasData) {
                  return Expanded(
                    flex: 1,
                    child: SpinKitFadingCircle(
                      size: 50.0,
                      color: Colors.white,
                      controller: _controller,
                    ),
                  );
                } else {
                  return Column(
                    children: [
                      PieChart(
                        dataMap: {
                          "Total": double.parse(snapshot.data!.cases!.toString()),
                          "Recovered": double.parse(snapshot.data!.recovered.toString()),
                          "Deaths":double.parse(snapshot.data!.deaths.toString()),
                        },
                        chartValuesOptions: const ChartValuesOptions(
                          showChartValuesInPercentage: true,
                        ),
                        chartRadius: MediaQuery.of(context).size.width / 3.2,
                        legendOptions: const LegendOptions(
                            legendPosition: LegendPosition.left,
                            legendTextStyle: TextStyle(color: Colors.white)),
                        animationDuration: const Duration(milliseconds: 1200),
                        chartType: ChartType.ring,
                        colorList: const [
                          Color(0xff4285f4),
                          Color(0xff1aa260),
                          Color(0xffde5246)
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.width * .05),
                        child: Card(
                          color: Colors.grey,
                          child: Column(
                            children: [
                              ReuseableRow(
                                title: "Total",
                                value:snapshot.data!.cases!.toDouble(),
                              ),
                              ReuseableRow(title: "Recovered", value:snapshot.data!.recovered!.toDouble()),

                              ReuseableRow(title: "Deaths", value: snapshot.data!.deaths!.toDouble()),

                              ReuseableRow(title: "Active", value: snapshot.data!.active!.toDouble()),

                              ReuseableRow(title: "Critical", value: snapshot.data!.critical!.toDouble()),

                              ReuseableRow(title: "Today deaths", value: snapshot.data!.todayDeaths!.toDouble()),

                              ReuseableRow(title: "Today Recovered", value: snapshot.data!.todayRecovered!.toDouble()),

                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap:(){

                          Navigator.push(context, MaterialPageRoute(builder: (context)=> Countrylist()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xff1aa260),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 55,
                          width: MediaQuery.of(context).size.width,
                          child: const Center(
                            child: Text(
                              "Track Countries",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              }),


            ],
          ),
        ),
      ),
    );
  }
}

class ReuseableRow extends StatelessWidget {
  String title; double value;
  ReuseableRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(color: Colors.white),
              ),
              Text(
                "${value}",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Divider(),
      ],
    );
  }
}
