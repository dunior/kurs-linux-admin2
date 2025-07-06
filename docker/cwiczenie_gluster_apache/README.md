Ćwiczenie: Budowa środowiska z 2 kontenerami Apache i 3 węzłami GlusterFS + montowanie storage w Apache
🔧 🎯 Cel ćwiczenia:

    Uruchomić 3 kontenery GlusterFS jako rozproszony storage.

    Uruchomić 2 kontenery Apache, które montują GlusterFS jako wolumen.

    Sprawdzić, że pliki zapisywane w jednym Apache są widoczne w drugim.

📝 1. Wymagania:

✔️ Docker z włączoną obsługą volume driverów na Twoim systemie
✔️ Plugin volume driver do GlusterFS (lub klient GlusterFS zainstalowany w systemie hosta)
✔️ docker-compose (dla uproszczenia całego środowiska)
📁 2. Struktura katalogów ćwiczenia

glusterfs-apache-lab/
├── apache/
│   └── Dockerfile
└── docker-compose.yml

⚙️ 3. Plik apache/Dockerfile

FROM ubuntu:22.04

LABEL maintainer="admin@example.com" \
      description="Apache with GlusterFS mount demo"

RUN apt-get update && \
    apt-get install -y apache2 glusterfs-client && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Utwórz katalog mountpoint
RUN mkdir -p /mnt/glusterfs

# Expose port 80
EXPOSE 80

CMD ["apachectl", "-D", "FOREGROUND"]

📄 4. Plik docker-compose.yml

version: "3.8"

services:
  gluster1:
    image: gluster/gluster-centos
    container_name: gluster1
    hostname: gluster1
    command: glusterd -N &
    privileged: true
    networks:
      - glusternet

  gluster2:
    image: gluster/gluster-centos
    container_name: gluster2
    hostname: gluster2
    command: glusterd -N &
    privileged: true
    networks:
      - glusternet

  gluster3:
    image: gluster/gluster-centos
    container_name: gluster3
    hostname: gluster3
    command: glusterd -N &
    privileged: true
    networks:
      - glusternet

  apache1:
    build: ./apache
    container_name: apache1
    hostname: apache1
    ports:
      - "8081:80"
    depends_on:
      - gluster1
      - gluster2
      - gluster3
    networks:
      - glusternet
    volumes:
      - glusterfsvol:/mnt/glusterfs

  apache2:
    build: ./apache
    container_name: apache2
    hostname: apache2
    ports:
      - "8082:80"
    depends_on:
      - gluster1
      - gluster2
      - gluster3
    networks:
      - glusternet
    volumes:
      - glusterfsvol:/mnt/glusterfs

volumes:
  glusterfsvol:
    driver: local
    driver_opts:
      type: "glusterfs"
      device: "gluster1:/gv0"
      o: "backup-volfile-servers=gluster2:gluster3"

networks:
  glusternet:

🔎 5. Co robi powyższa konfiguracja?

✅ Uruchamia 3 kontenery z GlusterFS (gluster1, gluster2, gluster3)
✅ Tworzy wolumen glusterfsvol montujący GlusterFS volume gv0 z węzła gluster1 (z backup volfile na gluster2 i gluster3)
✅ Uruchamia 2 kontenery Apache (apache1, apache2) z zamontowanym GlusterFS na /mnt/glusterfs
🛠️ 6. Krok po kroku w terminalu

    Utwórz katalog ćwiczenia i przejdź do niego:

dnf install glusterfs-fuse
mkdir glusterfs-apache-lab
cd glusterfs-apache-lab


    Stwórz strukturę katalogów i pliki według powyższej struktury.

    Zbuduj i uruchom całość:

docker compose up -d --build

    Skonfiguruj GlusterFS volume w kontenerach gluster1, gluster2, gluster3.

Przykład konfiguracji (uruchamiaj w gluster1):

docker exec -it gluster1 bash
gluster peer probe gluster2
gluster peer probe gluster3
gluster volume create gv0 replica 3 gluster1:/data/brick1/gv0 gluster2:/data/brick1/gv0 gluster3:/data/brick1/gv0 force
gluster volume start gv0
exit

🔍 7. Test działania

    Wejdź do apache1:

docker exec -it apache1 bash
echo "Hello from apache1" > /mnt/glusterfs/index.html
exit

    Wejdź do apache2:

docker exec -it apache2 bash
cat /mnt/glusterfs/index.html

✔️ Powinieneś zobaczyć „Hello from apache1”.
⚠️ 8. Uwagi praktyczne

    GlusterFS wymaga privilege dla kontenerów (network + FUSE).

    Ten przykład jest treningowy – w produkcji GlusterFS wdraża się na hostach VM/bare metal, nie w kontenerach.

    Możesz testować także przez przeglądarkę:

        http://localhost:8081

        http://localhost:8082

🎯 9. Efekt końcowy ćwiczenia

✔️ Zrozumiesz integrację kontenerów Apache z rozproszonym storage GlusterFS
✔️ Będziesz w stanie wdrożyć podobne rozwiązanie w środowisku testowym lub produkcyjnym
