// import 'dart:convert';
// import 'package:notes_app/Urls/urls.dart';
// import 'package:notes_app/Utils/snackBar.dart';
// import 'package:http/http.dart';

// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:notes_app/Utils/Colors.dart';
// import 'package:notes_app/widgets/TextFieldWidget.dart';
// import 'package:notes_app/widgets/button.dart';

// class AddScreen extends StatefulWidget {
//   const AddScreen({super.key});

//   @override
//   State<AddScreen> createState() => _AddScreenState();
// }

// class _AddScreenState extends State<AddScreen> {
 
//     List? items;

    
//    void initState() {
//     // TODO: implement initState
//     super.initState();
   

//     // getTaskList(id);
//   }

 
//   final titleController=TextEditingController();
//     final descriptionController=TextEditingController();

//     void addTask(String title ,String description) async{
//     if(titleController.text.isNotEmpty && descriptionController.text.isNotEmpty){
//       // var regBody = {

//       //   "title":taskNamecontroller.text,
//       //   "content":taskdetailcontroller.text
//       // };
//       try{
//          Response response = await post( 
//           Uri.parse(addTaskUrl),
//           body:{
//             "title":titleController,
//             "description":descriptionController
//           }
//           );
//            if (response.statusCode == 200) {
//             print('Task posted successfully');
    
//     } else {
//       print("Request failed with status: ${response.statusCode}");
//     }


//       }catch{


//       }

    
        
//       var jsonResponse = jsonDecode(response.body);
//       print(jsonResponse['status']);
//       if(jsonResponse['status']){ 
//         taskdetailcontroller.clear();
//         taskNamecontroller.clear();
       
//         setState(() {
//              getTaskList("001");
          
//            isLoading=false;

//         });
        
//     SnackBarClass().showSnackBar(context);
  
//     //  getTodoList(Uuid().v1());
//        }
//       else{
//         print("SomeThing Went Wrong");
//       }
//     }
//   }
//   void getTaskList(id) async {
//   var regBody = {
//     "id": id
//   };
//   try {
//     var response = await http.post(
//       Uri.parse(getTaskUrl),
//       headers: {"Content-Type": "application/json"},
//       body: jsonEncode(regBody),
//     );
//     if (response.statusCode == 200) {
//       var jsonResponse = jsonDecode(response.body);
//       print(jsonResponse['status']);
//       items = jsonResponse['success'];
//       setState(() {
//         // Update your state variables here
//       });
//     } else {
//       print("Request failed with status: ${response.statusCode}");
//     }
//   } catch (error) {
//     print("Error occurred: $error");
//   }
// }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: SingleChildScrollView(
//           child: Container(
//             child: Padding(
//               padding:  const EdgeInsets.symmetric(horizontal:20.0),
//               child: Column(
//                 children: [
//                    Padding(
//                         padding: const EdgeInsets.only(top: 7,bottom: 7,right: 30
//                         ),
//                         child: Align(
//                           alignment: Alignment.topLeft,
//                           child: IconButton(onPressed: (){
//                             Navigator.pop(context);
//                           }, icon: Icon(Icons.arrow_back,color: Appcolor.primaryColor,size: 25,))),
//                       ),
//                        Align(
//                         alignment: Alignment.topCenter,
                        
//                         child: Lottie.network("https://assets1.lottiefiles.com/packages/lf20_h4th9ofg.json",height: 150)),
//                         SizedBox(height: 20,),
                      
                 
//                   Column(
                    
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
                     
//                       TextFieldWidget(controller: titleController, hinText: 'Task Name', borderRadius: 30,maxLine: 1,),
//                       const SizedBox(height: 20,),
//                       TextFieldWidget(controller: descriptionController, hinText: "Task Details", borderRadius: 15, maxLine: 4),
//                       SizedBox(height:20,),
            
//                       InkWell(
//                         onTap: (){
//                           addTask(titleController.toString(),descriptionController.toString());
//                           setState(() {
//                             isLoading=true;
//                           });
//                         },
//                         child: ActionButton(
//                  text: "Add task" ,backgroundColor: Appcolor.primaryColor, textColor: Colors.white, isLoading: isLoading,)) ,
//                  Padding(
//                    padding: const EdgeInsets.all(8.0),
//                    child: items==null?null:ListView.builder(
//                     itemCount: items!.length,
//                     itemBuilder: (context,index){
//                     return Container(
//                       child: items?[index]["title"],
//                     );
//                    }),
//                  )             
                     
            
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


