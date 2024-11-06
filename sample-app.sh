#!/bin/bash
set -euo pipefail

# Maak benodigde mappen aan
mkdir -p tempdir
mkdir -p tempdir/templates
mkdir -p tempdir/static

# Kopieer bestanden naar de tempdir
cp sample_app.py tempdir/.
cp -r templates/* tempdir/templates/.
cp -r static/* tempdir/static/.

# Maak de Dockerfile
cat > tempdir/Dockerfile << _EOF_
FROM python
RUN pip install flask
COPY  ./static /home/myapp/static/
COPY  ./templates /home/myapp/templates/
COPY  sample_app.py /home/myapp/
EXPOSE 5050
CMD python /home/myapp/sample_app.py
_EOF_

# Navigeer naar tempdir
cd tempdir || exit

# Verwijder bestaande container indien aanwezig
docker rm -f samplerunning || true

# Bouw het Docker-image
docker build -t sampleapp .

# Start de nieuwe container
echo "Starting a new container"
docker run -t -d -p 5050:5050 --name samplerunning sampleapp

# Toon alle containers
docker ps -a
