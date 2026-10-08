# AI-Based Personalized Study Planner

Java Spring Boot (REST) + React + MySQL.

## Run
Backend (MySQL running; Java 21):
    set DB_PASSWORD=your_mysql_password     (Windows cmd)   |   export DB_PASSWORD=...  (Mac/Linux)
    mvnw.cmd spring-boot:run                |   ./mvnw spring-boot:run

Frontend:
    cd frontend
    npm install
    npm run dev          -> http://localhost:5173

## How the AI layer works (study_planner.ai.RecommendationEngine)
1. Data preprocessing: subjects, exam dates, difficulty, logged test scores (recency-weighted),
   pending tasks per subject, the student's daily time budget and preferred time slot.
2. Performance analysis: weighted average score, trend (improving/declining/steady), weak areas (<60%).
3. Priority scoring:
   priority = (0.25*difficulty + 0.35*weakness + 0.25*examUrgency + 0.15*pendingWork) * feedbackWeight
4. Plan generation: each day's time is split between subjects in proportion to priority (min 20 min
   sessions, 10 min breaks), for 7 days. Past exams are skipped. Every session explains "why".
5. Feedback loop: after a session the student says Too easy / Just right / Too hard; this adjusts the
   subject's feedbackWeight and the coming days are re-planned. New test scores re-plan too.
6. Reminders: today's sessions, overdue/due tasks, exams within 7 days.

## API (all under /api, user id sent in X-User-Id header)
POST /register, /login · GET/PUT /profile · subjects CRUD + POST /subjects/{id}/scores
tasks CRUD + PUT /tasks/{id}/toggle · GET /plan, POST /plan/generate, PUT /plan/{id}/complete|undo
GET /insights, GET /reminders
