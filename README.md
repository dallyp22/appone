# Egg Price Tracker

A modern iOS app that tracks egg prices in the United States using real-time data from Trading Economics.

## Features

- Real-time egg price updates
- Historical price tracking with interactive charts
- Beautiful, modern UI with custom egg visualization
- Loading states and error handling
- Refresh functionality for both current and historic prices

## Project Structure

The project consists of two main components:

### iOS Frontend (EggPriceTracker/)
- SwiftUI-based user interface
- MVVM architecture
- Combine framework for reactive programming
- Custom animations and visualizations
- Charts framework for price history visualization

### Python Backend (backend/)
- FastAPI-based REST API
- Trading Economics API integration
- Real-time price data fetching
- Historical price data processing

## Setup

### Backend Setup
1. Create a Python virtual environment:
```bash
cd backend
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

4. Run the server:
```bash
uvicorn app.main:app --reload
```

### iOS Setup
1. Open the EggPriceTracker project in Xcode
2. Make sure the backend server is running
3. Run the app in the iOS Simulator or on a physical device

## API Endpoints

- `GET /`: Root endpoint
- `GET /api/current-price`: Get current egg price
- `GET /api/historic-prices`: Get historic egg prices (default: last 30 days)

## Screenshots

[Add screenshots of your app here]

## Contributing

Feel free to submit issues and enhancement requests!

## License

This project is licensed under the MIT License - see the LICENSE file for details. 