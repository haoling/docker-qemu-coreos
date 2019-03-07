FROM tianon/qemu
WORKDIR /coreos
ENV VERSION=2023.4.0
RUN apt-get update &&\
    apt-get install -y curl gpg bzip2 &&\
    apt-get -y autoremove &&\
    apt-get -y clean &&\
    rm -rf /var/lib/apt/lists/* &&\
    rm -rf /tmp/*
RUN curl -O https://coreos.com/security/image-signing-key/CoreOS_Image_Signing_Key.asc &&\
    gpg --import --keyid-format LONG CoreOS_Image_Signing_Key.asc
RUN curl -LO https://stable.release.core-os.net/amd64-usr/${VERSION}/coreos_production_qemu_image.img.bz2 &&\
    curl -LO https://stable.release.core-os.net/amd64-usr/${VERSION}/coreos_production_qemu_image.img.bz2.sig &&\
    gpg --verify coreos_production_qemu_image.img.bz2.sig &&\
    bzip2 -d coreos_production_qemu_image.img.bz2

ADD coreos_production_qemu.sh /coreos/coreos_production_qemu.sh
RUN chmod +x /coreos/coreos_production_qemu.sh
CMD ["./coreos_production_qemu.sh"]
ENV VM_BOARD=amd64-usr \
    VM_NAME=coreos_production_qemu-2023-4-0 \
    VM_IMAGE=/coreos/coreos_production_qemu_image.img \
    VM_MEMORY=1024 \
    VM_NCPUS=2 \
    VNC_DISPLAY=0 \
    SSH_KEYS= \
    CLOUD_CONFIG_FILE= \
    IGNITION_CONFIG_FILE= \
    CONFIG_IMAGE= \
    MAC_ADDRESS=
