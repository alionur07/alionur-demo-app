FROM python:2.7
ARG service
ENV service ${service}
COPY $service/ /app
COPY config.py /app
COPY requirements.txt /app
WORKDIR /app
RUN pip install -r requirements.txt
CMD ["sh","-c","python ${service}.py"]