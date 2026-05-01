#!/bin/bash

pkgMgr="pacman"

backup(){
  echo "WIP"
  exit
  BACKUP_DIR="${HOME}/backups"
  msg "Backing up PADS to ${BACKUP_DIR}/pads..."
  sudo rsync --delete -aAXH "${PADS_DIR}" "${BACKUP_DIR}/pads/pads_v$(pads -v)"
  sudo tar -cf "${BACKUP_DIR}/pads/pads_v$(pads -v).tar.gz" "${BACKUP_DIR}/pads/pads_v$(pads -v)" 2> /dev/null
  read -p "Backup System? (y/N): $ " backup
  if [[ $backup =~ [yY,eE,sS] ]]; then
      msg "Backing up ${HOSTNAME}"
      sudo rsync --delete -aAXH --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/home/*","/media/*","/lost+found"} / "${BACKUP_DIR}/arch"
  fi
}

updatepkg(){
  INFO "Updating..."
  ${pkgMgr} -Syu --noconfirm
  LOG "Updated $(date)"
}

installpkg(){
  INFO "Installing ${packages}..."
  ${pkgMgr} -Syu ${packages} --needed
  #echo " * Updating $(uname -n)_req.txt"
  #pacman -Qqen > "${HOME}/vault/$(uname -n)_req.txt"
}

listpkg(){
  pacman -Qqen
}

deletepkg(){
  sudo pacman -Rcns $packages
}

case ${function} in
  b) backup;;
  u) updatepkg;;
  i) 
    [[ -n $packages ]] && \
      installpkg || \
      printf " :: Must supply a package name\n"
      exit
      ;;
  l) listpkg;;
  d) 
    [[ -n $packages ]] && \
    deletepkg || \
    printf " :: Must supply a package name\n"
    exit
    ;;
  h) echo "help"; exit;;
  ?) echo "usage"; exit;;
  *) echo "k18 error"; exit;;
esac
