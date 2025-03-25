Name         : session-manager-plugin
Version      : %rpmversion
Release      : 1
Summary      : Manages shell experience using SSM APIs

Group        : Amazon/Tools
License      : Apache License, Version 2.0
URL          : http://docs.aws.amazon.com/ssm/latest/APIReference/Welcome.html

Packager     : Amazon.com, Inc. <http://aws.amazon.com>
Vendor       : Amazon.com

%description
This package provides Amazon SSM SessionManager for managing shell experience using SSM APIs

%files
%defattr(-,root,root,-)
/data/data/com.termux/files/usr/local/sessionmanagerplugin/seelog.xml.template
/data/data/com.termux/files/usr/local/sessionmanagerplugin/bin/session-manager-plugin
/data/data/com.termux/files/usr/var/lib/amazon/sessionmanagerplugin/
/data/data/com.termux/files/usr/local/sessionmanagerplugin/LICENSE
/data/data/com.termux/files/usr/local/sessionmanagerplugin/NOTICE
/data/data/com.termux/files/usr/local/sessionmanagerplugin/README.md
/data/data/com.termux/files/usr/local/sessionmanagerplugin/RELEASENOTES.md
/data/data/com.termux/files/usr/local/sessionmanagerplugin/THIRD-PARTY
/data/data/com.termux/files/usr/local/sessionmanagerplugin/VERSION

%config(noreplace) /data/data/com.termux/files/usr/etc/init/session-manager-plugin.conf
%config(noreplace) /data/data/com.termux/files/usr/etc/systemd/system/session-manager-plugin.service

# The scriptlet %postun runs after a package is uninstalled.
# The scriptlet %posttrans runs at the end of a transaction.

%posttrans
# Create symbolic link for plugin
ln -s /data/data/com.termux/files/usr/local/sessionmanagerplugin/bin/session-manager-plugin /data/data/com.termux/files/usr/local/bin/session-manager-plugin

%postun
rm /data/data/com.termux/files/usr/local/bin/session-manager-plugin

%clean
# rpmbuild deletes $buildroot after building, specifying clean section to make sure it is not deleted