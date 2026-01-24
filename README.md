# 🧠 Sukun: AI-Powered Mental Health Ecosystem

> **"To democratize mental health care using machine learning."**

Sukun is a comprehensive mental health application designed to bridge the gap between self-care and professional therapy. Built as a capstone project, it aims to leverage **Machine Learning (ML)** and **Artificial Intelligence (AI)** to provide personalized, proactive, and accessible mental health support for everyone.

---

## 🚀 Project Mission (Capstone)

**Research Topic:** *Applying Natural Language Processing and Time-Series Forecasting for Personalized Mental Health Insights: A Mobile Application Approach*

Sukun moves beyond traditional tracking by using data to understand the user. The goal is to build an intelligent companion that doesn't just record data, but *understands* it—predicting mood shifts, identifying stress patterns from voice/text journals, and offering timely interventions before a crisis occurs.

---

## ✨ Current Features

### 📊 Clinical-Grade Assessments
Digital implementation of standardized psychological tools:
- **PHQ-9**: Depression Health Questionnaire.
- **DASS-21**: Depression, Anxiety, and Stress scale.
- **ASQ**: Ask Suicide-Screening Questions for immediate risk detection.

### 📝 Intelligent Journaling
- **Text Journaling**: Rich text editor with prompts to guide reflection.
- **Voice Journaling**: Audio recording for easier expression (~*Planned: Voice Emotion Analytics*~).
- **Secure Storage**: Local-first architecture ensuring privacy.

### 🧘‍♀️ Therapeutic Tools
- **Breathing Exercises**: Customizable patterns (Box breathing, 4-7-8, etc.) with visual guides.
- **Relaxation Techniques**: Guided mindfulness and grounding exercises.
- **Habit Tracking**: Monitor daily wellness routines (sleep, water, medication).

### 🤝 Professional Support
- **Therapist Finder**: Directory to find and connect with specialists.
- **Session Management**: Book and view upcoming therapy sessions.
- **Secure Messaging**: Private channel for patient-doctor communication.

### 🤖 AI Companion
- **AI Chatbot**: 24/7 conversational support for immediate emotional grounding (Rule-based/LLM hybrid).

---

## 🧠 Machine Learning Roadmap (Capstone Goals)

These features are currently in research/development as part of the specialized ML curriculum:

1.  **NLP Sentiment Analysis on Journals**
    *   *Goal*: Analyze text entries to detect underlying emotional tone (Positive, Negative, Neutral, Anxious).
    *   *Tech*: BERT/TensorFlow Lite.

2.  **Predictive Mood Analytics**
    *   *Goal*: Forecast future mood trends based on historical data, sleep patterns, and activity.
    *   *Tech*: Time-series forecasting (LSTM/ARIMA).

3.  **Voice Emotion Recognition**
    *   *Goal*: Analyze vocal prosody (pitch, tone, speed) in voice journals to detect stress or sadness invisible in text.
    *   *Tech*: Audio classification models.

4.  **Smart Crisis Detection**
    *   *Goal*: Real-time anomaly detection to identify sudden drops in well-being and trigger safety protocols/ASQ screenings.

---

## 🛠️ Tech Stack

- **Framework**: Flutter (Dart)
- **State Management**: Provider
- **Local Database**: SQLite (sqflite)
- **Architecture**: Feature-first, Clean Architecture principles
- **UI Kit**: Custom implementation inspired by Freud UI Kit

---

## 📂 Project Structure

```
lib/
├── features/           # Feature-based modular architecture
│   ├── auth/           # Authentication & Onboarding
│   ├── chatbot/        # AI Chat Interface
│   ├── doctor/         # Doctor Portal & Messaging
│   ├── exercises/      # Breathing & Relaxation Tools
│   ├── health_assess/  # PHQ-9, DASS-21, ASQ Implementation
│   ├── insights/       # Data Visualization & Analytics
│   ├── journal/        # Text & Voice Journaling
│   ├── mood_tracking/  # Mood Logging Logic
│   └── ...
├── core/               # Shared utilities, services, and widgets
└── main.dart           # App Entry Point
```

---

## 🤝 Contribution & Usage

This project is currently under active development for a university capstone requirements.
For inquiries, please contact: **Joak Buoy Gai** (b.joak@alustudent.com)
