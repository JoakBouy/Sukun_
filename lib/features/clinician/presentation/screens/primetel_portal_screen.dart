import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/widgets/glass_container.dart';
import 'package:freud_ai/features/clinician/presentation/screens/clinician_dashboard_screen.dart';
import 'package:freud_ai/features/clinician/presentation/screens/assessment_launcher_screen.dart';
import 'package:freud_ai/features/clinician/presentation/screens/clients_list_screen.dart';
import 'package:freud_ai/features/clinician/presentation/screens/tools_hub_screen.dart';

/// The top-level navigation shell for the Primetel Health psychologist portal.
/// Four tabs tailored to a counsellor's daily workflow.
class PrimetelPortalScreen extends StatefulWidget {
  const PrimetelPortalScreen({super.key});

  @override
  State<PrimetelPortalScreen> createState() => _PrimetelPortalScreenState();
}

class _PrimetelPortalScreenState extends State<PrimetelPortalScreen>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _fadeController;

  final List<Widget> _screens = const [
    ClinicianDashboardScreen(),
    AssessmentLauncherScreen(),
    ClientsListScreen(),
    ToolsHubScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  void _onTabSelected(int index) {
    if (index == _selectedIndex) return;
    _fadeController.reverse().then((_) {
      setState(() => _selectedIndex = index);
      _fadeController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;
    const teal = CustomColors.primetelRed;

    return Scaffold(
      body: FadeTransition(
        opacity: _fadeController,
        child: IndexedStack(
          index: _selectedIndex,
          children: _screens,
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: colors.primaryContainer,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          border: Border(
            top: BorderSide(color: colors.onBackground.withOpacity(0.06), width: 1.2),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: _onTabSelected,
          backgroundColor: Colors.transparent,
          indicatorColor: teal.withOpacity(0.12),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          animationDuration: const Duration(milliseconds: 300),
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.dashboard_outlined, color: colors.iconColor),
              selectedIcon: const Icon(Icons.dashboard, color: CustomColors.primetelRed),
              label: 'Dashboard',
            ),
            NavigationDestination(
              icon: Icon(Icons.assignment_outlined, color: colors.iconColor),
              selectedIcon: const Icon(Icons.assignment, color: CustomColors.primetelRed),
              label: 'Assess',
            ),
            NavigationDestination(
              icon: Icon(Icons.people_outline, color: colors.iconColor),
              selectedIcon: const Icon(Icons.people, color: CustomColors.primetelRed),
              label: 'Clients',
            ),
            NavigationDestination(
              icon: Icon(Icons.medical_services_outlined, color: colors.iconColor),
              selectedIcon: const Icon(Icons.medical_services, color: CustomColors.primetelRed),
              label: 'Tools',
            ),
          ],
        ),
      ),
    );
  }
}
