FROM python:3.11-slim

RUN mkdir /home/app
WORKDIR /home/app

COPY source /home/app

RUN pip install -r requirements.txt

EXPOSE 8080

ENTRYPOINT ["uvicorn", "main:app", "--reload", "--host=0.0.0.0", "--port=8080"]
