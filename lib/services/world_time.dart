import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // location name for the UI
  String? time; // the time in that location
  String flag; // url to an asset flag icon
  String url; // url to api
  String? apiUri; // uri to api provider
  String? apiResource; // resource to api resource
  String? apiQuery; // query to api query
  bool? isDaytime; // true or false if daytime or not

  WorldTime({ required this.location, required this.flag, required this.url });

  Future<void> getTime() async {

    try {
      // var uri = Uri.https('worldtimeapi.org', '/api/timezone/$url');
      var uri = Uri.parse('https://worldtimeapi.org/api/timezone/$url');
      // Response response = await get(url, headers: {"Accept": "application/json"});
      Response response = await get(uri);
      Map data = jsonDecode(response.body);

      // get properties from data
      String dateTime = data['utc_datetime'];
      String offset = data['utc_offset'].substring(1, 3);

      // create DateTime object
      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(hours: int.parse(offset)));

      // set the time property
      isDaytime = now.hour > 5 && now.hour < 18 ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch (e) {
      print('caught error: $e');
      time = 'could not get time data';
    }
    // var u
  }

}
