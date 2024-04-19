import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PatientListModel {
  String fName;
  String lName;

  PatientListModel({
    required this.fName,
    required this.lName,
  });

  // Function to get first and last name of every patient on Firestore and store them in a List
  static List<PatientListModel> getPatients() {
    List<PatientListModel> patients = [];  // an Array
    var db = FirebaseFirestore.instance;

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

          print('${docSnapshot.id} => ${docSnapshot.data()['fName']} ${docSnapshot.data()['lName']}');
        }
        print(patients[0].fName); // **TESTING**
        print(patients.length);
        return patients;
      },
      onError: (e) => print("ERROR"),
      
    );

    return patients;
    
  }
}