import 'package:fb_demo/emailAuth/sign_in.dart';
import 'package:fb_demo/login.dart';
import 'package:fb_demo/relation/dish_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'create_user.dart';
import 'dismiss_demo.dart';
import 'emailAuth/dashbaord.dart';
import 'emailAuth/sign_in_with_email_validation.dart';
import 'filters/add_products.dart';
import 'filters/add_users.dart';
import 'filters/client_side_search.dart';
import 'filters/fliter_demo.dart';
import 'filters/search_demo.dart';
import 'filters/server_side_search.dart';
import 'get_profile.dart';

import 'image_upload.dart';
import 'load_more_dummy.dart';
import 'load_more_firebase.dart';
import 'location/current_location.dart';
import 'location/live_location.dart';
import 'maps/controller_demo.dart';
import 'maps/direction_demo.dart';
import 'maps/dynamic_marker.dart';
import 'maps/map_demo.dart';
import 'maps/marker_demo.dart';
import 'maps/polyline_demo.dart';
import 'maps/radius_demo.dart';
import 'my_sign_in.dart';
import 'otp_ui.dart';
import 'phoneAuth/phone_authentication.dart';
import 'read_data.dart';
import 'read_stream.dart';
import 'refresh_demo.dart';
import 'relation/customer/restaurants_list.dart';
import 'section_demo.dart';
import 'sections/date_wise_sections.dart';
import 'sections/month_demo.dart';
import 'sections/month_wise_sections.dart';
import 'show_profile.dart';
import 'show_profile_with_stream.dart';
import 'sub_collections/customer/restaurant_list.dart';
import 'sub_collections/registration.dart';
import 'uplad_file.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
    //  home: isUserLogedIn() ? Dashbaord() : SignIn(),
    home: DirectionDemo(),
    );
  }

  bool isUserLogedIn() {
    User? user = firebaseAuth.currentUser;

    if (user != null) {
      return true;
    } else {
      return false;
    }
  }
}
