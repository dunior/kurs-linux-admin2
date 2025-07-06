1. Metoda: Plugin Docker Volume Driver
🔧 A. rexray/s3fs plugin

rexray/s3fs to popularny plugin umożliwiający montowanie S3 jako wolumen Dockera.

🔽 Kroki:

    Zainstaluj plugin:

docker plugin install rexray/s3fs \
    S3FS_ACCESSKEY=<your-access-key> \
    S3FS_SECRETKEY=<your-secret-key> \
    S3FS_REGION=<your-region> \
    S3FS_OPTIONS="url=https://s3.your-provider.com"

🔧 Parametry:

    S3FS_ACCESSKEY i S3FS_SECRETKEY – klucze IAM

    S3FS_REGION – np. eu-central-1

    url – jeśli używasz innego endpointu (np. Minio)

    Sprawdź plugin:

docker plugin ls

Powinien być aktywny i ENABLED.

    Twórz wolumeny powiązane z S3:

docker volume create -d rexray/s3fs --name s3volume -o bucket=my-bucket -o prefix=myfolder

✔️ Parametry:

    bucket=my-bucket – nazwa Twojego bucketa

    prefix=myfolder – opcjonalny podfolder

    Użyj volume w kontenerze:

docker run -it -v s3volume:/data ubuntu bash

⚠️ 2. Uwagi praktyczne o rexray/s3fs

    Działa przez FUSE (s3fs), więc wydajność różni się od lokalnego dysku.

    Nie wspiera POSIX w pełni (brak locków, ograniczenia chmod/chown).

    Najlepiej nadaje się do przechowywania plików statycznych, backupów, logów, a nie do baz danych.
