import datetime, json
from fastapi import FastAPI, Request, Response
from prometheus_fastapi_instrumentator import Instrumentator


app = FastAPI()
instrumentator = Instrumentator().instrument(app)

@app.on_event("startup")
async def _startup():
    instrumentator.expose(app)

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
