import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/features/doctor/presentation/screens/doctor_dashboard_screen.dart';
import 'package:freud_ai/features/doctor/presentation/screens/schedule_screen.dart';
import 'package:freud_ai/features/doctor/presentation/screens/doctor_messaging_screen.dart';
import 'package:freud_ai/features/profile/presentation/screens/profile_screen.dart';

class DoctorNavigationScreen extends StatefulWidget {
  const DoctorNavigationScreen({super.key});

  @override
  State<DoctorNavigationScreen> createState() => _DoctorNavigationScreenState();
}

class _DoctorNavigationScreenState extends State<DoctorNavigationScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    DoctorDashboardScreen(),
    ScheduleScreen(),
    DoctorMessagingScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() => _selectedIndex = index);
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: colors.primaryContainer,
          selectedItemColor: colors.green,
          unselectedItemColor: colors.iconColor,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'Schedule',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: 'Messages',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
