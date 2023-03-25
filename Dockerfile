
FROM python:3.8-alpine

WORKDIR /app

COPY main.py main.py

CMD [ "python3", "main.py"]
