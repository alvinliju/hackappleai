# hackappleai

> Experimenting with Apple's upcoming Foundation Models framework using Swift Vapor

A simple AI server built to test Apple's on-device AI capabilities when they become available.

## What it does

- Basic AI chat endpoint that works now (with fallback responses)
- Ready for Apple's Foundation Models when released
- Simple REST API for testing AI integration

## Getting Started

```bash
# Clone and run
git clone https://github.com/yourusername/apple-ai-experiment.git
cd apple-ai-experiment
swift build
swift run
```

Server runs on `http://localhost:8080`

## API

**Chat endpoint:**
```bash
curl -X POST "http://localhost:8080/chat" \
  -H "Content-Type: application/json" \
  -d '"Hello AI"'
```

**Other endpoints:**
- `GET /hello` - Hello world
- `GET /ping/{id}` - Ping with ID
- Todo CRUD endpoints

## Tech Stack

- Swift 6 + Vapor 4
- Prepared for Foundation Models (macOS 15+)
- Fallback system for current testing

## Status

- ✅ Works now with mock responses
- 🔄 Will use Apple's on-device AI when available
- 🧪 Experimental - just messing around

NOTE: if localhost:8080 doesnt work use `http://127.0.0.1:8080/`

## Notes

This is just an experiment to prepare for Apple's AI framework. Currently uses fallback responses, will automatically switch to real Apple AI when Foundation Models becomes available.

---

Built for learning and experimentation.