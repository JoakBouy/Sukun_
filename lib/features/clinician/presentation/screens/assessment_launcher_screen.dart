import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/core/utils/animation_utils.dart';
import 'package:freud_ai/core/widgets/glass_container.dart';
import 'package:freud_ai/features/clinician/presentation/screens/clinical_results_screen.dart';
import 'package:freud_ai/features/health_assessment/presentation/screens/phq9_assessment_screen.dart';
import 'package:freud_ai/features/health_assessment/presentation/screens/dass21_assessment_screen.dart';
import 'package:freud_ai/features/health_assessment/presentation/screens/asq_assessment_screen.dart';
import 'package:freud_ai/features/clinician/presentation/screens/gad7_assessment_screen.dart';
import 'package:freud_ai/features/clinician/presentation/screens/pcl5_assessment_screen.dart';
import 'package:freud_ai/features/clinician/presentation/screens/srq20_assessment_screen.dart';

/// Pre-assessment intake wizard. Collects client context before launching
/// the selected assessment. Returns results to the clinical results screen.
class AssessmentLauncherScreen extends StatefulWidget {
  final String? preselectedAssessment;

  const AssessmentLauncherScreen({super.key, this.preselectedAssessment});

  @override
  State<AssessmentLauncherScreen> createState() => _AssessmentLauncherScreenState();
}

class _AssessmentLauncherScreenState extends State<AssessmentLauncherScreen> {
  // Step 1: Client identity
  final _nameController = TextEditingController();
  bool _isAnonymous = false;
  String? _gender;
  String? _ageRange;
  bool _isFirstVisit = true;

  // Step 2: Session context
  String? _context;
  final _locationController = TextEditingController();

  // Step 3: Assessment selection
  String? _selectedAssessment;

  int _currentStep = 0;

  final _genders = ['Male', 'Female', 'Other', 'Prefer not to say'];
  final _ageRanges = ['Under 18', '18–25', '26–35', '36–50', 'Over 50'];
  final _contexts = ['Clinic', 'Outreach', 'School Program', 'Workplace', 'Home Visit'];

  final _assessments = [
    _AInfo('PHQ-9', 'Depression screening', Icons.mood_bad, Color(0xFFC82828), 'PHQ9', '9 questions · ~3 min'),
    _AInfo('GAD-7', 'Anxiety screening', Icons.psychology_alt, Color(0xFFED7E1C), 'GAD7', '7 questions · ~2 min'),
    _AInfo('DASS-21', 'Depression, Anxiety & Stress', Icons.bar_chart, Color(0xFFA694F5), 'DASS21', '21 questions · ~5 min'),
    _AInfo('ASQ', 'Suicide risk screening', Icons.warning_amber, Color(0xFFB71C1C), 'ASQ', '4 questions · ~1 min'),
    _AInfo('PCL-5', 'PTSD / Trauma', Icons.healing, Color(0xFFFFBD1A), 'PCL5', '20 questions · ~5 min'),
    _AInfo('SRQ-20', 'WHO Common Mental Disorders', Icons.public, Color(0xFF9BB168), 'SRQ20', '20 questions · ~7 min'),
  ];

  @override
  void initState() {
    super.initState();
    if (widget.preselectedAssessment != null) {
      _selectedAssessment = widget.preselectedAssessment;
      _currentStep = 0; // Still start from client intake
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  String get _clientId => _isAnonymous
      ? 'ANON-${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}'
      : _nameController.text.trim();

  bool get _step0Valid => _clientId.isNotEmpty;
  bool get _step1Valid => _context != null;
  bool get _step2Valid => _selectedAssessment != null;

  void _launch() {
    if (_selectedAssessment == null) return;
    final clientId = _clientId;
    final context = _context ?? 'Clinic';

    Widget screen;
    switch (_selectedAssessment) {
      case 'PHQ9':
        screen = PHQ9AssessmentScreen();
        break;
      case 'GAD7':
        screen = GAD7AssessmentScreen();
        break;
      case 'DASS21':
        screen = const DASS21AssessmentScreen(isClinicianFlow: true);
        break;
      case 'ASQ':
        screen = const ASQAssessmentScreen(isClinicianFlow: true);
        break;
      case 'PCL5':
        screen = PCL5AssessmentScreen();
        break;
      case 'SRQ20':
        screen = SRQ20AssessmentScreen();
        break;
      default:
        return;
    }

    Navigator.push(
      this.context,
      MaterialPageRoute(builder: (_) => screen),
    ).then((result) {
      if (result != null && result is Map<String, dynamic> && mounted) {
        Navigator.push(
          this.context,
          MaterialPageRoute(
            builder: (_) => ClinicalResultsScreen(
              clientIdentifier: clientId,
              isAnonymous: _isAnonymous,
              gender: _gender,
              ageRange: _ageRange,
              isFirstVisit: _isFirstVisit,
              sessionContext: context,
              subLocation: _locationController.text.trim().isEmpty ? null : _locationController.text.trim(),
              assessmentType: _selectedAssessment!,
              score: result['score'] ?? 0,
              severity: result['severity'] ?? 'Unknown',
              answers: result['answers'] ?? {},
            ),
          ),
        ).then((_) {
          // Reset launcher state after returning
          setState(() {
            _nameController.clear();
            _locationController.clear();
            _isAnonymous = false;
            _gender = null;
            _ageRange = null;
            _context = null;
            _selectedAssessment = widget.preselectedAssessment;
            _currentStep = 0;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: const Text('Intake Wizard', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: widget.preselectedAssessment != null
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              )
            : null,
      ),
      body: Column(
        children: [
          // Step progress indicator
          _buildProgressStepper(colors),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(SizesManager.padding),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) => FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: animation.drive(Tween<Offset>(
                      begin: const Offset(0.05, 0),
                      end: Offset.zero,
                    ).chain(CurveTween(curve: Curves.easeInOut))),
                    child: child,
                  ),
                ),
                child: KeyedSubtree(
                  key: ValueKey<int>(_currentStep),
                  child: _currentStep == 0
                      ? _buildStep0Client(colors, theme)
                      : _currentStep == 1
                          ? _buildStep1Context(colors, theme)
                          : _buildStep2Assessment(colors, theme),
                ),
              ),
            ),
          ),

          // Bottom navigation buttons
          _buildBottomNav(colors),
        ],
      ),
    );
  }

  Widget _buildProgressStepper(CustomColors colors) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: List.generate(3, (i) {
          final isActive = _currentStep == i;
          final isDone = _currentStep > i;
          return Expanded(
            child: Row(
              children: [
                Expanded(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: 6,
                    decoration: BoxDecoration(
                      color: isDone || isActive
                          ? CustomColors.primetelRed
                          : colors.onBackground.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
                if (i < 2) const SizedBox(width: 8),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildStep0Client(CustomColors colors, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Client Identity', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: colors.primary)),
        const SizedBox(height: 6),
        Text('Enter client details before starting screening', style: theme.textTheme.bodySmall?.copyWith(color: colors.onBackground.withOpacity(0.5))),
        const SizedBox(height: 24),

        // Anonymous toggle
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: colors.primaryContainer,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: colors.onBackground.withOpacity(0.04)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text('Anonymous session', style: theme.textTheme.titleSmall?.copyWith(color: colors.primary, fontWeight: FontWeight.bold)),
              ),
              Switch.adaptive(
                value: _isAnonymous,
                activeColor: CustomColors.primetelRed,
                onChanged: (v) => setState(() => _isAnonymous = v),
              ),
            ],
          ),
        ).animate().fadeIn(delay: 100.ms).slideX(begin: -0.02),
        const SizedBox(height: 16),

        if (!_isAnonymous) ...[
          TextField(
            controller: _nameController,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              labelText: 'Client Name / Code',
              prefixIcon: const Icon(Icons.person_outline, color: CustomColors.primetelRed),
              filled: true,
              fillColor: colors.primaryContainer,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: CustomColors.primetelRed, width: 2),
              ),
            ),
          ).animate().fadeIn(delay: 150.ms),
          const SizedBox(height: 16),
        ] else ...[
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: CustomColors.primetelRedLight,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: CustomColors.primetelRed.withOpacity(0.1)),
            ),
            child: Row(
              children: [
                const Icon(Icons.lock_person, color: CustomColors.primetelRed, size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'An secure anonymous code (ANON-xxxx) will be generated for data privacy.',
                    style: theme.textTheme.bodySmall?.copyWith(color: CustomColors.primetelRed, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(delay: 150.ms),
          const SizedBox(height: 16),
        ],

        // Gender
        Text('Gender', style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold, color: colors.primary)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _genders.map((g) => AnimatedPressable(
            onTap: () => setState(() => _gender = g),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: _gender == g ? CustomColors.primetelRed.withOpacity(0.1) : colors.primaryContainer,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _gender == g ? CustomColors.primetelRed : colors.onBackground.withOpacity(0.06), width: 1.5),
              ),
              child: Text(
                g,
                style: TextStyle(
                  color: _gender == g ? CustomColors.primetelRed : colors.onBackground,
                  fontWeight: _gender == g ? FontWeight.bold : FontWeight.normal,
                  fontSize: 13,
                ),
              ),
            ),
          )).toList(),
        ).animate().fadeIn(delay: 200.ms),
        const SizedBox(height: 20),

        // Age
        Text('Age Range', style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold, color: colors.primary)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _ageRanges.map((a) => AnimatedPressable(
            onTap: () => setState(() => _ageRange = a),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: _ageRange == a ? CustomColors.primetelRed.withOpacity(0.1) : colors.primaryContainer,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _ageRange == a ? CustomColors.primetelRed : colors.onBackground.withOpacity(0.06), width: 1.5),
              ),
              child: Text(
                a,
                style: TextStyle(
                  color: _ageRange == a ? CustomColors.primetelRed : colors.onBackground,
                  fontWeight: _ageRange == a ? FontWeight.bold : FontWeight.normal,
                  fontSize: 13,
                ),
              ),
            ),
          )).toList(),
        ).animate().fadeIn(delay: 250.ms),
        const SizedBox(height: 24),

        // First visit
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: colors.primaryContainer,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: colors.onBackground.withOpacity(0.04)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text('First clinical/mental health visit?', style: theme.textTheme.titleSmall?.copyWith(color: colors.primary, fontWeight: FontWeight.bold)),
              ),
              Switch.adaptive(
                value: _isFirstVisit,
                activeColor: CustomColors.primetelRed,
                onChanged: (v) => setState(() => _isFirstVisit = v),
              ),
            ],
          ),
        ).animate().fadeIn(delay: 300.ms),
      ],
    );
  }

  Widget _buildStep1Context(CustomColors colors, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Session Context', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: colors.primary)),
        const SizedBox(height: 6),
        Text('Where is this session taking place?', style: theme.textTheme.bodySmall?.copyWith(color: colors.onBackground.withOpacity(0.5))),
        const SizedBox(height: 24),

        ...List.generate(_contexts.length, (i) {
          final ctx = _contexts[i];
          final icons = [Icons.local_hospital, Icons.directions_walk, Icons.school, Icons.business, Icons.home];
          final isSelected = _context == ctx;
          return AnimatedPressable(
            onTap: () => setState(() => _context = ctx),
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isSelected ? CustomColors.primetelRedLight : colors.primaryContainer,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected ? CustomColors.primetelRed : colors.onBackground.withOpacity(0.04),
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(icons[i], color: isSelected ? CustomColors.primetelRed : colors.iconColor, size: 22),
                  const SizedBox(width: 14),
                  Text(ctx, style: theme.textTheme.titleSmall?.copyWith(
                    color: isSelected ? CustomColors.primetelRed : colors.primary,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  )),
                  const Spacer(),
                  if (isSelected) const Icon(Icons.check_circle, color: CustomColors.primetelRed, size: 20),
                ],
              ),
            ),
          ).animateCardEntrance(index: i);
        }),

        const SizedBox(height: 16),
        TextField(
          controller: _locationController,
          decoration: InputDecoration(
            labelText: 'Specific location details (optional)',
            hintText: 'e.g. Monduli Clinic, CRDB Arusha Branch',
            prefixIcon: const Icon(Icons.place_outlined, color: CustomColors.primetelRed),
            filled: true,
            fillColor: colors.primaryContainer,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: CustomColors.primetelRed, width: 2),
            ),
          ),
        ).animate().fadeIn(delay: 400.ms),
      ],
    );
  }

  Widget _buildStep2Assessment(CustomColors colors, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Select Assessment', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: colors.primary)),
        const SizedBox(height: 6),
        Text('Choose the appropriate clinical tool', style: theme.textTheme.bodySmall?.copyWith(color: colors.onBackground.withOpacity(0.5))),
        const SizedBox(height: 24),

        ..._assessments.asMap().entries.map((e) {
          final a = e.value;
          final isSelected = _selectedAssessment == a.code;
          return AnimatedPressable(
            onTap: () => setState(() => _selectedAssessment = a.code),
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isSelected ? a.color.withOpacity(0.08) : colors.primaryContainer,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected ? a.color : colors.onBackground.withOpacity(0.04),
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: a.color.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(a.icon, color: a.color, size: 22),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(a.name, style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isSelected ? a.color : colors.primary,
                        )),
                        Text(a.subtitle, style: theme.textTheme.bodySmall?.copyWith(
                          color: colors.onBackground.withOpacity(0.55),
                          fontSize: 12,
                        )),
                        const SizedBox(height: 2),
                        Text(a.duration, style: theme.textTheme.labelSmall?.copyWith(
                          color: a.color,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        )),
                      ],
                    ),
                  ),
                  if (isSelected) Icon(Icons.check_circle, color: a.color, size: 22),
                ],
              ),
            ),
          ).animateCardEntrance(index: e.key);
        }),
      ],
    );
  }

  Widget _buildBottomNav(CustomColors colors) {
    final bool canGoNext = _currentStep == 0
        ? _step0Valid
        : _currentStep == 1
            ? _step1Valid
            : _step2Valid;

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
      decoration: BoxDecoration(
        color: colors.primaryContainer,
        border: Border(top: BorderSide(color: colors.onBackground.withOpacity(0.06), width: 1.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          if (_currentStep > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: () => setState(() => _currentStep--),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                child: const Text('Back'),
              ),
            ),
          if (_currentStep > 0) const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: canGoNext
                  ? () {
                      if (_currentStep < 2) {
                        setState(() => _currentStep++);
                      } else {
                        _launch();
                      }
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: CustomColors.primetelRed,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: Text(
                _currentStep == 2 ? 'Launch Assessment' : 'Next Step',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AInfo {
  final String name;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String code;
  final String duration;
  const _AInfo(this.name, this.subtitle, this.icon, this.color, this.code, this.duration);
}
