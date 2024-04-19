import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';




class PatientInfoScreen extends StatefulWidget {
  const PatientInfoScreen({super.key});

  static const routeName = '/patientInfo';

  @override
  State<PatientInfoScreen> createState() => _PatientInfoScreenState();
}

class _PatientInfoScreenState extends State<PatientInfoScreen> {
  var db = FirebaseFirestore.instance;
  Map<String, dynamic?> info = {};  // Will hold all patient info
  String? arg = "";                // Will hold the Doc ID of the patient pressed on patientSearch

  void setArgs(String? args) {
    arg = args;
  }

  void getPatientInfo() {
    db.collection("patients").doc(arg).get().then(  // Get all documents from the patients collection
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic?>;
        info = data;  // Store into info variable to be used outside of this block
      },
      onError: (e) => print("ERROR"),
    );
  }

  // @override 
  // void initState() {
  //   super.initState();
  //   getPatientInfo();
  //   //print("PUSSY ${patients.length}");
  // }

  @override
  Widget build(BuildContext context) {
    final String? args = ModalRoute.of(context)?.settings.arguments as String?;  // Extract the argument from patientSearch
    setArgs(args);     // Use argument to set arg, arg will be used outside of this block
    getPatientInfo();  // Fetch patient info from Firestore
  
    return Scaffold(
      appBar: appBar(),
      body: Column(
        children: [
          Text(info["fName"]),
          Text(info["mName"]),
          Text(info["lName"]),
          Text(info["dob"]),
          Text(info["bloodGroup"]),
          Text(info["RH Factor"]),
          Text(info["Marital Status"]),
          Text(info["age"]),
          Text(info["phoneResidence"]),
          Text(info["mobilePhone"]),
          Text(info["email"]),
          Text(info["eCName"]),
          Text(info["eCPhone"]),
          Text(info["currentIllnesses"]),
          Text(info["previousIllnesses"]),
          Text(info["allergies"]),
        ],
      )
    );
  }

  AppBar appBar() {
    return AppBar(
      title: const Text( 'Patient Information',  // [title] is the the text at the top of the screen
        style: TextStyle(
          color: Colors.black,
          fontSize: 24,
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
}