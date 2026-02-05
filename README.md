# DeepNote

DeepNote is an AI-driven, real-time query resolution system that turns raw web data into concise, context-aware answers. Built with a Flutter front end and a FastAPI backend, DeepNote combines web scraping, semantic search, and Large Language Models (LLMs) to provide up-to-date responses to user queries.

---

## Table of Contents

- [Key Features](#key-features)  
- [Architecture Overview](#architecture-overview)  
- [Tech Stack](#tech-stack)  
- [Quick Start](#quick-start)  
  - [Backend (FastAPI)](#backend-fastapi)  
  - [Frontend (Flutter)](#frontend-flutter)  
- [Environment Variables](#environment-variables)  
- [API](#api)  
- [Project Layout](#project-layout)  
- [Development & Testing](#development--testing)  
- [Contributing](#contributing)  
- [Roadmap](#roadmap)  
- [License & Contact](#license--contact)

---

## Key Features

- AI-generated, context-aware answers using LLMs  
- Semantic search over scraped web content for relevance ranking  
- Real-time web scraping to surface current information  
- Cross-platform UI built with Flutter (mobile & desktop)  
- Fast, async backend powered by FastAPI  
- Extensible modules for connectors, models, and search

---

## Architecture Overview

User → Flutter UI → FastAPI (Query router) → [Scraper(s) + Semantic Search + LLMs] → Aggregator → Response

- Frontend: collects queries and displays responses, source citations, and metadata.  
- Backend: orchestrates scraping, embedding/semantic search, LLM calls, caching, and response assembly.  
- Data flow is asynchronous to minimize latency and allow parallel scraping/search.

---

## Tech Stack

- Frontend: Flutter (Dart)  
- Backend: FastAPI (Python, async)  
- Search: Semantic embeddings + vector store (configurable)  
- LLMs: Pluggable (open models or API-based providers)  
- Optional: Redis (cache), PostgreSQL (metadata), Docker (deployment)

---

## Quick Start

Clone the repo and follow the backend and frontend steps below.

```bash
git clone https://github.com/shivansh00011/DeepNote.git
cd DeepNote
```

### Backend (FastAPI)

1. Create and activate a Python virtual environment:
   ```bash
   python -m venv venv
   source venv/bin/activate   # Windows: venv\Scripts\activate
   ```

2. Install dependencies:
   ```bash
   pip install -r backend/requirements.txt
   ```

3. Copy and edit env file:
   ```bash
   cp backend/.env.example backend/.env
   # edit backend/.env to include your API keys and settings
   ```

4. Run the server:
   ```bash
   cd backend
   uvicorn main:app --reload
   # default: http://localhost:8000
   ```

### Frontend (Flutter)

1. Open the Flutter app folder:
   ```bash
   cd flutter_app
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

---

## Environment Variables (example)

Place these in `backend/.env` (names are examples—match the code):

- OPENAI_API_KEY=...
- VECTOR_STORE_URL=...
- REDIS_URL=redis://localhost:6379
- SCRAPER_USER_AGENT="DeepNoteBot/1.0"
- DATABASE_URL=postgresql://user:pass@localhost:5432/deepnote

---

## API

Example: submit a query

POST /api/query
Content-Type: application/json

Request body:
```json
{
  "query": "What are the latest announcements from OpenAI?",
  "max_sources": 5
}
```

Example cURL:
```bash
curl -X POST http://localhost:8000/api/query \
  -H "Content-Type: application/json" \
  -d '{"query":"What are the latest announcements from OpenAI?","max_sources":5}'
```

Typical response:
```json
{
  "answer": "Summary produced by the LLM...",
  "sources": [
    {"title":"...", "url":"...", "snippet":"..."},
    {"title":"...", "url":"...", "snippet":"..."}
  ],
  "confidence": 0.87
}
```

Adjust endpoint routes and payloads to match the implementation in `backend/routes/`.

---

## Project Layout (recommended)

A representative layout — adjust to the repo's exact structure:

- backend/
  - main.py
  - requirements.txt
  - routes/
  - services/
    - query_processor.py
    - web_scraper.py
    - semantic_search.py
    - llm_handler.py
  - config/
  - tests/
- flutter_app/
  - lib/
    - main.dart
    - screens/
    - widgets/
    - services/
  - pubspec.yaml
- docs/
- tests/
- .gitignore
- README.md
- LICENSE

---

## Development & Testing

- Backend tests (pytest):
  ```bash
  cd backend
  pytest
  ```

- Frontend tests:
  ```bash
  cd flutter_app
  flutter test
  ```

- Run linting/formatters:
  - Python: `black`, `flake8`  
  - Dart: `dart format`, `flutter analyze`

---

## Contributing

Contributions are welcome. Suggested workflow:

1. Fork the repository
2. Create a branch: `git checkout -b feat/your-feature`
3. Add tests and documentation for your changes
4. Commit and push: `git push origin feat/your-feature`
5. Open a Pull Request describing your changes

Please follow code style guidelines and keep commits focused and descriptive.

---

## Roadmap (examples)

- Add authentication & user profiles  
- Pluggable model backends and model selection UI  
- Persistent vector store (Redis/Weaviate) support  
- Rate-limiting and API quota controls  
- Voice and multi-language input support

---
