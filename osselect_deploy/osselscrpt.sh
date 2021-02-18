RELEASE=`cat /etc/*-release`

for name in 'CENTOS' 'UBUNTU' 'OpenSuse' 'DEBIAN' 'RED HAT'
do
        echo "${RELEASE}" | grep -i -q "${name}" && echo "$name"
done
