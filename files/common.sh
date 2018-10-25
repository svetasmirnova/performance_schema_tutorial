export CLIENT_ID=$USER
export SANDBOX_HOME=/home/$USER/sandboxes
export TMPDIR=/home/$USER/tmp
export SANDBOX_PORT=$(( ($UID - 1000)*10 + 2048 ))
mkdir -p $TMPDIR

function cleanup() {
  cd
  pkill -9 -u $USER -f mysql
  pkill -9 -u $USER -f sysbench
  pkill -9 -u $USER -f tmux
  rm -rf /home/$USER/sandboxes/*
  rm -rf $TMPDIR/*
}

trap cleanup SIGHUP SIGTERM

cleanup

