[[ $1 = '--restart' ]] && (for i in `ps -ef | egrep 'synergy|conky' | grep -v grep | awk '{print $2}'`; do kill $i; done)

synergyc --name thulium 10.20.109.32
conky
