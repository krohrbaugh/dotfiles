#
# Allows for snapshots from the command line:
#   vboxmanage snapshot $(vagrant-uuid) list
#   vboxmanage snapshot $(vagrant-uuid) take <name>
#   vboxmanage snapshot $(vagrant-uuid) restore <name>
#   vboxmanage snapshot $(vagrant-uuid) delete <name>
#
# Note: Commands above must be run from the same location as .vagrant
vagrant-uuid() {
  if [ -f .vagrant ]
  then
    echo $(cat .vagrant | python -c 'import json,sys;obj=json.loads(sys.stdin.read());print obj["'"active"'"]["'"default"'"]')
  else
    echo "No UUID found"    
  fi
}

alias vagrant-snap="vboxmanage snapshot $(vagrant-uuid)"