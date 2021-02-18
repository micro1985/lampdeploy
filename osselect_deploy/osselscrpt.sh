RELEASE=`cat /etc/*-release`

for name in 'CENTOS' 'UBUNTU' 'OpenSuse' 'DEBIAN' 'Red Hat'
do
        echo "${RELEASE}" | grep -i -q "${name}" && echo "$name"
done
