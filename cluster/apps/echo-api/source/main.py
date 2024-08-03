import datetime, json
from fastapi import FastAPI, Request, Response


app = FastAPI()

@app.get("/echo")
async def echo(request: Request):
    current_datetime = datetime.datetime.now()
    date_fmt = current_datetime.strftime("%x")
    time_fmt = current_datetime.strftime("%X")

    data = {
        "url": f"{request.url}",
        "headers": f"{request.headers}",
        "client": f"{request.client}",
        "date": f"{date_fmt}-{time_fmt}"
    }

    response = json.dumps(data)

    return Response(content=response, media_type="application/json")
