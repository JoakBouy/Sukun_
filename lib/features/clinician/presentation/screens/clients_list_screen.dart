import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/core/utils/animation_utils.dart';
import 'package:freud_ai/core/widgets/glass_container.dart';
import 'package:freud_ai/features/clinician/data/models/client_session.dart';
import 'package:freud_ai/features/clinician/data/services/clinician_service.dart';
import 'package:freud_ai/features/clinician/presentation/screens/client_detail_screen.dart';

class ClientsListScreen extends StatefulWidget {
  const ClientsListScreen({super.key});
  @override
  State<ClientsListScreen> createState() => _ClientsListScreenState();
}

class _ClientsListScreenState extends State<ClientsListScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final _service = ClinicianService.instance;
  List<Map<String, dynamic>> _clients = [];
  String _searchQuery = '';
  String _filter = 'All'; // All, Crisis
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final clients = await _service.getAllClients();
      if (mounted) setState(() { _clients = clients; _loading = false; });
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  List<Map<String, dynamic>> get _filtered {
    return _clients.where((c) {
      final matchesSearch = (c['client_identifier'] as String)
          .toLowerCase().contains(_searchQuery.toLowerCase());
      if (!matchesSearch) return false;
      if (_filter == 'Crisis') return (c['crisis_count'] as int? ?? 0) > 0;
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final colors = Theme.of(context).extension<CustomColors>()!;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            Container(width: 4, height: 20,
                decoration: BoxDecoration(color: CustomColors.primetelRed, borderRadius: BorderRadius.circular(2))),
            const SizedBox(width: 10),
            Text('Clients', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: colors.primary)),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(color: CustomColors.primetelRedLight, borderRadius: BorderRadius.circular(20)),
              child: Text('${_clients.length}',
                  style: const TextStyle(color: CustomColors.primetelRed, fontWeight: FontWeight.bold, fontSize: 12)),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Column(
              children: [
                // Premium search bar
                TextField(
                  onChanged: (v) => setState(() => _searchQuery = v),
                  decoration: InputDecoration(
                    hintText: 'Search clients by ID or name...',
                    prefixIcon: const Icon(Icons.search, color: CustomColors.primetelRed),
                    filled: true,
                    fillColor: colors.primaryContainer,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(color: CustomColors.primetelRed, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: ['All', 'Crisis'].map((f) => Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(f),
                      selected: _filter == f,
                      onSelected: (_) => setState(() => _filter = f),
                      selectedColor: CustomColors.primetelRedLight,
                      checkmarkColor: CustomColors.primetelRed,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      labelStyle: TextStyle(
                        color: _filter == f ? CustomColors.primetelRed : colors.onBackground,
                        fontWeight: _filter == f ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  )).toList(),
                ),
              ],
            ),
          ),

          Expanded(
            child: _loading
                ? const Center(child: CircularProgressIndicator(color: CustomColors.primetelRed))
                : _filtered.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.people_outline, size: 64, color: colors.onBackground.withOpacity(0.2)),
                            const SizedBox(height: 16),
                            Text('No clients yet', style: theme.textTheme.titleMedium?.copyWith(
                              color: colors.onBackground.withOpacity(0.4))),
                            Text('Start an assessment to add clients',
                                style: theme.textTheme.bodySmall?.copyWith(color: colors.onBackground.withOpacity(0.3))),
                          ],
                        ),
                      )
                    : RefreshIndicator(
                        color: CustomColors.primetelRed,
                        onRefresh: _load,
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: _filtered.length,
                          itemBuilder: (ctx, i) => _buildClientCard(_filtered[i], colors, theme, i),
                        ),
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildClientCard(Map<String, dynamic> client, CustomColors colors, ThemeData theme, int index) {
    final hasCrisis = (client['crisis_count'] as int? ?? 0) > 0;
    final lastSeverity = client['last_severity'] as String? ?? '';
    final sessCount = client['session_count'] as int? ?? 0;
    final lastSeen = client['last_seen'] as int?;
    final lastAssessment = client['last_assessment'] as String? ?? '';
    final clientId = client['client_identifier'] as String;

    final sevColor = _sevColor(lastSeverity, colors);

    return AnimatedPressable(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ClientDetailScreen(clientIdentifier: clientId)),
      ).then((_) => _load()),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colors.primaryContainer,
          borderRadius: BorderRadius.circular(SizesManager.cardCircularBorderRadius),
          border: Border.all(
            color: hasCrisis 
                ? CustomColors.primetelRed.withOpacity(0.4) 
                : colors.onBackground.withOpacity(0.04),
            width: hasCrisis ? 1.5 : 1,
          ),
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
            Stack(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: sevColor.withOpacity(0.12),
                  child: Text(
                    clientId.isNotEmpty ? clientId[0].toUpperCase() : '?',
                    style: TextStyle(color: sevColor, fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                if (hasCrisis)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: const BoxDecoration(
                        color: CustomColors.primetelRed,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.warning, color: Colors.white, size: 9),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(clientId,
                      style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold, color: colors.primary)),
                  const SizedBox(height: 3),
                  Text('$sessCount session${sessCount != 1 ? 's' : ''} · Last: $lastAssessment',
                      style: theme.textTheme.bodySmall?.copyWith(color: colors.onBackground.withOpacity(0.55))),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (lastSeverity.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: sevColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(lastSeverity,
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: sevColor)),
                  ),
                const SizedBox(height: 4),
                if (lastSeen != null)
                  Text(_timeAgo(DateTime.fromMillisecondsSinceEpoch(lastSeen)),
                      style: theme.textTheme.labelSmall?.copyWith(color: colors.onBackground.withOpacity(0.4))),
              ],
            ),
            const SizedBox(width: 4),
            Icon(Icons.chevron_right, color: colors.onBackground.withOpacity(0.25)),
          ],
        ),
      ).animateCardEntrance(index: index),
    );
  }

  Color _sevColor(String severity, CustomColors colors) {
    switch (severity.toLowerCase()) {
      case 'minimal': case 'normal': case 'below threshold': return colors.green;
      case 'mild': return colors.yellow;
      case 'moderate': return colors.orange;
      default: return CustomColors.primetelRed;
    }
  }

  String _timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inDays == 0) return 'Today';
    if (diff.inDays == 1) return 'Yesterday';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${diff.inDays ~/ 7}w ago';
  }
}
