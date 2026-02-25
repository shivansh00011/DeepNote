# DeepNote

<div align="center">

**An AI-powered, real-time query resolution system that transforms web data into concise, context-aware answers.**

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![FastAPI](https://img.shields.io/badge/FastAPI-005571?style=for-the-badge&logo=fastapi)
![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Google Gemini](https://img.shields.io/badge/Gemini-8E75B2?style=for-the-badge&logo=googlegemini&logoColor=white)

</div>

---

## What is DeepNote?

DeepNote is a Perplexity-style AI research assistant that answers user queries by:

1. **Searching the web** in real-time using Tavily's search API
2. **Scraping & extracting** full page content via `trafilatura`
3. **Ranking sources** using semantic similarity (sentence-transformers + cosine similarity)
4. **Generating grounded answers** via Google Gemini 2.0 Flash, streamed token-by-token

The result is a fast, cited, up-to-date answer — delivered over WebSocket for a real-time streaming UI experience.

---

## Architecture Overview

```
User Query (Flutter UI)
        │
        ▼
  WebSocket /ws/chat  (FastAPI)
        │
        ├──► SearchService   → Tavily API (10 results) → trafilatura (full content)
        │
        ├──► SortService     → SentenceTransformer embeddings → cosine similarity ranking
        │                       (filters results with score > 0.3)
        │
        └──► LLMService      → Gemini 2.0 Flash (streamed response)
                │
                ▼
        Flutter UI receives:
          1. { type: "search_result", data: [...sources] }
          2. { type: "content", data: "chunk..." } × N (streamed)
```

The Flutter frontend renders sources as clickable cards and streams the Markdown answer in real-time using a skeleton loader while data loads.

---

## Tech Stack

| Layer | Technology |
|---|---|
| **Frontend** | Flutter (Dart) — cross-platform (iOS, Android, macOS, Windows, Linux, Web) |
| **Backend** | FastAPI (Python, async) with WebSocket support |
| **Web Search** | Tavily Search API |
| **Content Extraction** | trafilatura |
| **Semantic Ranking** | sentence-transformers (`all-MiniLM-L6-v2`) + NumPy cosine similarity |
| **LLM** | Google Gemini 2.0 Flash (via `google-generativeai` SDK) |
| **Fonts** | Google Fonts (Inter + IBM Plex Mono) |
| **Markdown Rendering** | flutter_markdown |
| **Loading States** | skeletonizer |
| **URL Launching** | url_launcher |

---

## Project Structure

```
DeepNote/
├── lib/                          # Flutter frontend
│   ├── main.dart                 # App entry point, theme configuration
│   ├── pages/
│   │   ├── home.dart             # Home screen with search input
│   │   └── chat_page.dart        # Results page (sources + answer)
│   ├── widgets/
│   │   ├── search_section.dart   # Search bar + submit button
│   │   ├── sources_section.dart  # Source cards with URL links
│   │   ├── answer_section.dart   # Streamed Markdown answer
│   │   ├── side_nav.dart         # Collapsible sidebar navigation
│   │   └── search_button.dart    # Reusable hover-aware button
│   ├── services/
│   │   └── chat_service.dart     # Singleton WebSocket client (streams search results & content)
│   └── theme/
│       └── colors.dart           # App-wide color constants
│
├── server/                       # FastAPI backend
│   ├── main.py                   # WebSocket endpoint + REST /chat endpoint
│   ├── config.py                 # Pydantic settings (loads .env)
│   ├── .env                      # API keys (Tavily + Gemini)
│   ├── pydantic_model/
│   │   └── chat_body.py          # Request body schema
│   └── services/
│       ├── search_service.py     # Tavily search + trafilatura extraction
│       ├── sort_service.py       # Semantic similarity ranking
│       └── llm_service.py        # Gemini streaming response generation
│
├── android/                      # Android platform files
├── ios/                          # iOS platform files
├── macos/                        # macOS platform files
├── windows/                      # Windows platform files
├── linux/                        # Linux platform files
├── web/                          # Web platform files
├── pubspec.yaml                  # Flutter dependencies
└── README.md
```

---

## Key Features

- **Real-time streaming** — Answers stream token-by-token via WebSocket; no waiting for the full response
- **Semantic source ranking** — Sources are ranked by cosine similarity to the query using MiniLM embeddings, filtered to relevance score > 0.3
- **Full content scraping** — Goes beyond search snippets by extracting full article text with trafilatura
- **Grounded answers** — Gemini is instructed to use retrieved context, not its parametric knowledge
- **Skeleton loading UI** — Sources and answers show skeleton placeholders while loading
- **Collapsible sidebar** — Animated side nav with expand/collapse (66px → 155px)
- **Cross-platform** — Single Flutter codebase runs on iOS, Android, macOS, Windows, Linux, and Web
- **Clickable sources** — Source cards open the original URL via the system browser

---

## Quick Start

### Prerequisites

- Flutter SDK ≥ 3.24.0
- Python 3.9+
- A [Tavily API key](https://tavily.com/)
- A [Google AI Studio API key](https://aistudio.google.com/) (Gemini)

### 1. Clone the Repository

```bash
git clone https://github.com/shivansh00011/DeepNote.git
cd DeepNote
```

### 2. Backend Setup

```bash
cd server

# Create and activate virtual environment
python -m venv venv
source venv/bin/activate        # Windows: venv\Scripts\activate

# Install dependencies
pip install fastapi uvicorn[standard] tavily-python trafilatura \
            sentence-transformers numpy google-generativeai \
            python-dotenv pydantic-settings

# Configure environment variables
# Edit server/.env with your actual keys:
# TAVILY_API_KEY=tvly-...
# GEMINI_API_KEY=AIza...

# Start the server
uvicorn main:app --reload
# Server runs at http://localhost:8000
# WebSocket at ws://localhost:8000/ws/chat
```

### 3. Frontend Setup

```bash
cd ..   # Back to project root

# Install Flutter dependencies
flutter pub get

# Run the app (choose your target platform)
flutter run                     # Auto-detects connected device
flutter run -d chrome           # Web
flutter run -d macos            # macOS desktop
flutter run -d windows          # Windows desktop
```

---

## Environment Variables

Create `server/.env` with the following:

```env
TAVILY_API_KEY=tvly-your-key-here
GEMINI_API_KEY=AIzaSy-your-key-here
```

> ⚠️ **Never commit your `.env` file.** Add it to `.gitignore`.

---

## API Reference

### WebSocket: `ws://localhost:8000/ws/chat`

**Send:**
```json
{ "query": "Your question here" }
```

**Receive (message 1 — sources):**
```json
{
  "type": "search_result",
  "data": [
    {
      "title": "Source Title",
      "url": "https://example.com",
      "content": "Full extracted article text...",
      "relevance_score": 0.87
    }
  ]
}
```

**Receive (messages 2…N — streamed answer):**
```json
{ "type": "content", "data": "partial answer chunk..." }
```

### REST: `POST /chat`

```bash
curl -X POST http://localhost:8000/chat \
  -H "Content-Type: application/json" \
  -d '{"query": "What is quantum computing?"}'
```

---

## How the Semantic Ranking Works

The `SortService` uses `sentence-transformers` to rank search results by relevance:

1. Encode the user query into a vector embedding
2. Encode each result's full content into a vector embedding
3. Compute cosine similarity between query and each result
4. Filter out results with similarity ≤ 0.3
5. Return results sorted by relevance score (descending)

This ensures the LLM receives the most topically relevant content, reducing noise and hallucination risk.

---

## Flutter Dependencies

| Package | Purpose |
|---|---|
| `google_fonts` | Inter & IBM Plex Mono typefaces |
| `web_socket_client` | WebSocket connection to FastAPI backend |
| `flutter_markdown` | Renders LLM Markdown output |
| `skeletonizer` | Skeleton loading animations |
| `url_launcher` | Opens source URLs in system browser |
| `cupertino_icons` | iOS-style icons |

---

## Roadmap

- [ ] Chat history persistence (local storage / database)
- [ ] Multi-turn conversation support
- [ ] User authentication and saved sessions
- [ ] Pluggable LLM backends (OpenAI, Anthropic, local models)
- [ ] Voice input support
- [ ] Source citation inline in the answer text
- [ ] Follow-up question suggestions
- [ ] Redis caching for repeated queries
- [ ] Rate limiting and API quota controls
- [ ] Docker Compose setup for one-command deployment

---

<img width="3039" height="2380" alt="image" src="https://github.com/user-attachments/assets/765cc9a0-dece-481e-b112-35f4c6e93d6d" />


## Contributing

Contributions are welcome!

1. Fork the repository
2. Create a feature branch: `git checkout -b feat/your-feature`
3. Make your changes with tests where applicable
4. Commit with a clear message: `git commit -m "feat: add follow-up suggestions"`
5. Push and open a Pull Request

Please follow existing code style — `black`/`flake8` for Python, `dart format`/`flutter analyze` for Dart.

