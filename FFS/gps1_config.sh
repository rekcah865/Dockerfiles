#!/bin/env sh

## version 7.31
VER=731 

SRVFILE=/s01/FISGetPutServer/$VER/GetPutServer.srv
if [ -f $SRVFILE ] ; then
        [ ! -z "$NAME" ] && sed -ri 's/NAME=/NAME='"$NAME"'/g' $SRVFILE
        [ ! -z "$PRIMARYAGENT" ] && sed -ri 's/PRIMARYAGENT=/PRIMARYAGENT='"$PRIMARYAGENT"'/g' $SRVFILE
        [ ! -z "$PRIMARYAGENTPORT" ] && sed -ri 's/PRIMARYAGENTPORT=/PRIMARYAGENTPORT='"$PRIMARYAGENTPORT"'/g' $SRVFILE
        [ ! -z "$SECONDARYAGENT" ] && sed -ri 's/SECONDARYAGENT=/SECONDARYAGENT='"$SECONDARYAGENT"'/g' $SRVFILE
        [ ! -z "$SECONDARYAGENTPORT" ] && sed -ri 's/SECONDARYAGENTPORT=/SECONDARYAGENTPORT='"$SECONDARYAGENTPORT"'/g' $SRVFILE
        [ ! -z "$TERTIARYAGENT" ] && sed -ri 's/TERTIARYAGENT=/TERTIARYAGENT='"$TERTIARYAGENT"'/g' $SRVFILE
        [ ! -z "$TERTIARYAGENTPORT" ] && sed -ri 's/TERTIARYAGENTPORT=/TERTIARYAGENTPORT='"$TERTIARYAGENTPORT"'/g' $SRVFILE
        [ ! -z "$LISTENPORT" ] && sed -ri 's/LISTENPORT=2915/LISTENPORT='"$LISTENPORT"'/g' $SRVFILE
        [ ! -z "$CLIENTPORT" ] && sed -ri 's/CLIENTPORT=2916/CLIENTPORT='"$CLIENTPORT"'/g' $SRVFILE
        echo "$SRVFILE updated"
else
	echo "$SRVFILE not found"
fi