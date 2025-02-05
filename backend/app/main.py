import os
from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
import tradingeconomics as te
from dotenv import load_dotenv
import pandas as pd
from datetime import datetime, timedelta

# Load environment variables
load_dotenv()

# Initialize FastAPI app
app = FastAPI(title="Egg Price Tracker API")

# Add CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # In production, replace with specific origins
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Initialize Trading Economics with API key
te.login(os.getenv('TE_API_KEY', 'guest:guest'))

@app.get("/")
async def root():
    return {"message": "Egg Price Tracker API"}

@app.get("/api/current-price")
async def get_current_price():
    try:
        # Get commodities data focusing on eggs
        data = te.getMarketsData(marketsField='commodities')
        egg_data = [item for item in data if 'egg' in item.get('Symbol', '').lower()]
        
        if not egg_data:
            raise HTTPException(status_code=404, detail="Egg price data not found")
            
        current_price = egg_data[0].get('Last', 0)
        return {
            "price": current_price,
            "timestamp": datetime.now().isoformat(),
            "currency": "USD"
        }
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@app.get("/api/historic-prices")
async def get_historic_prices(days: int = 30):
    try:
        end_date = datetime.now()
        start_date = end_date - timedelta(days=days)
        
        # Get historical data
        data = te.getHistorical('commodities')
        egg_data = [item for item in data if 'egg' in item.get('Symbol', '').lower()]
        
        if not egg_data:
            raise HTTPException(status_code=404, detail="Historic egg price data not found")
            
        # Convert to pandas DataFrame for easy manipulation
        df = pd.DataFrame(egg_data)
        df['Date'] = pd.to_datetime(df['Date'])
        df = df.sort_values('Date')
        
        # Format response
        prices = [
            {
                "date": row['Date'].isoformat(),
                "price": row['Price'],
                "currency": "USD"
            }
            for _, row in df.iterrows()
        ]
        
        return prices
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000) 