import 'package:flutter/material.dart';
import 'package:odoohackathon24/src/backend/utils/navi_anim/page_transition.dart';
import 'package:odoohackathon24/src/backend/utils/routes/route_const.dart';
import 'package:odoohackathon24/src/frontend/screens/getstarted/onboarding_screen.dart';
import 'package:odoohackathon24/src/frontend/screens/home_pages/create_event_page.dart';
import 'package:odoohackathon24/src/frontend/screens/login/login_screen.dart';
import 'package:odoohackathon24/src/frontend/screens/main_home/main_home.dart';
import 'package:odoohackathon24/src/frontend/screens/profile/manage_events.dart';
import 'package:odoohackathon24/src/frontend/screens/profile/profile_page.dart';
import 'package:odoohackathon24/src/frontend/screens/profile/rsvp_events.dart';
import 'package:odoohackathon24/src/frontend/screens/signup/signup_screen.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteConstant.getStarted:
        return slidePageRoute(const OnboardingScreen());
      case RouteConstant.login:
        return slidePageRoute(LoginScreen());
      case RouteConstant.register:
        return slidePageRoute(SignupScreen());
      case RouteConstant.mainHome:
        return slidePageRoute(const MainHome());
      case RouteConstant.createEvent:
        return slidePageRoute(const CreateEventPage());
      case RouteConstant.rsvpEvents:
        return slidePageRoute(const RSVPEvents());
      case RouteConstant.manageEvents:
        return slidePageRoute(const ManageEvents());
      case RouteConstant.profile:
        return slidePageRoute(const Profile());
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text('No route found'),
            ),
          ),
        );
    }
  }
}
