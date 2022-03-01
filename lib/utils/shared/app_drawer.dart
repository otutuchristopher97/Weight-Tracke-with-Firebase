// import 'package:e_transit_mobile/model/service_model.dart';
// import 'package:e_transit_mobile/model/user.dart';
// import 'package:e_transit_mobile/provider/auth.dart';
// import 'package:e_transit_mobile/provider/services.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../constants.dart';
// import './dashboard_item.dart';

// class AppDrawer extends StatefulWidget {
//   const AppDrawer({
//     Key key,
//   }) : super(key: key);

//   @override
//   _AppDrawerState createState() => _AppDrawerState();
// }

// class _AppDrawerState extends State<AppDrawer> {
//   User user = User();
//   Services services = Services();
//   Services services1 = Services();
//   Services services2 = Services();
//   Services services3 = Services();

//   @override
//   Widget build(BuildContext context) {
//     user = Provider.of<Auth>(context, listen: true).user;
//     final auth = Provider.of<Auth>(context, listen: false).isAuth;

//     return Container(
//       color: Color(0xff03174C),
//       child: Column(
//         children: [
//           SizedBox(
//             height: 60,
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(left: 20.0),
//                     child: ListTile(
//                       leading: CircleAvatar(
//                         radius: 35,
//                         backgroundColor: auth != true ? Colors.white : Colors.grey,
//                         backgroundImage: auth != true ?  null : AssetImage("assets/images/person2.png"),
//                       ),
//                       // : Icon(
//                       //     Icons.person,
//                       //     color: Colors.white70,
//                       //   ),
//                       title: auth != true
//                   ? GestureDetector(
//                       onTap: () {
//                         Navigator.of(context).pop();
//                         Navigator.of(context).pushNamed(kLoginScreen);
//                       },
//                       child: Text(
//                         "Login / Register",
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 18),
//                       )):Text(
//                         "${user.fullname}",
//                         style: TextStyle(color: Colors.white, fontSize: 16),
//                       ),
//                       onTap: () {
//                         Navigator.of(context).pop();
//                         // Navigator.of(context).pushNamed(kProfileScreen);
//                       },
//                       // subtitle: Text(
//                       //   "view profile",
//                       //   style: TextStyle(
//                       //       color: Colors.white70,
//                       //       decoration: TextDecoration.underline),
//                       // ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   DashboardItem(
//                     label: "Car Hire",
//                     iconUrl: "assets/images/car4.png",
//                     onTap: () {
//                       services3 = Provider.of<ServicesProvider>(context, listen: false).searchByName("Car Hire");
//                       Navigator.of(context).pop();
//                       print(services3.id);
//                       Navigator.of(context).pushNamed(KSelectCarTypeScreen, arguments: services3.id);
//                     },
//                   ),
//                   DashboardItem(
//                     label: "Hotels",
//                     // "Inventory",
//                     iconUrl: "assets/images/hotel2.png",
//                     onTap: () {
//                       Navigator.of(context).pop();
//                       // Navigator.of(context).pushNamed(kInventory);
//                     },
//                   ),
//                   DashboardItem(
//                     label: "Become a Partner",
//                     iconUrl: "assets/images/parcel.png",
//                     onTap: () {
//                       Navigator.of(context).pop();
//                       Navigator.of(context).pushNamed(KPartner);
//                     },
//                   ),
//                   DashboardItem(
//                     label: "Boat Cruise",
//                     iconUrl: "assets/images/tour.png",
//                     onTap: () {
//                       services1 = Provider.of<ServicesProvider>(context, listen: false).searchByName("Boat Cruise");
//                       Navigator.of(context).pop();
//                       Navigator.of(context).pushNamed(KBoatCruiseScreen, arguments: services.id);
//                     },
//                   ),
//                   DashboardItem(
//                     label: "Tour Packages",
//                     iconUrl: "assets/images/tour.png",
//                     onTap: () {
//                       services1 = Provider.of<ServicesProvider>(context, listen: false).searchByName("Tour Packages");
//                       Navigator.of(context).pop();
//                       Navigator.of(context).pushNamed(KTourPackages, arguments: services.id);
//                     },
//                   ),
//                   DashboardItem(
//                     label: "Reciepts",
//                     iconUrl: "assets/images/reciept.png",
//                     onTap: () {
//                       Navigator.of(context).pop();
//                       // Navigator.of(context).pushNamed(kStoreScreen);
//                     },
//                   ),
//                   DashboardItem(
//                     label: "History",
//                     iconUrl: "assets/images/history.png",
//                     onTap: () {
//                       Navigator.of(context).pop();
//                       // Navigator.of(context).pushNamed(kNotesScreen);
//                     },
//                   ),
//                   DashboardItem(
//                     label: "Send parcel",
//                     iconUrl: "assets/images/parcel.png",
//                     onTap: () {
//                       services = Provider.of<ServicesProvider>(context, listen: false).searchByName("Parcel");
//                       Navigator.of(context).pop();
//                       Navigator.of(context).pushNamed(KSendParcelScreen, arguments: services.id);
//                     },
//                   ),
//                   DashboardItem(
//                     label: "Setting",
//                     iconUrl: "assets/images/setting.png",
//                     onTap: () {
//                       Navigator.of(context).pop();
//                       // Navigator.of(context).pushNamed(kNotesScreen);
//                     },
//                   ),
//                   SizedBox(
//                     height: 30,
//                   ),
//                   if(auth==true)
//                   DashboardItem(
//                     label: "Logout",
//                     iconUrl: "assets/images/logout.png",
//                     onTap: () {
//                       // Navigator.of(context).pop();
//                       // Navigator.of(context).pushNamed(kChatScreen);
//                       Provider.of<Auth>(context, listen: false).logout();
//                       Navigator.of(context).pushNamedAndRemoveUntil(
//                           kLoginScreen, (route) => false);
//                     },
//                   ),

//                   // DashboardItem(
//                   //   label: "Inventory Report",
//                   //   iconUrl: "assets/images/inventory_report.png",
//                   //   onTap: () {
//                   //     Navigator.of(context).pop();
//                   //     Navigator.of(context).pushNamed(kInventoryReport);
//                   //   },
//                   // ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
