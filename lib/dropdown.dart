import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class DropDiwn extends StatefulWidget {
  const DropDiwn({super.key});

  @override
  State<DropDiwn> createState() => _DropDiwnState();
}

class _DropDiwnState extends State<DropDiwn> {

  TextEditingController controller=TextEditingController();
   List<String> dayList=[
    "Saturday",
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thusday",
    "Friday",
    ];

    bool displayDayList=false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: 80,
            height: 50,
            decoration: BoxDecoration(
              //border: Border.all(color: Colors.grey),
              color: Colors.blue,
              borderRadius: BorderRadius.circular(6),
            ),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
               border: InputBorder.none,
               hintText: "Day",
               hintStyle: TextStyle(fontSize: 18,color: Colors.white),
               suffixIcon: InkWell(
                onTap: (){
                  setState(() {
                    displayDayList=!displayDayList;
                  });
                },
                child: Icon(Icons.arrow_drop_down,color: Colors.white,),),  
              ),
            ),
          ),
          displayDayList?
          Container(
            height: 200,
            width: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                 color: Colors.grey, 
                 //spreadRadius: 0.5,
                 //blurRadius: 0.5,
                 //offset: Offset(0,1),
                ),
              ],
            ),
            child: ListView.builder(
              itemCount: dayList.length,
              itemBuilder: (context, index) {
              return InkWell(
                onTap: (){
                  setState(() {
                    controller.text=dayList.toString();
                  });
                },
                child: ListTile(
                  title: Text(dayList[index],style: TextStyle(fontSize: 12),),
                ),
              );
            }),
          ):Container(),
        ],
      ),
    );
  }
}