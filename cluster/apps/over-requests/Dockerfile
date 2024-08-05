FROM python:3.11-slim

ENV PYTHONUNBUFFERED=1

RUN mkdir /home/app
WORKDIR /home/app

COPY source /home/app

RUN pip install -r requirements.txt

ENTRYPOINT ["python3", "main.py"]
