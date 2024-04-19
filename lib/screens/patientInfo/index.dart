import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorapp/models/patientListModel.dart';  // For [PatientListModel] and [getPatients()]
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GeneralPatientInformationScreen extends StatefulWidget {
  const GeneralPatientInformationScreen({super.key});

  @override
  State<GeneralPatientInformationScreen> createState() => _GeneralPatientInformationScreenState();
}

class _GeneralPatientInformationScreenState extends State<GeneralPatientInformationScreen> {
  List<PatientListModel> patients = [];  // Will hold list of all patients on Firestore
  bool isDataLoaded = false;
  int counter = 0;

  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  // [4/18] For testing
  // void resetCounter() {
  //   setState(() {
  //     counter = 0; // Set the counter back to its initial value
  //     patients.clear();
  //     print("JESUS ${patients.length}");
  //   });
  // }

  var db = FirebaseFirestore.instance;

  void getPatients() {
    db.collection("patients").get().then(  // Get all documents from the patients collection
      (querySnapshot) {
        print("SUCCESS");
        for (var docSnapshot in querySnapshot.docs) {  // For every patient in the collection
          
          // Add patient's first and last name into the List of patients
          patients.add(
            PatientListModel(
              fName: "${docSnapshot.data()['fName']}",
              lName: "${docSnapshot.data()['lName']}"
            ),
          );

          // print('${docSnapshot.id} => ${docSnapshot.data()}'); [TESTING]
          // print("FUCK ${patients.length}");
        }
        
        isDataLoaded = true;
        print(isDataLoaded);
        incrementCounter();
      },
      onError: (e) => print("ERROR"),
    );
  }

  @override 
  void initState() {
    super.initState();
    getPatients();
    print("PUSSY ${patients.length}");
  }

  @override
  // Main Render
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),  // [AppBar] at top of screen
      backgroundColor: Colors.white,
      body:Column(  // [Body] of the page
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          searchBar(),  // [Search Bar] under App Bar
          SizedBox(height: 40,),
          Column(  // [Patient List]
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 512,
                child: ListView.separated(  // Makes the list
                  itemCount: patients.length,
                  padding: EdgeInsets.only(left: 20, right: 20),
                  separatorBuilder: (context, index) => SizedBox(height: 8,),
                  itemBuilder: (context, index) {
                    return Container(
                      height: 64,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(16)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(patients[index].fName),
                          Text(patients[index].lName),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ]      
      ),
    
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: incrementCounter,
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
          SizedBox(width: 10),
          // FloatingActionButton(
          //   onPressed: resetCounter,
          //   tooltip: 'Reset',
          //   child: Icon(Icons.refresh),
          // ),
        ],
      ), // [End Body]
    );
  }

  AppBar appBar() {
    return AppBar(
      title: const Text( 'Patients',  // [title] is the the text at the top of the screen
        style: TextStyle(
          color: Colors.black,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,

      leading: GestureDetector(  // [top left] back arrow
        onTap: () {
          Navigator.pop(context);
        },
        child: Container( 
          margin: EdgeInsets.all(10),  // Set the size of the icon box
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color(0xffF7F8F8),
            borderRadius: BorderRadius.circular(10)
          ),
          child: SvgPicture.asset('assets/icons/Arrow - Left 2.svg', height: 20, width: 20,),
        ),
      ),
        
      actions: [
        GestureDetector( // [top right] dots
          onTap: () {

          } ,
          child: Container( 
            width: 37,
            margin: EdgeInsets.all(10),  // Set the size of the icon box
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(0xffF7F8F8),
              borderRadius: BorderRadius.circular(10)
            ),
            child: SvgPicture.asset('assets/icons/dots.svg', height: 5, width: 5,),
          ),
        ),
      ],
    );
  }

  Container searchBar() {
    return Container(  // [search bar]
      margin: const EdgeInsets.only(top:40, left:20, right:20),
      decoration: BoxDecoration(  // Used to add shadow to bar
        boxShadow: [
          BoxShadow(
            color: Color(0xff1D1617).withOpacity(0.11),
            blurRadius: 40,
            spreadRadius: 0.0,
          )
        ]
      ),
      child: TextField(  // [TextField] child of search bar
        decoration: InputDecoration(
          hintText: 'Search Patients',  // Placeholder text
          hintStyle: TextStyle(
            color: Color(0xffDDDADA),
            fontSize: 16,
          ),
          filled: true,                 // Fills the TextField
          fillColor: Colors.white,    // all white
          contentPadding: EdgeInsets.all(15),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12),
            child: SvgPicture.asset('assets/icons/Search.svg'),
          ),
          border:OutlineInputBorder(  
            borderRadius: BorderRadius.circular(15),  // Gives TextField a border radius
            borderSide: BorderSide.none               // Removes border
          )
        ),
      ), 
    );
  }

  // Column patientList() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Container(
  //               height: 512,
  //               child: ListView.separated(  // Makes the list
  //                 itemCount: patients.length,
  //                 padding: EdgeInsets.only(left: 20, right: 20),
  //                 separatorBuilder: (context, index) => SizedBox(height: 8,),
  //                 itemBuilder: (context, index) {
  //                   return Container(
  //                     height: 32,
  //                     decoration: BoxDecoration(
  //                       color: Colors.blue,
  //                       borderRadius: BorderRadius.circular(16)
  //                     ),
  //                     child: Column(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         Text(patients[index].fName),
  //                         Text(patients[index].lName),
  //                       ],
  //                     ),
  //                   );
  //                 },
  //               ),
  //             ),
  //           ],
  //   );
  // }
}