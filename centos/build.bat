
@REM 指定为 KDE
@REM docker build -f Dockerfile -t linuxenv-kde:centos7.9.2009 --build-arg "DESKTOP_TYPE=KDE" .

@REM 指定为 Xfce
docker build . -f Dockerfile -t linuxenv-xfce:centos7.9.2009 --build-arg "DESKTOP_TYPE=Xfce"

@REM 默认为 GNOME
@REM docker build -f Dockerfile -t linuxenv-gnome:centos7.9.2009 --build-arg "DESKTOP_TYPE=Xfce" .
@REM docker build . -f Dockerfile -t linuxenv-gnome:centos7.9.2009
