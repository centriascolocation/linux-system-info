#!/usr/bin/env bash

export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

REPORT_FILE=system-info-report-$(date +%s).txt
touch ${REPORT_FILE} && chmod 0600 ${REPORT_FILE}

function _header() {
  echo -e "\n***** $* *****\n"
}

function r_meminfo() {
  _header "Memory"
  cat /proc/meminfo | tee -a ${REPORT_FILE}
}

function r_cpuinfo() {
  _header "CPU"
  cat /proc/cpuinfo | tee -a ${REPORT_FILE}
}

function r_proc_version() {
  _header "Linux version"
  cat /proc/version | tee -a ${REPORT_FILE}
}

function r_lsb_release() {
  _header "distribution-specific information"
  lsb_release -a | tee -a ${REPORT_FILE}
}

function r_lspci() {
  _header "PCI"
  lspci  | tee -a ${REPORT_FILE}
}

function r_lsusb() {
  _header "USB"
  lsusb | tee -a ${REPORT_FILE}
}

function r_lsblk() {
  _header "Block devices"
  lsblk | tee -a ${REPORT_FILE}
}

function r_fdisk() {
  _header "Disks and partitions"
  fdisk -l | tee -a ${REPORT_FILE}
}

function r_lshw() {
  _header "Hardware"
  lshw | tee -a ${REPORT_FILE}
}

function r_dmidecode {
  _header "DMI/BIOS information"
  dmidecode | tee -a ${REPORT_FILE}
}

##
## call all the above report functions:
r_meminfo
r_cpuinfo
r_proc_version
r_lsb_release
r_lspci
r_lsusb
r_lsblk
r_fdisk
r_lshw
r_dmidecode

##
## save REPORT_FILE
chmod 0400 ${REPORT_FILE}
_header "Report file written: ${REPORT_FILE}."

