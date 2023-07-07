
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:notes_app/Urls/urls.dart';
import 'package:notes_app/Utils/Colors.dart';
import 'package:notes_app/Utils/snackBar.dart';
import 'package:notes_app/screens/taskListScreen.dart';
import 'package:notes_app/widgets/TextFieldWidget.dart';
import 'package:notes_app/widgets/button.dart';

class AddScreen2 extends StatefulWidget {
  const AddScreen2({super.key});

  @override
  State<AddScreen2> createState() => _AddScreen2State();
}

class _AddScreen2State extends State<AddScreen2> {
     bool isLoading=false;
    final titleController=TextEditingController();
    final descriptionController=TextEditingController();
      void addTask() async{
    if(titleController.text.isNotEmpty && descriptionController.text.isNotEmpty){
      var regBody = {
        "title":titleController.text,
        "description":descriptionController.text
      };
      var response = await http.post(Uri.parse(createTaskUrl),
          headers: {"Content-Type":"application/json"},
          body: jsonEncode(regBody)
      );
      var jsonResponse = jsonDecode(response.body);
            print(jsonResponse['status']);

      if(response.statusCode==200){
        SnackBarClass().showSnackBar(context,'view task','Task added successfully',(){
            Navigator.push(context, MaterialPageRoute(builder: ((context) => TaskListScreen())));
        });
         setState(() {
         isLoading=false;
       });
        titleController.clear();
        descriptionController.clear();
      
       
       
       
        // Navigator.pop(context);
        // getTodoList(userId);
      }else{
        print("SomeThing Went Wrong");
         setState(() {
         isLoading=false;
       });
       
      }
    }
  }

 
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Padding(
            padding:  const EdgeInsets.symmetric(horizontal:20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                   Padding(
                        padding: const EdgeInsets.only(top: 7,bottom: 7,right: 30
                        ),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(onPressed: (){
                            Navigator.pop(context);
                          }, icon: Icon(Icons.arrow_back,color: Appcolor.primaryColor,size: 25,))),
                      ),
                       Align(
                        alignment: Alignment.topCenter,
                        
                        child: Lottie.network("https://assets7.lottiefiles.com/packages/lf20_h4th9ofg.json",height: 150)),
                        SizedBox(height: 20,),
                      
                 
                  Column(
                    
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     
                      TextFieldWidget(controller: titleController, hinText: 'Task Name', borderRadius: 30,maxLine: 1,),
                      const SizedBox(height: 20,),
                      TextFieldWidget(controller: descriptionController, hinText: "Task Details", borderRadius: 15, maxLine: 4),
                      SizedBox(height:20,),
            
                      ActionButton(
                 text: "Add task" ,backgroundColor: Appcolor.primaryColor,
                  textColor: Colors.white, isLoading: isLoading, onTap: () { 
                    addTask();
                  setState(() {
                   isLoading=true;

                  });



                  },) ,
                         
                     
            
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}