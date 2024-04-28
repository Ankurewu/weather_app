import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/consts/consts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherFactory _weatherFactory= WeatherFactory(Open_weather_api_key);
  
  Weather? weather;

  @override
  void initState() {
    super.initState();
    _weatherFactory.currentWeatherByCityName('Dhaka').then((w){
      setState(() {
        weather=w;
      });
    });
  }
  Widget locationname(){
    return Text(weather?.areaName??"",
    style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
    );
  }
  Widget datatimeInfo(){
    DateTime now= weather!.date!;
    return Column(
      children: [
        Text(DateFormat("h:mm ").format(DateTime.now()),
        style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
        ),
      //  const SizedBox(height: 5,),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             Text(DateFormat("EEEE").format(DateTime.now()),
        style: TextStyle(fontSize: 25,fontWeight: FontWeight.normal),
        ),
        SizedBox(width: 10,),
         Text("${DateFormat('d.m.y').format(now)}",
        style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),
        ),
          ],
        )
      ],
    );
  }
  Widget weatherIcon(){
    return Column(
       mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height*0.20,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image:
                   NetworkImage("http://openwethermap.org/img/w/${weather?.weatherIcon}@4x.png")),
              ),
            ),
            Text("${weather?.weatherDescription??""}",
            style: TextStyle(fontSize: 30,fontWeight: FontWeight.w400),)
           
          ],
          
    );
  }
  Widget currentTemp(){
    return Text("${weather?.temperature!.celsius!.toStringAsFixed(0)}° C",
     style: TextStyle(fontSize: 32,fontWeight: FontWeight.w800)
    );
  }

  Widget extraInfo(){
    return Container(
      height: MediaQuery.sizeOf(context).height*0.15,
      width: MediaQuery.sizeOf(context).width*0.80,
      decoration: BoxDecoration(
        color: Colors.deepPurpleAccent,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Max: ${weather?.tempMax?.celsius!.toStringAsFixed(0)}° C",
            style: TextStyle(fontSize: 15,color: Colors.white)
            ),
             Text("Min: ${weather?.tempMin?.celsius!.toStringAsFixed(0)}° C",
            style: TextStyle(fontSize: 15,color: Colors.white)
            )
          ],
        ),
           Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Air speed: ${weather?.windSpeed?.toStringAsFixed(0)} m/s",
            style: TextStyle(fontSize: 15,color: Colors.white)
            ),
             Text("Humidity: ${weather?.humidity?.toStringAsFixed(0)}%",
            style: TextStyle(fontSize: 15,color: Colors.white)
            )
            
          ],
        ),
           Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Feels like: ${weather?.tempFeelsLike?.celsius!.toStringAsFixed(0)}° C",
            style: TextStyle(fontSize: 15,color: Colors.white)
            ),
             Text("Pressure: ${weather?.pressure!.toStringAsFixed(0)} atm",
            style: TextStyle(fontSize: 15,color: Colors.white)
            )
          ],
        ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
     print('http://openwethermap.org/img/wn/${weather?.weatherIcon}@4x.png');
    Widget buildUi(){
      if (weather==null) {
        return const Center(child: CircularProgressIndicator(),);
      }
      return SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height:MediaQuery.sizeOf(context).height,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            locationname(),
            SizedBox(height:MediaQuery.sizeOf(context).height*0.02,),
            datatimeInfo(),
             SizedBox(height:MediaQuery.sizeOf(context).height*0.30,),
             weatherIcon(),
              SizedBox(height:MediaQuery.sizeOf(context).height*0.02,),
              currentTemp(),
               SizedBox(height:MediaQuery.sizeOf(context).height*0.02,),
               extraInfo(),
          ],
        ),
      );
    }
    return Scaffold(
       body: buildUi(),
    );
  }
}