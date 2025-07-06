ansible-playbook -i inventory update.yml
ansible-playbook -i inventory install_apache.yml
ansible-playbook -i inventory install_mariadb.yml
ansible-playbook -i inventory create_users.yml --ask-vault-pass   #hasło: alx
ansible-playbook -i inventory create_backup_dir.yml

ansible-playbook -i inventory create_kurs22.yml

uruchomienie całości 1 poleceniem:

ansible-playbook -i inventory site.yml --ask-vault-pass


nsible-playbook -i inventory install_apache2.yml
