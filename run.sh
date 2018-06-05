#!/bin/sh

WATCH="${HUGO_WATCH:=false}"
SLEEP="${HUGO_REFRESH_TIME:=-1}"
HUGO_SRC="${HUGO_SRC:=/src}"
HUGO_DESTINATION="${HUGO_DESTINATION:=/output}"
HUGO_APPEND_PORT="${HUGO_APPEND_PORT:=false}"
echo "HUGO_WATCH:" $WATCH
echo "HUGO_REFRESH_TIME:" $HUGO_REFRESH_TIME
echo "ARGS" $@

HUGO=/usr/local/sbin/hugo
echo "Hugo path: $HUGO"

while [ true ]
do
    if [[ $HUGO_WATCH != 'false' ]]; then
	    echo "Watching..."
        $HUGO server --watch=true --source="$HUGO_SRC" --destination="$HUGO_DESTINATION" --appendPort="$HUGO_APPEND_PORT" --disableFastRender --bind="0.0.0.0" "$@" || exit 1
    else
	    echo "Building one time..."
        $HUGO --source="$HUGO_SRC" --destination="$HUGO_DESTINATION" --appendPort="$HUGO_APPEND_PORT" "$@" || exit 1
    fi

    if [[ $HUGO_REFRESH_TIME == -1 ]]; then
        exit 0
    fi
    echo "Sleeping for $HUGO_REFRESH_TIME seconds..."
    sleep $SLEEP
done
