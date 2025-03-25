#!/usr/bin/env bash
echo "***********************************************"
echo "Creating rpm file for Amazon Linux and RHEL 386"
echo "***********************************************"

rm -rf ${GO_SPACE}/bin/termux/linux
TERMUX_PREFIX=/data/data/com.termux/files/usr
export TERMUX_PREFIX=/data/data/com.termux/files/usr
echo "Creating rpmbuild workspace"

mkdir -p ${GO_SPACE}/bin/termux/linux/rpmbuild/SPECS
mkdir -p ${GO_SPACE}/bin/termux/linux/rpmbuild/COORD_SOURCES
mkdir -p ${GO_SPACE}/bin/termux/linux/rpmbuild/DATA_SOURCES
mkdir -p ${GO_SPACE}/bin/termux/linux/rpmbuild/BUILD
mkdir -p ${GO_SPACE}/bin/termux/linux/rpmbuild/RPMS
mkdir -p ${GO_SPACE}/bin/termux/linux/rpmbuild/SRPMS
mkdir -p ${GO_SPACE}/bin/termux/linux/${TERMUX_PREFIX}/bin/
mkdir -p ${GO_SPACE}/bin/termux/linux/${TERMUX_PREFIX}/etc/init/
mkdir -p ${GO_SPACE}/bin/termux/linux/${TERMUX_PREFIX}/etc/systemd/system/
mkdir -p ${GO_SPACE}/bin/termux/linux/${TERMUX_PREFIX}/etc/amazon/ssmcli/
mkdir -p ${GO_SPACE}/bin/termux/linux/${TERMUX_PREFIX}/var/lib/amazon/ssmcli/

echo "Copying application files"

cp ${GO_SPACE}/bin/termux/ssmcli ${GO_SPACE}/bin/termux/linux/${TERMUX_PREFIX}/bin/
cp ${GO_SPACE}/seelog_unix.xml ${GO_SPACE}/bin/termux/linux/${TERMUX_PREFIX}/etc/amazon/ssmcli/seelog.xml.template
cp ${GO_SPACE}/packaging/linux/ssmcli.conf ${GO_SPACE}/bin/termux/linux/${TERMUX_PREFIX}/etc/init/
cp ${GO_SPACE}/packaging/linux/ssmcli.service ${GO_SPACE}/bin/termux/linux/${TERMUX_PREFIX}/etc/systemd/system/
cd ${GO_SPACE}/bin/termux/linux/usr/bin/; strip --strip-unneeded ssmcli; cd ~-

echo "Creating the rpm package"

SPEC_FILE="${GO_SPACE}/packaging/linux/ssmcli.spec"
BUILD_ROOT="${GO_SPACE}/bin/termux/linux"

setarch i386 rpmbuild --target i386 -bb --define "rpmversion `cat ${GO_SPACE}/VERSION`" --define "_topdir bin/termux/linux/rpmbuild" --buildroot ${BUILD_ROOT} ${SPEC_FILE}

echo "Copying rpm files to bin"

cp ${GO_SPACE}/bin/termux/linux/rpmbuild/RPMS/i386/*.rpm ${GO_SPACE}/bin/
cp ${GO_SPACE}/bin/termux/linux/rpmbuild/RPMS/i386/*.rpm ${GO_SPACE}/bin/termux/ssmcli.rpm

echo "Copying install and uninstall script to bin"

cp ${GO_SPACE}/Tools/src/update/linux/install.sh ${GO_SPACE}/bin/termux/
cp ${GO_SPACE}/Tools/src/update/linux/uninstall.sh ${GO_SPACE}/bin/termux/

chmod 755 ${GO_SPACE}/bin/termux/install.sh ${GO_SPACE}/bin/termux/uninstall.sh

echo "Zip rpm, install and uninstall files"

tar -zcvf ${GO_SPACE}/bin/updates/ssmcli/`cat ${GO_SPACE}/VERSION`/ssmcli-linux-386.tar.gz  -C ${GO_SPACE}/bin/termux/ ssmcli.rpm install.sh uninstall.sh

rm ${GO_SPACE}/bin/termux/install.sh
rm ${GO_SPACE}/bin/termux/uninstall.sh