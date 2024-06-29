import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:odoohackathon24/src/backend/checkSessions.dart';
import 'package:odoohackathon24/src/backend/saved_data.dart';
import 'package:odoohackathon24/src/backend/utils/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SavedData.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Orchestrator',
      onGenerateRoute: Routers.generateRoute,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(
        useMaterial3: true,
      ).copyWith(textTheme: GoogleFonts.interTextTheme()),
      home: const Checksessions(),
    );
  }
}
