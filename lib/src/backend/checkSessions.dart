import 'package:flutter/material.dart';
import 'package:odoohackathon24/src/backend/auth.dart';
import 'package:odoohackathon24/src/backend/utils/routes/route_const.dart';

class Checksessions extends StatefulWidget {
  const Checksessions({super.key});

  @override
  State<Checksessions> createState() => _ChecksessionsState();
}

class _ChecksessionsState extends State<Checksessions> {
  @override
  void initState() {
    checkSessions().then((value) => {
          if (value)
            {Navigator.pushReplacementNamed(context, RouteConstant.mainHome)}
          else
            {Navigator.pushReplacementNamed(context, RouteConstant.login)}
        });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
