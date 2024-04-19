import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GeneralPatientInformationScreen extends StatelessWidget {

  //late Map data; // to hold the info retrieved from Firestore

  // // Gets the info from firestore
  // Future<void> getPatientInformation() async {
  //   var db = FirebaseFirestore.instance;  // Database
  //   final docRef = db.collection("patients").doc("111222333");
  //   docRef.get().then(
  //     (DocumentSnapshot doc) {
  //       data = doc.data() as Map<String, String>;  
  //       // ...
  //     },
  //     onError: (e) => print("Error getting document: $e"),
  //   );
  // }


  @override
  Widget build(BuildContext context) {
    // var db = FirebaseFirestore.instance;  // Database
    // final docRef = db.collection("patients").doc("111222333");
    // docRef.get().then(
    //   (DocumentSnapshot doc) {
    //     data = doc.data() as Map<String, String>;  
    //     // ...
    //   },
    //   onError: (e) => print("Error getting document: $e"),
    // );

    CollectionReference db = FirebaseFirestore.instance.collection('patients');

    return Scaffold(
      appBar: AppBar(
        title: Text( 'Patients', 
          style: TextStyle(
            color: Colors.black,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: Container( // The back arrow
          margin: EdgeInsets.all(10),  // Set the size of the icon box
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color(0xffF7F8F8),
            borderRadius: BorderRadius.circular(10)
          ),
          child: SvgPicture.asset('assets/icons/Arrow - Left 2.svg', height: 20, width: 20,),

        )
      ),

    );
      FutureBuilder<DocumentSnapshot>(
      future: db.doc("111222333").get(), 
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }
        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Text("First Name: ${data['fName']}");
        }

        return Text("loading");
      },
    );
    // return Scaffold(
    //   body: Column(
    //     children: [
    //       Text(
    //         data["fName"]
    //       )
    //     ],
    //   ),
    // );
  }


}