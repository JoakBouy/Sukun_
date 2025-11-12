# Mental Health Assessment Screens Documentation

## Overview

Three standalone assessment questionnaires have been integrated into Sukun, accessible from the home screen. These are separate from the onboarding assessments and can be taken on-demand by users.

---

## 1. PHQ-9: Patient Health Questionnaire - Depression

### Purpose
Measures the severity of depression symptoms based on DSM-IV criteria.

### Features
- **Questions**: 9 items
- **Duration**: ~3 minutes
- **Scoring**: 0-27 (higher = more severe)
- **Response Options**: Not at all, Several days, More than half the days, Nearly every day

### Score Interpretation
- **0-4**: Minimal depression
- **5-9**: Mild depression
- **10-14**: Moderate depression
- **15-19**: Moderately severe depression
- **20+**: Severe depression

### File Location
```
lib/features/health_assessment/presentation/screens/phq9_assessment_screen.dart
```

### Route
```dart
NavigationManager.phq9AssessmentScreen
```

### Example Usage
```dart
Navigator.pushNamed(context, NavigationManager.phq9AssessmentScreen);
```

---

## 2. DASS-21: Depression Anxiety Stress Scales

### Purpose
Comprehensive assessment measuring three related emotional states: depression, anxiety, and stress.

### Features
- **Questions**: 21 items
- **Duration**: ~5 minutes
- **Subscales**: 
  - Depression (7 items)
  - Anxiety (7 items)
  - Stress (7 items)
- **Scoring**: Each subscale 0-42 (multiplied by 2 for raw score)

### Score Interpretation
Each subscale has its own ranges:

**Depression:**
- 0-9: Normal
- 10-13: Mild
- 14-20: Moderate
- 21-27: Severe
- 28+: Extremely Severe

**Anxiety:**
- 0-7: Normal
- 8-9: Mild
- 10-14: Moderate
- 15-19: Severe
- 20+: Extremely Severe

**Stress:**
- 0-14: Normal
- 15-18: Mild
- 19-25: Moderate
- 26-33: Severe
- 34+: Extremely Severe

### File Location
```
lib/features/health_assessment/presentation/screens/dass21_assessment_screen.dart
```

### Route
```dart
NavigationManager.dass21AssessmentScreen
```

### Example Usage
```dart
Navigator.pushNamed(context, NavigationManager.dass21AssessmentScreen);
```

---

## 3. ASQ: Ask Suicide Screening Questions

### Purpose
Rapid assessment tool to identify suicide risk using 4 key screening questions.

### Features
- **Questions**: 4 items
- **Duration**: ~2 minutes
- **Response Options**: Yes / No
- **Focus**: Suicide ideation, intent, and history

### Risk Levels
- **0 Yes answers**: Low Risk
- **1 Yes answer**: Moderate Risk
- **2 Yes answers**: Elevated Risk
- **3+ Yes answers**: High Risk

### Critical Features
- **High Risk Protocol**: When 2+ items are endorsed:
  - Prominent warning display
  - Direct links to crisis resources
  - "Get Immediate Help" button
  - Crisis hotline information

### Crisis Resources Included
- National Suicide Prevention Lifeline: 1-800-273-8255
- Crisis Text Line: Text HOME to 741741
- International Association for Suicide Prevention: https://www.iasp.info/resources/Crisis_Centres/

### File Location
```
lib/features/health_assessment/presentation/screens/asq_assessment_screen.dart
```

### Route
```dart
NavigationManager.asqAssessmentScreen
```

### Example Usage
```dart
Navigator.pushNamed(context, NavigationManager.asqAssessmentScreen);
```

---

## Assessment Question Card Widget

### Location
```
lib/features/health_assessment/presentation/widgets/assessment_question_card.dart
```

### Features
- Customizable question display
- Multiple choice options with visual selection
- Question number indicator
- Color-coded by category
- Smooth animations

### Usage
```dart
AssessmentQuestionCard(
  questionNumber: 1,
  question: 'Your question here',
  options: ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
  selectedAnswer: _answers[0],
  onAnswerSelected: (answer) {
    setState(() => _answers[0] = answer);
  },
  accentColor: const Color(0xFF9BB068),
)
```

---

## Assessment Card Widget

### Location
```
lib/features/home/presentation/widgets/assessment_card.dart
```

### Features
- Displays assessment on home screen
- Icon with color coding
- Title and description
- Optional "Last taken" date
- Tap to launch assessment

### Usage
```dart
AssessmentCard(
  title: 'PHQ-9 Depression Scale',
  subtitle: '9 questions • ~3 min',
  description: 'Evaluate your depression symptoms...',
  icon: Icons.sentiment_very_dissatisfied,
  accentColor: const Color(0xFF9BB068),
  lastTaken: '2 weeks ago',
  onTap: () {
    Navigator.pushNamed(context, NavigationManager.phq9AssessmentScreen);
  },
)
```

---

## Home Screen Integration

### Assessments Section
The home screen now includes a dedicated "Mental Health Assessments" section featuring:

1. **PHQ-9 Card** - Green (#9BB068)
2. **DASS-21 Card** - Orange (#ED7E1C)
3. **ASQ Card** - Red

### Color Coding
```dart
const Color phq9Color = Color(0xFF9BB068);   // Green - Depression
const Color dass21Color = Color(0xFFED7E1C); // Orange - Multi-scale
const Color asqColor = Colors.red;            // Red - Suicide Risk
```

---

## User Flow

1. User views home screen
2. Sees "Mental Health Assessments" section with 3 cards
3. Taps on desired assessment
4. Navigates to full-screen assessment
5. Completes questions with page-based navigation
6. Receives results with:
   - Score display
   - Interpretation
   - Recommendations
   - Crisis resources (if applicable)
7. Options to:
   - Return to home
   - Retake assessment
   - Book consultation
   - Access crisis support (if high risk)

---

## Navigation Manager Updates

New routes added:
```dart
static const String phq9AssessmentScreen = '/phq9Assessment';
static const String dass21AssessmentScreen = '/dass21Assessment';
static const String asqAssessmentScreen = '/asqAssessment';
```

New screen imports:
```dart
import 'package:freud_ai/features/health_assessment/presentation/screens/phq9_assessment_screen.dart';
import 'package:freud_ai/features/health_assessment/presentation/screens/dass21_assessment_screen.dart';
import 'package:freud_ai/features/health_assessment/presentation/screens/asq_assessment_screen.dart';
```

---

## Data Storage (Future Implementation)

Current implementation shows sample data. For production, integrate:

```dart
// Store assessment results
final assessmentResult = {
  'type': 'PHQ9',
  'score': 15,
  'level': 'Moderate',
  'timestamp': DateTime.now(),
  'answers': _answers,
};

// Save to local storage or backend
await assessmentService.saveResult(assessmentResult);

// Retrieve history
final history = await assessmentService.getAssessmentHistory();
```

---

## Accessibility

All assessments support:
- Clear question presentation
- Large touch targets (48dp minimum)
- High contrast colors
- Screen reader friendly
- Semantic labels
- Easy navigation between questions

---

## Performance Considerations

- Page-based navigation for smooth transitions
- Minimal rebuilds with setState
- Lazy loading of results
- Optimized layouts for all screen sizes

---

## Testing

### Unit Tests
```dart
test('PHQ9 score calculation', () {
  final score = calculatePHQ9Score(_answers);
  expect(score, isNotNull);
});

test('DASS21 subscale separation', () {
  final depression = calculateDepressionScore(_answers);
  expect(depression, isNotNull);
});
```

### Widget Tests
```dart
testWidgets('Assessment screen displays questions', (tester) async {
  await tester.pumpWidget(const PHQ9AssessmentScreen());
  expect(find.text('Question 1'), findsOneWidget);
});
```

---

## Future Enhancements

1. **History Tracking**: Store and display previous assessment results
2. **Progress Charts**: Visualize trends over time
3. **Sharing**: Export results to PDF or email
4. **Therapist Integration**: Share results with assigned therapist
5. **Reminders**: Prompt users to retake assessments periodically
6. **AI Analysis**: Generate insights based on patterns
7. **Personalized Recommendations**: Suggest resources based on scores

---

## API Integration (When Ready)

```dart
// Save assessment result
POST /api/assessments
{
  "userId": "user_id",
  "type": "PHQ9",
  "score": 15,
  "level": "Moderate",
  "answers": [...],
  "timestamp": "2025-11-12T10:30:00Z"
}

// Get assessment history
GET /api/assessments/history?userId=user_id

// Get latest results
GET /api/assessments/latest?userId=user_id&type=PHQ9
```

---

## Crisis Support Integration

When ASQ indicates high risk (2+ positive responses):
1. Display prominent warning
2. Show crisis resources
3. Provide "Get Immediate Help" button
4. Link to crisis support screen
5. Consider automatic notifications to therapist

---

**Last Updated**: November 12, 2025
**Status**: Ready for Integration
