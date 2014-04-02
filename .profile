## Machine Depenedeny Setting
## Brew
PREFIX_PATH=`brew --prefix > /dev/null 2>&1`

if [ -n $PREFIX_PATH ]; then
  export PATH=$PREFIX_PATH/bin:$PATH
fi

## Bash Completion
if [ -f $PREFIX_PATH/etc/bash_completion ]; then
  . $PREFIX_PATH/etc/bash_completion
fi

#UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

## SSH Agent

SSH_ENV="$HOME/.ssh/environment"

function start_agent {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
}

# Spwan SSH agent if no SSH forwarding
if [ -z "${SSH_AUTH_SOCK}" ]; then
  # Source SSH settings, if applicable
  if [ -f "${SSH_ENV}" ]; then
      . "${SSH_ENV}" > /dev/null
      #ps ${SSH_AGENT_PID} doesn't work under cywgin
      ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
          start_agent;
  }
  elif [ -n "${SSH_AUTH_SOCK}" ]; then
    start_agent;
  fi
fi
