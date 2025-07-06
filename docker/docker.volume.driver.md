W Dockerze masz do dyspozycji wiele driverów (sterowników) dla docker volume, zarówno wbudowanych, jak i zewnętrznych.
✅ 1. Wbudowane drivery (builtin)
Driver	Opis
local	Domyślny driver Dockera. Tworzy wolumen na lokalnym dysku hosta (np. w /var/lib/docker/volumes). Można podawać opcje typu type=tmpfs, device, o.
none	(rzadko używany) Brak drivera – nie zarządza volume, tylko przekazuje ścieżkę do kontenera.
🔧 2. Opcje wbudowanego drivera local

Możesz np. utworzyć tmpfs volume:

docker volume create \
  --driver local \
  --opt type=tmpfs \
  --opt device=tmpfs \
  --opt o=size=100m,tmpfs-mode=1777 \
  mytmpfs

Lub wskazać konkretną ścieżkę hosta (bind mount w compose).
🔷 3. Popularne zewnętrzne drivery volume

Oto najczęściej używane w produkcji i w chmurze:
Driver	Opis
rexray/ebs	Montowanie AWS EBS jako volume.
rexray/efs	Montowanie AWS EFS jako volume (NFS).
rexray/s3fs	Montowanie S3 jako volume (przez s3fs).
digitalocean	Mount DO Block Storage jako volume (DigitalOcean plugin).
azurefile	Integracja z Azure File Storage.
netapp	Integracja z NetApp ONTAP.
nfs	Mount NFS server jako volume (przez docker volume driver nfs).
glusterfs	Integracja z GlusterFS dla volume współdzielonych.
local-persist	Umożliwia trwałe volume poza /var/lib/docker/volumes.
portworx/pxd	Enterprise storage plugin z wysoką dostępnością.
vsphere	VMware vSphere storage driver.
ceph	Mount CephFS jako volume.
flocker	(przestarzały) Był używany do przenoszenia volume między hostami.
🚀 4. Sprawdzenie dostępnych driverów na Twoim systemie

    Lista pluginów:

docker plugin ls

    Utworzenie volume z konkretnym driverem (przykład NFS):

docker volume create \
  --driver local \
  --opt type=nfs \
  --opt o=addr=192.168.1.100,nolock,soft,rw \
  --opt device=:/exported/path \
  mynfsvolume

⚠️ 5. Uwagi praktyczne

✔️ Drivery builtin (local, none) nie wymagają instalacji.
✔️ Drivery zewnętrzne (rexray, digitalocean, azurefile) wymagają instalacji pluginu Dockera lub instalacji systemowej (np. s3fs, nfs-client).
✔️ Niektóre drivery jak rexray wykorzystują FUSE (np. s3fs) i mają ograniczenia wydajności oraz kompatybilności POSIX.
💡 6. Podsumowanie

➡️ local – podstawowy i uniwersalny
➡️ rexray/s3fs, rexray/efs, digitalocean – chmura i storage w skali
➡️ nfs, glusterfs, ceph – rozproszone i współdzielone systemy plików
