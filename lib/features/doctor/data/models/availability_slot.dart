class AvailabilitySlot {
  final String id;
  final String doctorId;
  final int dayOfWeek; // 1 = Monday, 7 = Sunday
  final String startTime; // Format: "HH:mm"
  final String endTime; // Format: "HH:mm"
  final bool isAvailable;

  const AvailabilitySlot({
    required this.id,
    required this.doctorId,
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    required this.isAvailable,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'doctor_id': doctorId,
      'day_of_week': dayOfWeek,
      'start_time': startTime,
      'end_time': endTime,
      'is_available': isAvailable ? 1 : 0,
    };
  }

  factory AvailabilitySlot.fromJson(Map<String, dynamic> json) {
    return AvailabilitySlot(
      id: json['id'] as String,
      doctorId: json['doctor_id'] as String,
      dayOfWeek: json['day_of_week'] as int,
      startTime: json['start_time'] as String,
      endTime: json['end_time'] as String,
      isAvailable: (json['is_available'] as int) == 1,
    );
  }

  String get dayName {
    const days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    return days[dayOfWeek - 1];
  }

  AvailabilitySlot copyWith({
    String? id,
    String? doctorId,
    int? dayOfWeek,
    String? startTime,
    String? endTime,
    bool? isAvailable,
  }) {
    return AvailabilitySlot(
      id: id ?? this.id,
      doctorId: doctorId ?? this.doctorId,
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      isAvailable: isAvailable ?? this.isAvailable,
    );
  }
}
