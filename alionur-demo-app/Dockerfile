FROM python:2.7
ARG service
ENV service ${service}
COPY $service/ /app
COPY config.py /app
COPY requirements.txt /app
WORKDIR /app
RUN pip install -r requirements.txt
EXPOSE 8080
CMD ["sh","-c","python ${service}.py"]