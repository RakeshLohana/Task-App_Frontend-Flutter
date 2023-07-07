import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:notes_app/Utils/Colors.dart';
import 'package:notes_app/screens/addScreen2.dart';
import 'package:notes_app/screens/taskListScreen.dart';
import 'package:notes_app/widgets/button.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
   HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body:Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical:60 ,),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    
                    children: [
                       Text("Streamline Your Tasks",style: TextStyle(fontFamily: "AlegreyaSans",fontSize: 36,fontWeight: FontWeight.bold,color: Appcolor.primaryColor)),
                        Text("Simplify Your Life",style: TextStyle(fontFamily: "AlegreyaSans",fontSize: 27,fontWeight: FontWeight.bold,color: Appcolor.smallTextColor),),
                        
                    ],
                                 
                                 ),
                                 SizedBox(height: 10,),
                  
                    Lottie.asset("assets/1.json",),
                   
                    ActionButton(backgroundColor:Appcolor.primaryColor, textColor: Colors.white, text: 'Add task', isLoading: false, onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: ((context) => AddScreen2())));
                      } ,),
              
                    ActionButton(backgroundColor:Colors.grey.shade200, textColor: Appcolor.smallTextColor, text: 'View all', isLoading: false, onTap: () { 
                        Navigator.push(context, MaterialPageRoute(builder: ((context) => TaskListScreen())));
                     }, )
                    
                    
                  ],
                ),
              ),
            )
          ],
        ),
        
      ),
    );
  }

}