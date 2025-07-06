#Docker

Instalacja docker na redhat/rocky - install_docker_rocky.sh 

sudo dnf update -y
sudo dnf install -y dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo
sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl enable --now docker


Opcjonalnie można uruchomic dockera na koncie usera
sudo usermod -aG docker $(whoami)
sudo setfacl --modify user:$(whoami):rw /var/run/docker.sock

wyloguj/zaloguj się ponownie

docker run hello-world
docker compose version

