# Use rgdevops123 Base Centos Image.
FROM rgdevops123/rgcentos7.6

# Set Maintainer.
LABEL maintainer "rgdevops123@gmail.com"

# Set the working directory.
ARG APPDIR="/testapp/"
WORKDIR ${APPDIR}

# Copy Application files.
COPY app.py cert.pem key.pem requirements.txt ${APPDIR}

# Install Dependencies.
RUN pip3 install -r requirements.txt

# Set a Health Check.
HEALTHCHECK --interval=5s \
            --timeout=5s \
            CMD curl -skSL -D - https://127.0.0.1:5000 -o /dev/null || exit 1

# Run the image as a non-root user.
RUN groupadd -g 1000 appuser && \
    useradd -r -u 1000 -g appuser appuser
RUN chown -R appuser:appuser ${APPDIR}
USER appuser

# Tell docker what port to expose
EXPOSE 5000

# Specify the command to run.
ENTRYPOINT ["python3","app.py"]
