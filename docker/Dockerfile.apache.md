Opis użytych instrukcji
Polecenie	Opis
FROM	Bazowy obraz (Ubuntu 22.04).
LABEL	Metadane: autor, opis, wersja.
ENV	Zmienne środowiskowe w kontenerze.
WORKDIR	Katalog roboczy (domyślny dla następnych poleceń RUN, CMD, ENTRYPOINT, COPY, ADD).
RUN	Instalacja pakietów, konfiguracja systemu.
COPY	Kopiowanie lokalnych plików do kontenera (tu: index.html).
ADD	Jak COPY, ale dodatkowo obsługuje rozpakowywanie archiwów i pobieranie z URL.
EXPOSE	Deklaracja portu nasłuchiwania (tu: 80 dla Apache).
VOLUME	Deklaracja punktu montowania wolumenu (tu: /var/www/html).
USER	Zmiana użytkownika wykonywania dalszych poleceń i procesów.
CMD	Domyślna komenda uruchamiana w kontenerze (może być nadpisana).
ENTRYPOINT	Główna komenda kontenera (trudniejsza do nadpisania; CMD jest dołączane jako argument).
HEALTHCHECK	Sprawdzanie zdrowia kontenera (tu: żądanie HTTP do Apache).
