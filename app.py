from flask import Flask, jsonify, render_template
import requests
from google.transit import gtfs_realtime_pb2
import os

app = Flask(__name__)
URL = "https://api-endpoint.mta.info/Dataservice/mtagtfsfeeds/nyct%2Fgtfs-ace"

@app.route("/")
def home():
    response = requests.get(URL)
    feed = gtfs_realtime_pb2.FeedMessage()
    feed.ParseFromString(response.content)

    has_alert = False
    has_delay = False

    for entity in feed.entity:
        # Check alerts
        if entity.HasField("alert"):
            for ie in entity.alert.informed_entity:
                if ie.route_id == "C":
                    has_alert = True

        # Check trip updates
        if entity.HasField("trip_update") and entity.trip_update.trip.route_id == "C":
            for stu in entity.trip_update.stop_time_update:
                if stu.HasField("departure") and stu.departure.HasField("delay") and stu.departure.delay > 60:
                    has_delay = True

    if has_alert:
        status = "alert"
    elif has_delay:
        status = "delayed"
    else:
        status = "on_time"

    return render_template("status.html", status=status)

if __name__ == "__main__":
    app.run(debug=True, port=5000, host='0.0.0.0')

