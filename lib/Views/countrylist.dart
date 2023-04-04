import 'package:covid_app/Services/states_services.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'detail_Screen.dart';

class Countrylist extends StatefulWidget {
  const Countrylist({Key? key}) : super(key: key);

  @override
  State<Countrylist> createState() => _CountrylistState();
}

class _CountrylistState extends State<Countrylist> {
  StatesServices st = StatesServices();
  TextEditingController SearchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
       backgroundColor: Colors.black,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black,
          // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                onChanged: (value){
                  setState(() {

                  });
                },
                cursorColor: Colors.white,
                controller: SearchController,
                decoration: InputDecoration(
                   focusColor: Colors.lightGreen,fillColor: Colors.grey,filled: true,

                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    hintText: "Search With Country Name",
                    // hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Colors.white,

                          width: 5,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(50),
                    )),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: st.getcountrydataapi(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                    if(!snapshot.hasData){
                      return ListView.builder(
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Shimmer.fromColors(
                                baseColor: Colors.grey.shade700,
                                highlightColor:Colors.grey.shade100,
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: Container(height: 50,width: 50,color: Colors.black,),
                                    //leading: Image.network(snapshot.data![index]["countryInfo"]["flag"]),
                                    title: Container(height: 10,width: 80,color: Colors.black,),
                                    subtitle:Container(height: 10,width: 80,color: Colors.white,),
                                  )

                                ],
                              ),
                            );


                          });
                    }
                    else
                    {
                      return ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            String name = snapshot.data![index]["country"];

                            if(SearchController.text.isEmpty)
                            {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap:(){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Detials_Screen(
                                        name:snapshot.data![index]["country"],
                                        image: snapshot.data![index]["countryInfo"]["flag"],
                                        totalCases:snapshot.data![index]["cases"],
                                        totalDeaths:snapshot.data![index]["deaths"],
                                        totalRecovered:snapshot.data![index]["recovered"],
                                        todayRecovered:snapshot.data![index]["todayRecovered"],
                                        critical:snapshot.data![index]["critical"],
                                        active:snapshot.data![index]["active"],
                                        test:snapshot.data![index]["tests"],




                                      )));
                                    },
                                    child: ListTile(
                                      leading: Image(
                                          height: 50,
                                          width: 50,
                                          image: NetworkImage(snapshot.data![index]["countryInfo"]["flag"])),
                                      //leading: Image.network(snapshot.data![index]["countryInfo"]["flag"]),
                                      title: Text(snapshot.data![index]["country"],style: TextStyle(fontSize: 20,color: Colors.white),),
                                      subtitle:Text(snapshot.data![index]["cases"].toString()) ,
                                    ),
                                  )

                                ],
                              );

                            }else if(name.toLowerCase().contains(SearchController.text.toLowerCase()))
                            {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap:(){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Detials_Screen(
                                        name:snapshot.data![index]["country"],
                                        image: snapshot.data![index]["countryInfo"]["flag"],
                                        totalCases:snapshot.data![index]["cases"],
                                        totalDeaths:snapshot.data![index]["deaths"],
                                        totalRecovered:snapshot.data![index]["recovered"],
                                        todayRecovered:snapshot.data![index]["todayRecovered"],
                                        critical:snapshot.data![index]["critical"],
                                        active:snapshot.data![index]["active"],
                                        test:snapshot.data![index]["tests"],

                                      )));
                                    },
                                    child: ListTile(
                                      leading: Image(
                                          height: 50,
                                          width: 50,
                                          image: NetworkImage(snapshot.data![index]["countryInfo"]["flag"])),
                                      //leading: Image.network(snapshot.data![index]["countryInfo"]["flag"]),
                                      title: Text(snapshot.data![index]["country"],style: TextStyle(fontSize: 20,color: Colors.white),),
                                      subtitle:Text(snapshot.data![index]["cases"].toString()) ,
                                    ),
                                  )

                                ],
                              );
                            }else{
                              return Container();

                            }

                    }
                  );
                };
  }),
            ),
          ],
        ),
      ),
    );
  }
}
