FROM python:3.11.0

RUN apt update && apt upgrade -y

ARG USER=user

RUN mkdir /dir

RUN useradd --system ${USER} && \
    chown --recursive ${USER} /dir

COPY requirements.txt /dir

RUN chown ${USER} /dir/requirements.txt

RUN pip install --upgrade pip

RUN pip install -r /dir/requirements.txt

COPY . /dir

RUN chown ${USER} /dir

USER ${USER}

ENTRYPOINT ["python", "/dir/main.py"]
