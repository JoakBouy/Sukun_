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
  String _selectedInsurance = 'All';
  String _selectedAvailability = 'All';
  RangeValues _priceRange = const RangeValues(50, 200);
  double _minRating = 0.0;
  bool _showAdvancedFilters = false;

  final List<String> _specialties = [
    'All',
    'Anxiety',
    'Depression',
    'Trauma',
    'PTSD',
    'Relationship',
    'Marriage Counseling',
    'Addiction',
    'LGBTQ+',
    'Eating Disorders',
    'OCD',
    'Bipolar Disorder',
    'ADHD',
    'Grief & Loss',
    'Stress Management',
    'Self-Esteem',
  ];

  final List<String> _insuranceOptions = [
    'All',
    'Aetna',
    'Blue Cross Blue Shield',
    'Cigna',
    'UnitedHealthcare',
    'Anthem',
    'Humana',
    'Kaiser Permanente',
    'Medicare',
    'Self-Pay Only',
  ];

  final List<String> _availabilityOptions = [
    'All',
    'Available Now',
    'Today',
    'This Week',
    'Next Week',
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

                // Advanced Filters Toggle
                Row(
                  children: [
                    Text(
                      'Filters',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colors.primary,
                      ),
                    ),
                    const Spacer(),
                    TextButton.icon(
                      onPressed: () {
                        setState(() => _showAdvancedFilters = !_showAdvancedFilters);
                      },
                      icon: Icon(
                        _showAdvancedFilters ? Icons.expand_less : Icons.expand_more,
                        color: colors.primary,
                      ),
                      label: Text(
                        _showAdvancedFilters ? 'Less' : 'More',
                        style: TextStyle(color: colors.primary),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: SizesManager.hPadding),

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
                          backgroundColor: isSelected ? colors.primary.withOpacity(0.1) : null,
                          selectedColor: colors.primary.withOpacity(0.2),
                          checkmarkColor: colors.primary,
                        ),
                      );
                    },
                  ),
                ),

                // Advanced Filters
                if (_showAdvancedFilters) ...[
                  const SizedBox(height: SizesManager.padding),

                  // Insurance Filter
                  _buildFilterSection(
                    title: 'Insurance Accepted',
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _insuranceOptions.map((insurance) {
                        final isSelected = _selectedInsurance == insurance;
                        return FilterChip(
                          label: Text(
                            insurance,
                            style: TextStyle(
                              fontSize: 12,
                              color: isSelected ? colors.primaryContainer : colors.primary,
                            ),
                          ),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              _selectedInsurance = insurance;
                            });
                          },
                          backgroundColor: isSelected ? colors.primary.withOpacity(0.1) : null,
                          selectedColor: colors.primary.withOpacity(0.2),
                          checkmarkColor: colors.primary,
                        );
                      }).toList(),
                    ),
                  ),

                  // Availability Filter
                  _buildFilterSection(
                    title: 'Availability',
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _availabilityOptions.map((availability) {
                        final isSelected = _selectedAvailability == availability;
                        return FilterChip(
                          label: Text(
                            availability,
                            style: TextStyle(
                              fontSize: 12,
                              color: isSelected ? colors.primaryContainer : colors.primary,
                            ),
                          ),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              _selectedAvailability = availability;
                            });
                          },
                          backgroundColor: isSelected ? colors.primary.withOpacity(0.1) : null,
                          selectedColor: colors.primary.withOpacity(0.2),
                          checkmarkColor: colors.primary,
                        );
                      }).toList(),
                    ),
                  ),

                  // Price Range Filter
                  _buildFilterSection(
                    title: 'Price Range: \$${_priceRange.start.round()} - \$${_priceRange.end.round()}/session',
                    child: RangeSlider(
                      values: _priceRange,
                      min: 0,
                      max: 300,
                      divisions: 30,
                      labels: RangeLabels(
                        '\$${_priceRange.start.round()}',
                        '\$${_priceRange.end.round()}',
                      ),
                      onChanged: (RangeValues values) {
                        setState(() {
                          _priceRange = values;
                        });
                      },
                      activeColor: colors.primary,
                      inactiveColor: colors.primary.withOpacity(0.3),
                    ),
                  ),

                  // Minimum Rating Filter
                  _buildFilterSection(
                    title: 'Minimum Rating: ${_minRating.toStringAsFixed(1)} stars',
                    child: Slider(
                      value: _minRating,
                      min: 0.0,
                      max: 5.0,
                      divisions: 10,
                      label: _minRating.toStringAsFixed(1),
                      onChanged: (double value) {
                        setState(() {
                          _minRating = value;
                        });
                      },
                      activeColor: colors.primary,
                      inactiveColor: colors.primary.withOpacity(0.3),
                    ),
                  ),

                  // Clear All Filters
                  const SizedBox(height: SizesManager.padding),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          _selectedSpecialty = 'All';
                          _selectedInsurance = 'All';
                          _selectedAvailability = 'All';
                          _priceRange = const RangeValues(50, 200);
                          _minRating = 0.0;
                          _searchController.clear();
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: colors.primary),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(
                        'Clear All Filters',
                        style: TextStyle(color: colors.primary),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          Expanded(
            child: _buildFilteredTherapistList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection({required String title, required Widget child}) {
    final theme = Theme.of(context);
    final colors = theme.extension<CustomColors>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: colors.primary,
          ),
        ),
        const SizedBox(height: 8),
        child,
        const SizedBox(height: SizesManager.padding),
      ],
    );
  }

  Widget _buildFilteredTherapistList() {
    // Mock therapist data with different attributes for filtering
    final List<Map<String, dynamic>> therapists = [
      {
        'id': 'therapist_1',
        'name': 'Dr. Sarah Johnson',
        'specialty': 'Anxiety & Depression',
        'rating': 4.8,
        'experience': '8 years',
        'insurance': ['Aetna', 'Blue Cross Blue Shield'],
        'price': 150,
        'availability': 'Available Now',
        'specialties': ['Anxiety', 'Depression'],
      },
      {
        'id': 'therapist_2',
        'name': 'Dr. Michael Chen',
        'specialty': 'Trauma & PTSD',
        'rating': 4.9,
        'experience': '12 years',
        'insurance': ['Cigna', 'UnitedHealthcare'],
        'price': 180,
        'availability': 'Available Now',
        'specialties': ['Trauma', 'PTSD'],
      },
      {
        'id': 'therapist_3',
        'name': 'Dr. Emily Rodriguez',
        'specialty': 'Relationship Counseling',
        'rating': 4.7,
        'experience': '6 years',
        'insurance': ['Aetna', 'Anthem'],
        'price': 120,
        'availability': 'Today',
        'specialties': ['Relationship', 'Marriage Counseling'],
      },
      {
        'id': 'therapist_4',
        'name': 'Dr. James Wilson',
        'specialty': 'Addiction Recovery',
        'rating': 4.6,
        'experience': '15 years',
        'insurance': ['Humana', 'Kaiser Permanente'],
        'price': 140,
        'availability': 'This Week',
        'specialties': ['Addiction'],
      },
      {
        'id': 'therapist_5',
        'name': 'Dr. Lisa Thompson',
        'specialty': 'LGBTQ+ Mental Health',
        'rating': 4.9,
        'experience': '10 years',
        'insurance': ['Aetna', 'Blue Cross Blue Shield', 'Cigna'],
        'price': 160,
        'availability': 'Next Week',
        'specialties': ['LGBTQ+'],
      },
      {
        'id': 'therapist_6',
        'name': 'Dr. Robert Davis',
        'specialty': 'OCD & Anxiety',
        'rating': 4.8,
        'experience': '9 years',
        'insurance': ['UnitedHealthcare', 'Medicare'],
        'price': 130,
        'availability': 'Available Now',
        'specialties': ['OCD', 'Anxiety'],
      },
    ];

    // Apply filters
    final filteredTherapists = therapists.where((therapist) {
      // Search filter
      final searchQuery = _searchController.text.toLowerCase();
      if (searchQuery.isNotEmpty) {
        final nameMatch = therapist['name'].toString().toLowerCase().contains(searchQuery);
        final specialtyMatch = therapist['specialty'].toString().toLowerCase().contains(searchQuery);
        if (!nameMatch && !specialtyMatch) return false;
      }

      // Specialty filter
      if (_selectedSpecialty != 'All') {
        final therapistSpecialties = therapist['specialties'] as List<String>;
        if (!therapistSpecialties.contains(_selectedSpecialty)) return false;
      }

      // Insurance filter
      if (_selectedInsurance != 'All') {
        final therapistInsurance = therapist['insurance'] as List<String>;
        if (!therapistInsurance.contains(_selectedInsurance)) return false;
      }

      // Availability filter
      if (_selectedAvailability != 'All') {
        if (therapist['availability'] != _selectedAvailability) return false;
      }

      // Price range filter
      final price = therapist['price'] as int;
      if (price < _priceRange.start || price > _priceRange.end) return false;

      // Rating filter
      final rating = therapist['rating'] as double;
      if (rating < _minRating) return false;

      return true;
    }).toList();

    if (filteredTherapists.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.search_off,
                size: 64,
                color: Theme.of(context).extension<CustomColors>()!.onPrimaryContainer.withOpacity(0.5),
              ),
              const SizedBox(height: 16),
              Text(
                'No therapists found',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Theme.of(context).extension<CustomColors>()!.primary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Try adjusting your filters or search terms',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).extension<CustomColors>()!.onPrimaryContainer,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    _selectedSpecialty = 'All';
                    _selectedInsurance = 'All';
                    _selectedAvailability = 'All';
                    _priceRange = const RangeValues(50, 200);
                    _minRating = 0.0;
                    _searchController.clear();
                  });
                },
                child: const Text('Clear All Filters'),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: SizesManager.padding),
      itemCount: filteredTherapists.length,
      itemBuilder: (context, index) {
        final therapist = filteredTherapists[index];
        return TherapistCard(
          therapistId: therapist['id'],
          name: therapist['name'],
          specialty: therapist['specialty'],
          rating: therapist['rating'],
          experience: therapist['experience'],
          availableNow: therapist['availability'] == 'Available Now',
        );
      },
    );
  }
}
