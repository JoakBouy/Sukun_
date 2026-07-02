/// Model for outreach events logged by Primetel psychologists
class OutreachEvent {
  final String id;
  final String eventType; // 'Mobile Clinic', 'School Program', 'Community', 'Workplace'
  final String location;
  final double? latitude;
  final double? longitude;
  final int peopleReached;
  final int referralsMade;
  final String? notes;
  final DateTime date;

  const OutreachEvent({
    required this.id,
    required this.eventType,
    required this.location,
    this.latitude,
    this.longitude,
    required this.peopleReached,
    required this.referralsMade,
    this.notes,
    required this.date,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'event_type': eventType,
    'location': location,
    'latitude': latitude,
    'longitude': longitude,
    'people_reached': peopleReached,
    'referrals_made': referralsMade,
    'notes': notes,
    'date': date.millisecondsSinceEpoch,
  };

  factory OutreachEvent.fromMap(Map<String, dynamic> map) => OutreachEvent(
    id: map['id'] as String,
    eventType: map['event_type'] as String,
    location: map['location'] as String,
    latitude: map['latitude'] as double?,
    longitude: map['longitude'] as double?,
    peopleReached: map['people_reached'] as int,
    referralsMade: map['referrals_made'] as int,
    notes: map['notes'] as String?,
    date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
  );
}
