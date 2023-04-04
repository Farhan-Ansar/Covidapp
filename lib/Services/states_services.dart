import 'dart:convert';

import 'package:covid_app/Services/Utilities/app_url.dart';
import 'package:http/http.dart'as http;

import '../Model/WorldStatesModel.dart';


class StatesServices
{
  //done  api hit properly.
  Future<WorldStatesModel> getapidata() async{
    final response = await http.get(Uri.parse("https://disease.sh/v3/covid-19/all"));
    if(response.statusCode == 200){
      var data = jsonDecode(response.body.toString());
      return WorldStatesModel.fromJson(data);
    }else{
      throw Exception("Error");
    }
  }


//get countries data
  Future<List<dynamic>> getcountrydataapi() async{
    var data;
    final response = await http.get(Uri.parse(AppUrl.CountriesList));
    if(response.statusCode == 200){
      data = jsonDecode(response.body);
      return data;
    }else{
      throw Exception("Error");
    }
  }





}