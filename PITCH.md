# AI-Based Personalized Study Planner: hackathon pitch

**Team member:** Rayolla Saisindhu · B.Tech CSE · Java Full Stack + AI

## Problem
Students study without a plan: they spend time on subjects they already know, leave weak subjects
and approaching exams too late, and never measure whether their routine works.

## Solution
A planner that builds a personalised 7-day timetable from each student's subjects, difficulty,
exam dates, test scores, available time and feedback, and keeps adapting it as the student progresses.

## What makes it "AI"
An explainable recommendation engine (`RecommendationEngine.java`):
- **Performance analysis:** recency-weighted average score, trend (improving / declining) and weak-area detection.
- **Priority scoring:** `(0.25 difficulty + 0.35 weakness + 0.25 exam urgency + 0.15 pending tasks) x feedback weight`.
- **Time allocation:** the daily time budget is shared out in proportion to priority.
- **Feedback loop:** "Too easy / Just right / Too hard" after each session re-balances upcoming days.
- **Explainability:** every session shows *why* it was scheduled (e.g. "exam in 6 days, weak area (avg 45%)").

## Features
Registration and login (BCrypt) · academic profile · subjects with difficulty and exam date · test-score logging ·
7-day plan · session completion with feedback · tasks linked to subjects · reminders · progress and insights ·
streaks and badges · one-click demo data.

## Architecture
React (Vite) -> REST API (Spring Boot) -> MySQL.
Layers: controller -> service -> repository (Spring Data JPA); AI layer in `study_planner.ai`.

## 3-minute demo script
1. Register and log in. Click **Load demo data**. Four subjects, scores, tasks and a plan appear.
2. **Plan** tab: Mathematics (hard, weak, exam in 6 days) gets the most time. Point at the "Why" line under each session.
3. **Subjects**: log a high Mathematics score. The plan re-balances instantly.
4. **Plan**: mark a session done and choose "Too hard". Tomorrow's Mathematics time increases.
5. **Progress**: show the performance analysis, advice and streak. **Overview**: reminders.
6. **Profile**: change daily hours to 5. The plan is rebuilt.

## Future scope
JWT authentication, calendar and email/push reminders, a machine-learning model trained on real
study logs, spaced-repetition scheduling, mobile app, mentor and parent dashboards.
