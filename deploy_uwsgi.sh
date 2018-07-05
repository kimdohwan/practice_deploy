#!/usr/bin/env bash

CMD_CONNECT="ssh -i $HOME/.ssh/fc-doh.pem ubuntu@ec2-52-79-201-93.ap-northeast-2.compute.amazonaws.com"
SERVER_DIR="/home/ubuntu/practice_ec2"
PROJECT_DIR="$HOME/projects/deploy/practice_ec2"

${CMD_CONNECT} pkill -ef :8000
${CMD_CONNECT} rm -rf ${SERVER_DIR}
scp -q -i $HOME/.ssh/fc-doh.pem -r ${PROJECT_DIR} ubuntu@ec2-52-79-201-93.ap-northeast-2.compute.amazonaws.com:${SERVER_DIR}

echo  -finish copy
echo $SERVER_DIR

${CMD_CONNECT} pipenv install uwsgi

#VENV_PATH=$(${CMD_CONNECT} "cd ${SERVER_DIR} && pipenv --venv")
#echo $VENV_PATH
#${CMD_CONNECT} "cd ${SERVER_DIR} && nohup ${VENV_PATH}/bin/uwsgi --http :8000 --module config.wsgi --home ${VENV_PATH} --chdir ${SERVER_DIR}/app &>/dev/null &"

VENV_PATH=$(${CMD_CONNECT} "cd ${SERVER_DIR} && pipenv --venv")
echo $VENV_PATH
${CMD_CONNECT} "cd ${SERVER_DIR}/app && nohup ${VENV_PATH}/bin/uwsgi --ini .config/uwsgi.sh &>/dev/null &"

