ansible-playbook -i inventory update.yml
ansible-playbook -i inventory install_apache.yml
ansible-playbook -i inventory install_mariadb.yml
ansible-playbook -i inventory create_users.yml --ask-vault-pass   #hasło: alx
ansible-playbook -i inventory create_backup_dir.yml

ansible-playbook -i inventory create_kurs22.yml

uruchomienie całości 1 poleceniem:

ansible-playbook -i inventory site.yml --ask-vault-pass


nsible-playbook -i inventory install_apache2.yml

#przyklad wywolania z limitami:
ansible-playbook -i inventory install_apache.yml \
  -l web* \
  -u deploy \
  -e ansible_become_user=root

  #identyczny przyklad z dlugimi przelacznikami

  ansible-playbook -i inventory install_apache.yml \
  --limit "web*" \
  -u deploy \
  -e ansible_become_user=root

  # instalacja z limitem na grupie hostow
  ansible-playbook -i install_apache.yml -l "host1,host2" -e "grupa=host1,host2"
