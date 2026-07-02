import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/core/utils/animation_utils.dart';
import 'package:freud_ai/features/clinician/data/models/client_session.dart';
import 'package:freud_ai/features/clinician/data/services/clinician_service.dart';
import 'package:freud_ai/features/clinician/presentation/screens/assessment_launcher_screen.dart';
import 'package:freud_ai/features/clinician/presentation/screens/crisis_protocol_screen.dart';
import 'package:freud_ai/features/clinician/presentation/screens/outreach_tracker_screen.dart';
import 'package:freud_ai/features/clinician/presentation/screens/client_detail_screen.dart';
import 'package:freud_ai/features/clinician/presentation/screens/monthly_report_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClinicianDashboardScreen extends StatefulWidget {
  const ClinicianDashboardScreen({super.key});

  @override
  State<ClinicianDashboardScreen> createState() => _ClinicianDashboardScreenState();
}

class _ClinicianDashboardScreenState extends State<ClinicianDashboardScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final _service = ClinicianService.instance;
  Map<String, dynamic> _stats = {};
  Map<String, dynamic> _outreachStats = {};
  List<ClientSession> _recentSessions = [];
  List<ClientSession> _crisisSessions = [];
  String _clinicianName = 'Clinician';
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('clinician_name') ?? 'Clinician';

    try {
      final stats = await _service.getDashboardStats();
      final outreachStats = await _service.getOutreachStats();
      final recentSessions = await _service.getRecentSessions(limit: 5);
      final crisisSessions = await _service.getCrisisSessions();

      if (mounted) {
        setState(() {
          _clinicianName = name;
          _stats = stats;
          _outreachStats = outreachStats;
          _recentSessions = recentSessions;
          _crisisSessions = crisisSessions;
          _loading = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _clinicianName = name;
          _loading = false;
        });
      }
    }
  }

  Future<void> _promptClinicianName() async {
    final controller = TextEditingController(text: _clinicianName);
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Edit Clinician Name'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'e.g. Dr. Amina Kato',
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: CustomColors.primetelRed)),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: CustomColors.primetelRed,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setString('clinician_name', controller.text.trim());
              if (mounted) setState(() => _clinicianName = controller.text.trim());
              if (ctx.mounted) Navigator.pop(ctx);
            },
            child: const Text('Save', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final colors = Theme.of(context).extension<CustomColors>()!;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: colors.background,
      body: Stack(
        children: [
          // Background soft radial gradient decoration for premium layout
          Positioned(
            top: -200,
            right: -200,
            child: Container(
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    CustomColors.primetelRed.withOpacity(0.12),
                    CustomColors.primetelRed.withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -150,
            left: -150,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    colors.green.withOpacity(0.08),
                    colors.green.withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ),

          RefreshIndicator(
            color: CustomColors.primetelRed,
            onRefresh: _loadData,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                // ── Premium App Bar ──────────────────────────────────────────
                SliverAppBar(
                  expandedHeight: 185,
                  pinned: true,
                  backgroundColor: colors.background.withOpacity(0.95),
                  elevation: 0,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.transparent,
                    statusBarBrightness: theme.brightness == Brightness.dark
                        ? Brightness.dark
                        : Brightness.light,
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            CustomColors.primetelRed,
                            Color(0xFF8B1A1A),
                          ],
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(32),
                          bottomRight: Radius.circular(32),
                        ),
                      ),
                      child: SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: SizesManager.padding,
                            vertical: 12,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  // Rebranded logo container
                                  Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Image.asset(
                                      'assets/images/primetel_logo.png',
                                      height: 38,
                                    ),
                                  ),
                                  const Spacer(),
                                  AnimatedPressable(
                                    onTap: _promptClinicianName,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: Colors.white24,
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(color: Colors.white30),
                                      ),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 12,
                                            backgroundColor: Colors.white,
                                            child: Text(
                                              _clinicianName.isNotEmpty
                                                  ? _clinicianName[0].toUpperCase()
                                                  : 'C',
                                              style: const TextStyle(
                                                color: CustomColors.primetelRed,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            _clinicianName,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          const Icon(Icons.keyboard_arrow_down, color: Colors.white70, size: 14),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 18),
                              Text(
                                'Good ${_greeting()},',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: Colors.white70,
                                ),
                              ),
                              Text(
                                _clinicianName,
                                style: theme.textTheme.headlineSmall?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.location_on_outlined, color: Colors.white70, size: 12),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Primetel Health • ${_todayString()}',
                                    style: theme.textTheme.labelSmall?.copyWith(
                                      color: Colors.white60,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.bar_chart, color: Colors.white),
                      tooltip: 'Monthly Reports',
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const MonthlyReportScreen()),
                      ),
                    ),
                  ],
                ),

                SliverPadding(
                  padding: const EdgeInsets.all(SizesManager.padding),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      if (_loading)
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(40),
                            child: CircularProgressIndicator(color: CustomColors.primetelRed),
                          ),
                        )
                      else ...[
                        // ── Crisis Banner ────────────────────────────────────
                        if (_crisisSessions.isNotEmpty) ...[
                          _buildCrisisBanner(colors, theme),
                          const SizedBox(height: SizesManager.cardSpacing),
                        ],

                        // ── Premium Stats Strip (Flat & High Contrast) ───────
                        _buildStatsStrip(colors, theme),
                        const SizedBox(height: SizesManager.sectionSpacing),

                        // ── Assessment Launch Grid ───────────────────────────
                        _buildSectionTitle('Screening Suite', theme, colors),
                        const SizedBox(height: 12),
                        _buildAssessmentGrid(context, colors, theme),
                        const SizedBox(height: SizesManager.sectionSpacing),

                        // ── Outreach strip (Flat & Clean Border) ─────────────
                        _buildOutreachStrip(colors, theme),
                        const SizedBox(height: SizesManager.sectionSpacing),

                        // ── Recent Sessions ──────────────────────────────────
                        _buildSectionTitle(
                          'Recent Sessions',
                          theme,
                          colors,
                        ),
                        const SizedBox(height: 12),
                        if (_recentSessions.isEmpty)
                          _buildEmptyState(colors, theme)
                        else
                          ..._recentSessions.asMap().entries.map(
                                (e) => _buildSessionCard(e.value, colors, theme, e.key),
                              ),

                        const SizedBox(height: 80),
                      ],
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Crisis Banner ──────────────────────────────────────────────────────────

  Widget _buildCrisisBanner(CustomColors colors, ThemeData theme) {
    return AnimatedPressable(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const CrisisProtocolScreen()),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFFBEAEA),
          borderRadius: BorderRadius.circular(SizesManager.cardCircularBorderRadius),
          border: Border.all(color: CustomColors.primetelRed.withOpacity(0.4), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: CustomColors.primetelRed.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: CustomColors.primetelRed,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.warning_amber_rounded, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${_crisisSessions.length} Active Crisis Flag${_crisisSessions.length > 1 ? 's' : ''}',
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: CustomColors.primetelRed,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    'Safety protocols required. Tap to launch.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: CustomColors.primetelRed.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: CustomColors.primetelRed, size: 14),
          ],
        ),
      )
          .animate()
          .fadeIn(duration: 400.ms)
          .shimmer(duration: 2000.ms, color: CustomColors.primetelRed.withOpacity(0.1)),
    );
  }

  // ── Stats Strip ────────────────────────────────────────────────────────────

  Widget _buildStatsStrip(CustomColors colors, ThemeData theme) {
    final todayCount = (_stats['today'] ?? 0) as int;
    final weekCount = (_stats['this_week'] ?? 0) as int;
    final crisisCount = (_stats['crisis_flags'] ?? 0) as int;
    final totalClients = (_stats['total_clients'] ?? 0) as int;

    return Row(
      children: [
        _buildStatChip('Today', todayCount.toString(), Icons.today, CustomColors.primetelRed, colors, theme, 0),
        const SizedBox(width: 10),
        _buildStatChip('This Week', weekCount.toString(), Icons.calendar_view_week, colors.orange, colors, theme, 1),
        const SizedBox(width: 10),
        _buildStatChip('Clients', totalClients.toString(), Icons.people, colors.violet, colors, theme, 2),
        const SizedBox(width: 10),
        _buildStatChip('Flags', crisisCount.toString(), Icons.flag_rounded, crisisCount > 0 ? Colors.red : colors.green, colors, theme, 3),
      ],
    );
  }

  Widget _buildStatChip(String label, String value, IconData icon, Color accentColor,
      CustomColors colors, ThemeData theme, int index) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: colors.primaryContainer,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: colors.onBackground.withOpacity(0.06), width: 1.2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: accentColor, size: 18),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w900,
                color: colors.primary,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: theme.textTheme.labelSmall?.copyWith(
                color: colors.onBackground.withOpacity(0.5),
                fontSize: 10,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ).animateCardEntrance(index: index),
    );
  }

  // ── Assessment Grid (2-Columns to prevent overlaps) ───────────────────────

  Widget _buildAssessmentGrid(BuildContext context, CustomColors colors, ThemeData theme) {
    final assessments = [
      _AssessmentInfo('PHQ-9', 'Depression screening', Icons.mood_bad_rounded, CustomColors.primetelRed, '9 Q • ~3 min', 'PHQ9'),
      _AssessmentInfo('GAD-7', 'Anxiety screening', Icons.psychology_alt_rounded, colors.orange, '7 Q • ~2 min', 'GAD7'),
      _AssessmentInfo('DASS-21', 'Tri-Scale (D/A/S)', Icons.bar_chart_rounded, colors.violet, '21 Q • ~5 min', 'DASS21'),
      _AssessmentInfo('ASQ', 'Suicide Risk screening', Icons.warning_amber_rounded, Colors.red.shade700, '4 Q • ~1 min', 'ASQ'),
      _AssessmentInfo('PCL-5', 'PTSD / Trauma screening', Icons.healing_rounded, colors.yellow, '20 Q • ~5 min', 'PCL5'),
      _AssessmentInfo('SRQ-20', 'WHO CMD screening', Icons.public_rounded, colors.green, '20 Q • ~7 min', 'SRQ20'),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.35,
      ),
      itemCount: assessments.length,
      itemBuilder: (ctx, i) {
        final a = assessments[i];
        return _buildAssessmentCard(context, a, colors, theme, i);
      },
    );
  }

  Widget _buildAssessmentCard(BuildContext context, _AssessmentInfo a,
      CustomColors colors, ThemeData theme, int index) {
    return AnimatedPressable(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => AssessmentLauncherScreen(preselectedAssessment: a.code),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colors.primaryContainer,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: colors.onBackground.withOpacity(0.06), width: 1.2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: a.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(a.icon, color: a.color, size: 20),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: a.color.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    a.code == 'DASS21' ? 'DASS-21' : a.name,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: a.color,
                      fontWeight: FontWeight.w900,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              a.code == 'DASS21' ? 'DASS-21 Tri-Scale' : a.name,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w900,
                color: colors.primary,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              a.subtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colors.onBackground.withOpacity(0.4),
                fontSize: 11,
              ),
            ),
          ],
        ),
      ).animateCardEntrance(index: index),
    );
  }

  // ── Outreach Strip ─────────────────────────────────────────────────────────

  Widget _buildOutreachStrip(CustomColors colors, ThemeData theme) {
    final totalReached = (_outreachStats['total_reached'] ?? 0) as int;
    final totalEvents = (_outreachStats['total_events'] ?? 0) as int;
    final totalReferrals = (_outreachStats['total_referrals'] ?? 0) as int;

    return AnimatedPressable(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const OutreachTrackerScreen()),
      ).then((_) => _loadData()),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: colors.primaryContainer,
          borderRadius: BorderRadius.circular(SizesManager.cardCircularBorderRadius),
          border: Border.all(color: colors.green.withOpacity(0.2), width: 1.2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.directions_walk_rounded, color: colors.green, size: 20),
                ),
                const SizedBox(width: 10),
                Text(
                  'Community Outreach',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: colors.primary,
                  ),
                ),
                const Spacer(),
                Text(
                  'Log Event →',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: colors.green,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _outreachStat('Events', totalEvents.toString(), colors, theme),
                _outreachStat('People Reached', totalReached.toString(), colors, theme),
                _outreachStat('Referrals', totalReferrals.toString(), colors, theme),
              ],
            ),
          ],
        ),
      ).animateCardEntrance(index: 8),
    );
  }

  Widget _outreachStat(String label, String value, CustomColors colors, ThemeData theme) {
    return Column(
      children: [
        Text(
          value,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w900,
            color: colors.green,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: colors.onBackground.withOpacity(0.5),
            fontSize: 11,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  // ── Recent Sessions ────────────────────────────────────────────────────────

  Widget _buildSessionCard(ClientSession session, CustomColors colors, ThemeData theme, int index) {
    final sevColor = _severityColor(session.severity, colors);

    return AnimatedPressable(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ClientDetailScreen(clientIdentifier: session.clientIdentifier),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: colors.primaryContainer,
          borderRadius: BorderRadius.circular(SizesManager.cardCircularBorderRadius),
          border: Border.all(color: colors.onBackground.withOpacity(0.05)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: sevColor.withOpacity(0.12),
              child: Text(
                session.clientIdentifier.isNotEmpty
                    ? session.clientIdentifier[0].toUpperCase()
                    : '?',
                style: TextStyle(
                  color: sevColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    session.isAnonymous ? '🔒 ${session.clientIdentifier}' : session.clientIdentifier,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: colors.primary,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: colors.background,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          session.assessmentType,
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: colors.primary.withOpacity(0.7),
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        session.sessionContext,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colors.onBackground.withOpacity(0.45),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: sevColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    session.severity,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      color: sevColor,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _timeAgo(session.timestamp),
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: colors.onBackground.withOpacity(0.35),
                  ),
                ),
              ],
            ),
          ],
        ),
      ).animateCardEntrance(index: index + 10),
    );
  }

  Widget _buildEmptyState(CustomColors colors, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: colors.primaryContainer,
        borderRadius: BorderRadius.circular(SizesManager.cardCircularBorderRadius),
        border: Border.all(color: colors.onBackground.withOpacity(0.04), width: 1.2),
      ),
      child: Column(
        children: [
          Icon(Icons.assignment_outlined, size: 48, color: colors.onBackground.withOpacity(0.2)),
          const SizedBox(height: 12),
          Text(
            'No sessions yet today',
            style: theme.textTheme.titleSmall?.copyWith(
              color: colors.onBackground.withOpacity(0.4),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Launch an assessment above to begin.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: colors.onBackground.withOpacity(0.3),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, ThemeData theme, CustomColors colors,
      {Widget? trailing}) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 18,
          decoration: BoxDecoration(
            color: CustomColors.primetelRed,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w900,
            color: colors.primary,
          ),
        ),
        if (trailing != null) ...[const Spacer(), trailing],
      ],
    );
  }

  // ── Helpers ────────────────────────────────────────────────────────────────

  String _greeting() {
    final h = DateTime.now().hour;
    if (h < 12) return 'morning';
    if (h < 17) return 'afternoon';
    return 'evening';
  }

  String _todayString() {
    final now = DateTime.now();
    const days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${days[now.weekday - 1]}, ${now.day} ${months[now.month - 1]} ${now.year}';
  }

  String _timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }

  Color _severityColor(String severity, CustomColors colors) {
    switch (severity.toLowerCase()) {
      case 'minimal':
      case 'normal':
      case 'low risk':
      case 'below threshold':
        return colors.green;
      case 'mild':
      case 'moderate risk':
      case 'probable cmd':
        return colors.yellow;
      case 'moderate':
      case 'elevated risk':
        return colors.orange;
      case 'moderately severe':
      case 'severe':
      case 'high risk':
      case 'moderate ptsd':
      case 'likely cmd':
        return CustomColors.primetelRed;
      case 'extremely severe':
        return CustomColors.primetelRedDark;
      default:
        return colors.grey;
    }
  }
}

class _AssessmentInfo {
  final String name;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String duration;
  final String code;
  const _AssessmentInfo(this.name, this.subtitle, this.icon, this.color, this.duration, this.code);
}
