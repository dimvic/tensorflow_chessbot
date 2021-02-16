#!/bin/bash

#
# 1. create auth_config.py:
#     USERNAME=''
#     PASSWORD=''
#     USER_AGENT=''
# 2. create ./images directory and put chessboard image jpg or png to parse
# 3. docker-compose up
#    -> docker run --rm -t -v `pwd`/run_generator.sh:/tcb/run_generator.sh -v `pwd`/auth_config.py:/tcb/auth_config.py -v `pwd`/images:/images --entrypoint /tcb/run_generator.sh chess_fen_generator
#

IFS='
'

for i in `find /images -type f -iname 'jpg' -or -iname '*.jpeg' -or -iname '*.png'`; do
    /tcb/tensorflow_chessbot.py --filepath "${i}" > "${i}.fan" 2>&1
    tail -n2 "${i}.fan" | head -n1 > "${i}.fen"
done

ls -1 /images
