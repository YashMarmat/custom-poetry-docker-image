FROM python:3.11.1-alpine

# installing curl as the current image doesn't have it
RUN apk add --upgrade --no-cache curl

RUN apk add --upgrade --no-cache py-pip g++ linux-headers gcc make libffi-dev uwsgi-python uwsgi wget
RUN apk add --upgrade --no-cache python3 python3-dev

# Install poetry
RUN curl -sSL https://install.python-poetry.org | python

# setting up env path for poetry
ENV PATH="/root/.local/bin:$PATH"

# below command runs if you have pyproject.toml file (also avoids creation of virtual env 
# in poetry)

# exit 0 means even if there is an error (like pyproject.toml file not found), then ignore it 
# and exit with status code 0 (means move to next lines of code). 
RUN poetry config virtualenvs.create false \
    && poetry install --no-dev --no-interaction --no-ansi pyproject.toml /; exit 0