#!/bin/bash

randpass=$(sudo < /dev/urandom tr -dc A-Za-z0-9{\!@#$%^\&*\(\){}[]?} | head -c14; echo)
database="$(find $HOME/Documents -type d -iname sql)"
saveFile="$HOME/Documents"

setupMariaDB(){
  [[ ! $(mariadb --version) ]] && printf msg "Installing Mariadb" && sudo pacman -Syu mariadb

  sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

  [[ $(systemctl status mariadb | grep "inactive") ]] && msg "Enabling/Starting service" && sudo systemctl enable mariadb.service &> /dev/null && sudo systemctl start mariadb.service &> /dev/null

  sudo mariadb-secure-installation
}

padsProfile(){
  printf " * Creating PADS profile \n"
  # Create Mariadb user
  sudo mariadb --user=root -e "USE mysql; CREATE USER IF NOT EXISTS 'pads'@'%' IDENTIFIED BY '${randpass}'; GRANT ALL PRIVILEGES ON *.* TO 'pads'@'%'; FLUSH PRIVILEGES;"

  # Save pads profile for later
  echo "#!/bin/bash" > ${saveFile}
  echo "export DB_USER=\"pads\"" >> ${saveFile}
  echo "export DB_PASS=\"${randpass}\"" >> ${saveFile}
  echo "export SECRET_KEY=\"\$(tr -dc A-Za-z0-9 </dev/urandom | head -c 64)\"" >> "${saveFile}"

  # Install DB's from PADS dir
  for file in $(ls ${database}); do
    [[ $? -eq 0 ]] && sudo mariadb < "${database}/${file}" 2> /dev/null && printf "[${green}INSTALLED${r}] :: ${file} \n" || printf "[${red}ERROR${r}] :: ${file} \n"
  done

  # Create ENV VARS for each DB, saved to saveFile
  for i in $(sudo mariadb -e 'SHOW DATABASES WHERE `Database` NOT in ("information_schema", "performance_schema", "mysql", "sys")';); do
    echo "export ${i^^}=\"${i}\"" | sed s/'export DATABASE="Database"'/" "/g >> ${saveFile}
  done
  #pads -Su python-mysql-connector
}

