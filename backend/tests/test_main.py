from fastapi.testclient import TestClient
from app.main import app
import pytest

client = TestClient(app)

def test_read_root():
    response = client.get("/")
    assert response.status_code == 200
    assert response.json() == {"message": "Egg Price Tracker API"}

def test_get_current_price():
    response = client.get("/api/current-price")
    assert response.status_code in [200, 404]  # Either success or no data found
    if response.status_code == 200:
        data = response.json()
        assert "price" in data
        assert "timestamp" in data
        assert "currency" in data
        assert data["currency"] == "USD"

def test_get_historic_prices():
    response = client.get("/api/historic-prices")
    assert response.status_code in [200, 404]  # Either success or no data found
    if response.status_code == 200:
        data = response.json()
        assert isinstance(data, list)
        if len(data) > 0:
            assert "date" in data[0]
            assert "price" in data[0]
            assert "currency" in data[0]
            assert data[0]["currency"] == "USD" 