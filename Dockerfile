ARG CKAN_VERSION=2.10
FROM openknowledge/ckan-dev:${CKAN_VERSION}
ARG CKAN_VERSION

RUN pip install --upgrade pip

COPY . $APP_DIR/

# python cryptography takes a while to build
RUN pip install -r requirements.txt -r dev-requirements.txt -e .
