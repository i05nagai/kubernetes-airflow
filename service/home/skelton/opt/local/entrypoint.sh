#!/bin/sh

################################################################################
# 
# Environment variables:
#   
# Arguments:
#   
################################################################################

set -x

readonly HOME_BASEDIR=/srv/volume/shared/home
readonly SUPERVISOR_BASEDIR=/srv/volume/shared/supervisor.d

readonly HOME_SSHD_EXTRA_ARGS="${HOME_SSHD_EXTRA_ARGS:-}"

# addusers <first uid> <default shell> [<github:[shell]>...]
addusers() {
  local FIRSTUID=$1
  shift
  local DEFAULT_SHELL=$1
  shift
  for u in "$@"; do
    USER=$(echo $u | cut -d: -f 1)
    USER_SHELL=$(echo $u | cut -d: -f 2)

    ADDUSER_ARGS=""
    UID=""
    GID=""

    # if home directory for this user exists
    if test -d "$HOME_BASEDIR/$USER"; then
      UID=$(/bin/ls -nld $HOME_BASEDIR/$USER | cut -d' ' -f3)
      GID=$(/bin/ls -nld $HOME_BASEDIR/$USER | cut -d' ' -f4)

      addgroup --gid $GID $USER
      ADDUSER_ARGS="--uid $UID --gid $GID"
    fi

    HOME=$HOME_BASEDIR/$USER

    adduser $USER --firstuid $FIRSTUID --shell ${USER_SHELL:-$DEFAULT_SHELL} --home $HOME $ADDUSER_ARGS < /dev/null

    if test "x$UID" = "x"; then
      UID=$(/bin/ls -nld $HOME | cut -d' ' -f3)
      GID=$(/bin/ls -nld $HOME | cut -d' ' -f4)
    fi

    # Adds ssh keys
    install -m 700 -o $UID -g $GID -d $HOME/.ssh/
    curl -o $HOME/.ssh/authorized_keys https://github.com/$USER.keys
    chown $UID:$GID $HOME/.ssh/authorized_keys
    chmod 600 $HOME/.ssh/authorized_keys

    # authorize gcp
    sudo -i -u ${USER} gcloud auth activate-service-account \
      <account> \
      --key-file=${HOME}/.config/gcloud/credentials.json
  done
}

mkdir -p /opt/local/home/log

# supervisor
sed -e "s/@HOME_SSHD_EXTRA_ARGS@/$HOME_SSHD_EXTRA_ARGS/" \
    < /etc/supervisor/conf.d/home.conf.in \
    > /etc/supervisor/conf.d/home.conf
install -d $SUPERVISOR_BASEDIR

addusers 1000 /bin/bash $HOME_USERS

# export environment variables for all users
cat >> /etc/profile.d/home.sh <<EOF
export DOCKER_HOST=$DOCKER_HOST
export AWS_ACCESS_KEY_ID=${AWS_IAM_ACCESS_KEY_ID}
export AWS_SECRET_ACCESS_KEY=${AWS_IAM_SECRET_KEY}
EOF

grep "^. /etc/bash_completion" /etc/bash.bashrc > /dev/null || cat >> /etc/bash.bashrc <<EOF
. /etc/bash_completion
EOF

# add sudoers
for user in $HOME_SUDOERS; do
  cat >> /etc/sudoers.d/home <<EOF
$user ALL=(ALL:ALL) NOPASSWD:ALL
EOF
done

# symbolic link
rmdir /home
ln -sfT $HOME_BASEDIR /home

if test "x$1" = "x"; then
  exec /bin/bash
else
  exec "$@"
fi

