FROM python:latest
#WORKDIR /app
COPY . .
#RUN apk add gcc musl-dev python3-dev libffi-dev openssl-dev
#RUN pip install --upgrade pip
RUN pip install -r requirements.txt
EXPOSE 5000


# ENTRYPOINT ["python"]
# CMD ["app.py"]

CMD ["python3" , "-m" , "flask", "run" , "--host=0.0.0.0"]