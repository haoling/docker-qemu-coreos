FROM tianon/qemu
WORKDIR /coreos
ADD coreos_production_qemu.sh /coreos_production_qemu.sh
RUN apt-get update &&\
    apt-get install -y curl gpg bzip2 &&\
    apt-get -y autoremove &&\
    apt-get -y clean &&\
    rm -rf /var/lib/apt/lists/* &&\
    rm -rf /tmp/*
RUN curl -O https://coreos.com/security/image-signing-key/CoreOS_Image_Signing_Key.asc &&\
    gpg --import --keyid-format LONG CoreOS_Image_Signing_Key.asc
RUN curl -LO https://stable.release.core-os.net/amd64-usr/647.2.0/coreos_production_qemu_image.img.bz2 &&\
    curl -LO https://stable.release.core-os.net/amd64-usr/647.2.0/coreos_production_qemu_image.img.bz2.sig &&\
    gpg --verify coreos_production_qemu_image.img.bz2.sig &&\
    bzip2 -d coreos_production_qemu_image.img.bz2
