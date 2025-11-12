import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/core/managers/strings_manager.dart';
import 'package:freud_ai/features/therapist/presentation/widgets/therapist_card.dart';

class FindTherapistScreen extends StatefulWidget {
  const FindTherapistScreen({super.key});

  @override
  State<FindTherapistScreen> createState() => _FindTherapistScreenState();
}

class _FindTherapistScreenState extends State<FindTherapistScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedSpecialty = 'All';

  final List<String> _specialties = [
    'All',
    'Anxiety',
    'Depression',
    'Trauma',
    'Relationship',
    'Addiction',
    'LGBTQ+',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final CustomColors colors = theme.extension<CustomColors>()!;

    return Scaffold(
      appBar: AppBar(
        title: const Text(StringsManager.therapistTitle),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(SizesManager.padding),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: StringsManager.searchTherapists,
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(SizesManager.cardCircularBorderRadius),
                    ),
                    filled: true,
                    fillColor: colors.background,
                  ),
                ),
                const SizedBox(height: SizesManager.padding),
                // Specialty Filter
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _specialties.length,
                    itemBuilder: (context, index) {
                      final specialty = _specialties[index];
                      final isSelected = _selectedSpecialty == specialty;
                      return Padding(
                        padding: const EdgeInsets.only(right: SizesManager.hPadding),
                        child: FilterChip(
                          label: Text(specialty),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              _selectedSpecialty = specialty;
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: SizesManager.padding),
              itemCount: 5, // Mock data
              itemBuilder: (context, index) {
                return TherapistCard(
                  name: 'Dr. Sarah Johnson',
                  specialty: 'Anxiety & Depression',
                  rating: 4.8,
                  experience: '5 years',
                  availableNow: index < 2,
                  onTap: () {
                    // Navigate to therapist profile
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

