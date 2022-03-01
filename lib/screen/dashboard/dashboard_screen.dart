import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weight_tracker/constants.dart';
import 'package:weight_tracker/provider/service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weight_tracker/utils/shared/CustomRaisedButton.dart';
import 'package:weight_tracker/utils/shared/custom_textformfield.dart';
import 'package:connectivity/connectivity.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  GlobalKey<FormState> _weightFormKey = GlobalKey();
  String _weight;
  bool _isLoading = true;

  String dropdownvalue = '';
  var items = [
    'Logout',
  ];

  // @override
  // void initState() {
  //   super.initState();

  //   getCurrentUser();
  // }

  // void getCurrentUser() async {
  //   try {
  //     final user = await _auth.currentUser();
  //     if (user != null) {
  //       // loggedInUser = user;
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  Future<void> submitLogin() async {
    if (!_weightFormKey.currentState.validate()) {
      return;
    }
    _weightFormKey.currentState.save();
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      print('I am connected to a mobile network');
      setState(() {
        _isLoading = true;
      });
      try {
        await Provider.of<AuthService>(context, listen: false)
            .enterWeight(_weight, DateTime.now().toString());
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pop();
      } catch (e) {}
    } else {
      Get.snackbar('Info!!!', "Please check your Internet connection!!!",
          barBlur: 0,
          dismissDirection: SnackDismissDirection.VERTICAL,
          backgroundColor: Colors.red[50],
          overlayBlur: 0,
          animationDuration: Duration(seconds: 2),
          duration: Duration(seconds: 2));
      Navigator.of(context).pop();
    }
  }

  weightDialod() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) {
          return AlertDialog(
            title: Text(
              "Enter Weight",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Form(
              key: _weightFormKey,
              child: CustomTextFormField(
                hintText: "50kg",
                validator: (value) {
                  if (value.isEmpty) {
                    return "Required";
                  }
                },
                onSaved: (value) {
                  _weight = value;
                },
              ),
            ),
            actions: [
              Container(
                height: 45,
                width: 80,
                child: CustomRaisedButton(
                  title: "Add",
                  onPress: () {
                    submitLogin();
                    // Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                width: double.infinity,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  elevation: 3,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      ListTile(
                          leading: Image.asset(
                            "assets/icons/weight.png",
                            height: 60,
                            width: 60,
                          ),
                          title: Text(
                            "Weight Tracker",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.blue[600].withOpacity(0.7)),
                          ),
                          subtitle: Text(
                            "Welcome",
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: Colors.blue[600].withOpacity(0.7)),
                          ),
                          trailing: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              elevation: 0,
                              // value: dropdownvalue,
                              icon: Icon(Icons.menu),
                              items: items.map((String items) {
                                return DropdownMenuItem(
                                    value: items, child: Text(items));
                              }).toList(),
                              onChanged: (String newValue) async {
                                await Provider.of<AuthService>(context,
                                        listen: false)
                                    .signInAnon();
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    kAuthScreen, (route) => false);
                              },
                            ),
                          )),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: _firestore.collection('weight_tracker').snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (ctx, index) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.data.docs == null) {
                              return Text("No Weight Entered");
                            } else
                              return Card(
                                  child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Weight',
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 13),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(snapshot.data.docs[index]["weight"]
                                            .toString()),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Time",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 13),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.parse(snapshot.data.docs[index]["time"]))
                                            .toString()),
                                      ],
                                    ),
                                  ],
                                ),
                              ));
                          });
                    },
                  ),
                ),
              ),
            ],
          )),
      floatingActionButton: Container(
        width: 130,
        height: 50,
        child: GestureDetector(
          onTap: () {
            weightDialod();
          },
          child: Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.add),
                SizedBox(
                  width: 5,
                ),
                Text("Add Weight"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({this.sender, this.text, this.isMe});

  final String sender;
  final String text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            sender,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0))
                : BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
            elevation: 0.2,
            color: isMe ? Color(0xff3810D7) : Color(0xffF2F2F2),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                text,
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.black54,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
