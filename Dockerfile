FROM python:3.10-slim as builder

ADD requirements.txt .
RUN python -m venv /opt/venv && export PATH="/opt/venv/bin:$PATH" && \
    pip install --no-cache-dir --disable-pip-version-check -r requirements.txt

FROM python:3.10-slim

COPY --from=builder /opt/venv /opt/venv

ENV PYTHONPATH=/opt/venv
ENV PATH=/opt/venv/bin/:$PATH

RUN useradd -ms /bin/bash researcher
USER researcher

WORKDIR /home/researcher/labs
EXPOSE 8888

CMD [ "jupyter", "lab", "--ip", "0.0.0.0" ]