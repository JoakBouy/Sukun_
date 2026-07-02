import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/features/clinician/data/services/clinician_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MonthlyReportScreen extends StatefulWidget {
  const MonthlyReportScreen({super.key});
  @override
  State<MonthlyReportScreen> createState() => _MonthlyReportScreenState();
}

class _MonthlyReportScreenState extends State<MonthlyReportScreen> {
  String _reportText = '';
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _generate();
  }

  Future<void> _generate() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('clinician_name') ?? 'Clinician';
    try {
      final text = await ClinicianService.instance.generateMonthlyReport(clinicianName: name);
      if (mounted) setState(() { _reportText = text; _loading = false; });
    } catch (_) {
      if (mounted) setState(() {
        _reportText = 'Monthly report could not be generated (no data yet). Complete assessments and outreach events to populate this report.';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: const Text('Monthly Report', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0, backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.copy),
            tooltip: 'Copy report',
            onPressed: () {
              Clipboard.setData(ClipboardData(text: _reportText));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Report copied — paste into email or WhatsApp'),
                  backgroundColor: CustomColors.primetelRed,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () { setState(() { _loading = true; _reportText = ''; }); _generate(); },
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: CustomColors.primetelRed))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(SizesManager.padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: CustomColors.primetelRedLight,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.summarize, color: CustomColors.primetelRed),
                        const SizedBox(width: 10),
                        Expanded(child: Text(
                          'Auto-generated from your session records. Tap copy to share with Primetel leadership.',
                          style: theme.textTheme.bodySmall?.copyWith(color: CustomColors.primetelRed),
                        )),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: colors.primaryContainer,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(_reportText,
                        style: TextStyle(fontFamily: 'monospace', fontSize: 13, color: colors.onBackground, height: 1.7)),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: _reportText));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Report copied to clipboard'),
                            backgroundColor: CustomColors.primetelRed,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                        );
                      },
                      icon: const Icon(Icons.copy_all, color: Colors.white),
                      label: const Text('Copy Full Report', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColors.primetelRed,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
    );
  }
}
