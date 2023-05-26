FROM python:3.8.5
COPY . /app
WORKDIR /app
#RUN apk add gcc musl-dev python3-dev libffi-dev openssl-dev
#RUN pip install Flask Jinja2
RUN pip install -r requirements.txt
ENTRYPOINT ["python"]
CMD ["userapi.py"]