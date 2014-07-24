# Packer Image Builder for RHEL Family 7

## Introduction

This repository started as a need to use RedHat, CentOS and Oracle Linux in a Cloud environment. To reduce the risk of malicious software on boxes, we open source the build process to ensure the process is open and everybody can find and fix potential bugs. The focus is to:

* build production ready images
* reduce the image to the minimal required set
* do not expect any specific environment (for patch management etc)

This repository can be used to build 

* Vagrant boxes
* KVM images (e.g. for Open Stack)

## Requirements

The templates are only tested with [packer](http://www.packer.io/downloads.html) 0.5.2 and later.

## Build cloud images for OpenStack

The Cloud Images are build on the following guidelines:

* Minimal Setup (installs only required base packages)
* Use XFS as default file system instead of LVM
* Configuration for network devices
* Optimized for usage with CloudInit
* No surprises

### CentOS 7

CentOS 7 is the next major release with [great new features](http://wiki.centos.org/Manuals/ReleaseNotes/CentOS7).

```bash
# start the installation
packer build -only=centos-7-cloud-kvm rhel7.json

# shrink the image size
qemu-img convert -c -f qcow2 -O qcow2 -o cluster_size=2M output-centos-7-cloud-kvm/packer-centos-7-cloud-kvm.qcow2 output-centos-7-cloud-kvm/packer-centos-7-cloud-kvm.compressed.qcow2

# upload the image to open stack
glance image-create --name "CentOS 7" --container-format ovf --disk-format qcow2 --file output-centos-7-cloud-kvm/packer-centos-7-cloud-kvm.compressed.qcow2 --is-public True --progress
```

### Oracle Linux 7

Recently Oracle launched their public release of [Oracle Linux 7](https://blogs.oracle.com/linux/entry/oracle_linux_7_is_now). Currently you require to download the ISO image via [Oracle edelivery](https://edelivery.oracle.com/linux/) before the packer build process. Once you have downloaded the image, change 

```javascript
{
      "name": "oel-7-cloud-kvm",
      "type": "qemu",
      ...
      "iso_url": "file:///your/path/to/OracleLinux-R7-U0-Server-x86_64-dvd.iso"
      ...
}
```

```bash
# start the installation
packer build -only=oel-7-cloud-kvm rhel7.json

# shrink the image size
qemu-img convert -c -f qcow2 -O qcow2 -o cluster_size=2M output-oel-7-cloud-kvm/packer-oel-7-cloud-kvm.qcow2 output-oel-7-cloud-kvm/packer-oel-7-cloud-kvm.compressed.qcow2

# upload the image to open stack
glance image-create --name "OEL 7" --container-format ovf --disk-format qcow2 --file output-oel-7-cloud-kvm/packer-oel-7-cloud-kvm.compressed.qcow2 --is-public True --progress
```

### RedHat 7

not yet supported.

## Meta Data Server

To ensure cloud-init works properly, you need to ensure that cloud-init is able to reach the metadata server during bootup:

route add 169.254.169.254 mask 255.255.255.255 <router-ip>

We recommend to configure the route in DHCP instead on the image.

## Author

 - Author:: Christoph Hartmann (<chris@lollyrock.com>)

# License

Company: Deutsche Telekom AG

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.