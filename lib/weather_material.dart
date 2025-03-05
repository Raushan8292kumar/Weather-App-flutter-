//import 'dart:ffi';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'additional_imformation_item.dart';
import 'hourly_update_weather.dart';
import 'package:http/http.dart' as http;

import 'secretfile.dart';

class WeatherMaterial extends StatefulWidget {
  const WeatherMaterial({super.key});

  @override
  State<WeatherMaterial> createState() => _WeatherMaterialState();
}

class _WeatherMaterialState extends State<WeatherMaterial> {
  // @override
  // void initState() {
  //   super.initState();
  //   getCurrentWeather();
  // }

  // double temper = 300;
  IconData iconData = Icons.cloud;

  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      String cityName = "Jaipur";
      final wdata = await http.get(
        Uri.parse(
          "https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$myApiKeyForweatherforcasting",
        ),
      );
      final forecastData = jsonDecode(wdata.body);
      if (forecastData["cod"] != "200") {
        throw forecastData["message"];
      }
      //   temper = forecastData["list"][0]["main"]["temp"];
      //   print(temper);
      //   setState(() {});
      return forecastData;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: const Text("Weather App"),
        titleTextStyle: TextStyle(
          //fontFamily: "urbanist",
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
        backgroundColor: Colors.grey,
        leading: const Icon(
          Icons.sunny,
          color: Colors.amber,
          size: 50,
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: const Icon(
              Icons.refresh,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (snapshot.hasError) {
            return Text(
              snapshot.error.toString(),
            );
          }
         // print(snapshot.data);
          //final img;
          final data = snapshot.data!;
          final weatherdata = data["list"][0];
          final currentTemp = weatherdata["main"]["temp"];
         // final icon = weatherdata["weather"][0]["icon"];
          final currentsky = weatherdata["weather"][0]["main"];
          final currenthumidity = weatherdata["main"]["humidity"];
          final currentWindSpeed = weatherdata["wind"]["speed"];
          final currentpressure = weatherdata["main"]["pressure"];
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 10.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 10,
                          sigmaY: 10,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Text(
                                "$currentTemp K",
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 18),
                              Icon(
                                currentsky == "Sunny" || currentsky == "Clear"
                                    ? Icons.sunny
                                    : Icons.cloud,
                                //Icons.thunderstorm,
                                size: 50,
                              ),
                              const SizedBox(height: 18),
                              Text(
                                "$currentsky",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 19),
                Text(
                  "Weather Forecast",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                // SizedBox(
                //   width: double.infinity,
                //   child: SingleChildScrollView(
                //     scrollDirection: Axis.horizontal,
                //     child: Row(
                //       //spacing: double.maxFinite,
                //       children: [
                //         HourUpdateWeather(
                //           time: "10:10",
                //           icon: Icons.cloud,
                //           temp: "350",
                //         ),
                //         HourUpdateWeather(
                //           time: "00:10",
                //           icon: Icons.thunderstorm,
                //           temp: "500",
                //         ),
                //         HourUpdateWeather(
                //           time: "02:10",
                //           icon: Icons.sunny,
                //           temp: "45",
                //         ),
                //         HourUpdateWeather(
                //           time: "04:10",
                //           icon: Icons.snowing,
                //           temp: "13",
                //         ),
                //         HourUpdateWeather(
                //           time: "06:10",
                //           icon: Icons.nightlight,
                //           temp: "35",
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                // using listview builder
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final hourlyTime = data["list"][index + 1]["dt_txt"];
                      final hourlytemp =
                          data["list"][index + 1]["main"]["temp"];
                      final skyType =
                          data["list"][index + 1]["weather"][0]["main"];
                      final myIcon = skyType == "rain" || skyType == "Clouds"
                          ? Icons.cloud
                          : Icons.sunny;
                      final times = DateTime.parse(hourlyTime);
                      return HourUpdateWeather(
                        time: DateFormat("Hm").format(times),
                        icon: myIcon,
                        temp: hourlytemp.toString(),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Additional Information",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      WeatherForcasting(
                        icon: Icons.water_drop,
                        lebal: "Humidity",
                        value: currenthumidity.toString(),
                      ),
                      WeatherForcasting(
                        icon: Icons.air,
                        lebal: "Wind speed",
                        value: currentWindSpeed.toString(),
                      ),
                      WeatherForcasting(
                        icon: Icons.beach_access,
                        lebal: "pressure",
                        value: currentpressure.toString(),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
