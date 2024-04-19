import 'package:doctorapp/models/patientListModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:doctorapp/screens/patientSearch/index.dart';



class PatientInfoScreen extends StatefulWidget {
  const PatientInfoScreen({super.key});

  static const routeName = '/patientInfo';

  @override
  State<PatientInfoScreen> createState() => _PatientInfoScreenState();
}

class _PatientInfoScreenState extends State<PatientInfoScreen> {
  @override
  Widget build(BuildContext context) {
    final String? args = ModalRoute.of(context)?.settings.arguments as String?;
    print("FUCK ${args}");

    return Scaffold(
      appBar: appBar(),
      body: Center(child: Text("${args}"),)
    );
  }

  AppBar appBar() {
    return AppBar(
      title: const Text( 'Patient Info',  // [title] is the the text at the top of the screen
        style: TextStyle(
          color: Colors.black,
          fontSize: 28,
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