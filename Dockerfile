FROM debian:11

ARG CROSS_TOOLCHAIN=

WORKDIR /root/

ADD z.tar.gz  $CROSS_TOOLCHAIN  /opt
ADD fengming.d.tar.gz  /opt


ENV COMPILER4WHO=crosstool_build_compiler
RUN cat <<-EOF >> .bashrc
alias who='echo $COMPILER4WHO'
export LANG=en_US.UTF-8

if [ -f /opt/fengming.d/mybashrc  ];then
    . /opt/fengming.d/mybashrc
fi

EOF

RUN cat <<-EOF > /etc/apt/sources.list
deb http://mirrors.163.com/debian/ bullseye main contrib 
deb http://mirrors.163.com/debian/ bullseye-updates main contrib
EOF

RUN apt update \
	&& apt upgrade -y

RUN apt install -y locales vim bc xz-utils bzip2 unzip lzip help2man file \
	patch gawk make cmake gcc flex texinfo  wget curl

RUN apt install -y binutils meson ninja-build rsync  libtool-bin libtool-doc \
	build-essential gcc-multilib lib32z1 libncurses5-dev

RUN apt install -y bison  byacc  coreutils  pkg-config  libncursesw5-dev


RUN cp /etc/locale.gen /etc/locale.gen.bak;\
		echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen;\
		locale-gen


CMD ["/bin/bash"]
