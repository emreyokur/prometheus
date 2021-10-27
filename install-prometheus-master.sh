#!/usr/bin/bash
set -x

wget https://github.com/prometheus/prometheus/releases/download/v2.30.3/prometheus-2.30.3.linux-amd64.tar.gz

useradd --no-create-home --shell /bin/false prometheus

mkdir --parents /etc/prometheus
mkdir --parents /var/lib/prometheus

chown prometheus:prometheus /etc/prometheus
chown prometheus:prometheus /var/lib/prometheus

tar -xvzf prometheus-2.30.3.linux-amd64.tar.gz
mv -f prometheus-2.30.3.linux-amd64 prometheuspackage
cp --remove-destination prometheuspackage/prometheus /usr/local/bin/
cp --remove-destination prometheuspackage/promtool /usr/local/bin/
chown prometheus:prometheus /usr/local/bin/prometheus
chown prometheus:prometheus /usr/local/bin/promtool

cp -r --remove-destination prometheuspackage/consoles /etc/prometheus
cp -r --remove-destination prometheuspackage/console_libraries /etc/prometheus
cp --remove-destination prometheus.yml /etc/prometheus/prometheus.yml
cp --remove-destination alert.rules /etc/prometheus/prometheus.yml
chown -R prometheus:prometheus /etc/prometheus/

mv -f prometheus.service /usr/lib/systemd/system/prometheus.service
systemctl daemon-reload
systemctl restart prometheus