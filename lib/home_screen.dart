import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int seconds = 0; int minutes = 0; int hours = 0;
  String digitSecond = '00' ; String digitMinutes = '00' ; String digitHours = '00' ;
  Timer? timer ;
  bool started  = false;
  List laps = [];
  void stop (){
    timer!.cancel();
    setState(() {
      started = false;
    });
  }
  void reset (){
    timer!.cancel();
    setState(() {
      seconds =0 ;
      minutes=0;
      hours = 0 ;
      digitSecond = '00' ;
      digitMinutes = '00' ;
      digitHours = '00';
      started = false;
    });
  }
  void addLaps (){
    String lap = "$digitHours:$digitSecond:$digitHours";
    setState(() {
      laps.add(lap);
    });
  }
  void start (){
    started = true;
    timer = Timer.periodic(Duration(seconds : 1)  , (timer) {
  int localSecond = seconds + 1 ;
  int localMinute = minutes;
  int localHour = hours;
  if(localSecond > 59){
    if(localMinute > 59){
      localHour++;
      localMinute = 0 ;
    }else {
      localMinute++;
      localSecond =0;
    }

  }
  setState(() {
    seconds = localSecond;
    minutes = localMinute;
    hours = localHour;
digitSecond = (seconds > 10 ) ? "$seconds":"0$seconds";
    digitMinutes= (minutes > 10 ) ? "$minutes":"0$minutes";
    digitHours = (hours > 10 ) ? "$hours":"0$hours";
  });
    });
  }
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return  Scaffold(
      backgroundColor: Color(0xff1C2757),

      body: SafeArea(child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text("Stopwatch application",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold
              ),
              ),
            ),
            SizedBox(height: mediaQuery.height*.02,),
            Center(
              child: Text("$digitHours:$digitMinutes:$digitSecond", style: TextStyle(color: Colors.white , fontSize: 82, fontWeight: FontWeight.w600),)
            ),
            Container(
              height: mediaQuery.height*.4,
              decoration: BoxDecoration(
                color: Color(0xff323F68),
                borderRadius: BorderRadius.circular(8.0)

              ),
              child: ListView.builder(
                itemCount: laps.length,
                  itemBuilder: (context , index) {
                  return Padding(padding: EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Lap n°${index+1}", style:TextStyle(color:Colors.white , fontSize: 16)),
                        Text("${laps[index]}", style:TextStyle(color:Colors.white , fontSize: 16)),
                      ],
                    ),

                  );
                  }

              ),
            ),
            SizedBox(height: mediaQuery.height*.02,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: RawMaterialButton(
                  onPressed: (){
                    (!started) ? start () : stop() ;
                  },
                      shape: StadiumBorder(
                        side: BorderSide(color: Colors.blue),

                      ),
                      child: Text((!started) ? "Start" : "Pause" ,
                      style: TextStyle(
                        color: Colors.white
                      ),
                      ),
                )
                ),
                SizedBox(width: mediaQuery.width*.02,),
                IconButton(onPressed: (){
addLaps();
                }, icon: Icon(Icons.flag , color: Colors.white,)),
                Expanded(
                    child: RawMaterialButton(
                      onPressed: (){
                        reset() ;
                      },
                      fillColor: Colors.blue,
                      shape: StadiumBorder(
                        side: BorderSide(color: Colors.blue),
                      ),
                      child: Text("Reset" ,
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                    )
                ),
              ],
            )
          ],
        ),
      )
      ),
      );
  }
}
