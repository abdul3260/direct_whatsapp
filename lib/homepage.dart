import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String countryCode = "";
  String message = "";
  final TextEditingController messageController = TextEditingController();
  String number = "";
  final TextEditingController numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 1,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Whatsapp Direct",
                  style: TextStyle(
                    fontSize: 35.sp,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  "No need to save your friend's number. Now You can message your friend directly from here.",
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  width: 100.w,
                  height: 100.h,
                  child: Image.asset("assets/images/whatsapp.png"),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                  ),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 2,
                        color: Colors.green,
                        offset: Offset(1, 1),
                        spreadRadius: 2,
                      )
                    ],
                    border: Border.all(color: Colors.green),
                    borderRadius: BorderRadius.circular(50.r),
                    color: Colors.green.shade100,
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.phone),
                      CountryCodePicker(
                        initialSelection: "PK",
                        showCountryOnly: true,
                        favorite: ["+92", "PK"],
                        onChanged: (number) {
                          setState(() {
                            countryCode = number.toString();
                          });
                          print(countryCode);
                        },
                      ),  
                      
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                        child: Container(
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                number = value;
                              });
                            },
                            // textAlign: TextAlign.center,
                            controller: numberController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              focusColor: Colors.green,
                              fillColor: Colors.green.shade100,
                              hintText: "Enter Number",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      message = value;
                    });
                  },
                  // textAlign: TextAlign.center,
                  controller: messageController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    focusColor: Colors.green,
                    fillColor: Colors.green.shade100,
                    hintText: "Type your message here...",
                    border: InputBorder.none,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20.h,
                ),
                InkWell(
                  onTap: () async {
                    if (numberController.text.length > 10) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text("Incorrect number"),
                        ),
                      );
                    } else if (numberController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text("Field Cannot be empty"),
                        ),
                      );
                    } else if (numberController.text.length < 10) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text("Number must be 10 digits long"),
                        ),
                      );
                    } else {
                      await launch(
                          "http://wa.me/$countryCode${numberController.text}?text=$message");
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.height * 0.30,
                    height: 50.h,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 2,
                          color: Colors.green,
                          offset: Offset(1, 1),
                          spreadRadius: 2,
                        )
                      ],
                      gradient: LinearGradient(colors: [
                        Colors.green,
                        Colors.green.shade200,
                        Colors.green,
                      ]),
                      border: Border.all(color: Colors.black),
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(40.r),
                    ),
                    child: Text(
                      "Send Message",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
