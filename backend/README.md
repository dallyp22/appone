# Egg Price Tracker Backend

This is the backend service for the Egg Price Tracker iOS app, built using FastAPI and the Trading Economics API.

## Setup

1. Create a virtual environment:
```bash
python -m venv venv
.\venv\Scripts\activate  # Windows
source venv/bin/activate  # Linux/Mac
```

2. Install dependencies:
```bash
pip install -r requirements.txt
```

3. Set up environment variables:
Create a `.env` file in the backend directory with:
```
TE_API_KEY=your_trading_economics_api_key
```

## Running the Server

Start the development server:
```bash
cd backend
uvicorn app.main:app --reload
```

The API will be available at `http://localhost:8000`

## API Endpoints

- `GET /`: Root endpoint
- `GET /api/current-price`: Get current egg price
- `GET /api/historic-prices`: Get historic egg prices (default: last 30 days)

## Running Tests

```bash
pytest tests/
```

## API Documentation

Once the server is running, view the API documentation at:
- Swagger UI: `http://localhost:8000/docs`
- ReDoc: `http://localhost:8000/redoc` 