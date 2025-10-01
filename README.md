# C Train Delays App

A simple web app to check real-time status of the NYC C Train line using the MTA's GTFS real-time API.

## Features

- Real-time C Train status checking
- Clean, modern UI with MTA blue branding
- Status indicators: On Time, Delayed, or Service Alert
- Mobile-friendly design

## Tech Stack

- **Backend:** Flask (Python)
- **Data Source:** MTA GTFS Real-time API
- **Deployment:** Render
- **Styling:** Helvetica font, MTA blue (#0039A6)

## Local Development

1. Clone the repository:
```bash
git clone https://github.com/helenhl20/c-train-delays-app.git
cd c-train-delays-app
```

2. Create and activate virtual environment:
```bash
python3 -m venv venv
source venv/bin/activate
```

3. Install dependencies:
```bash
pip install -r requirements.txt
```

4. Run the app:
```bash
python3 app.py
```

5. Visit `http://localhost:5000` in your browser

## Deployment

This app is configured for deployment on Render. The `render.yaml` file contains all necessary configuration.

## Add to iPhone Home Screen

1. Visit the deployed URL in Safari
2. Tap the Share button
3. Select "Add to Home Screen"
4. The app will appear as an icon on your home screen

## License

MIT