#!/usr/bin/env bash
# Base16 - Gnome Terminal color scheme install script
#### SOURCE: https://terminal.sexy/

[[ -z "$PROFILE_NAME" ]] && PROFILE_NAME="My Theme"
[[ -z "$PROFILE_SLUG" ]] && PROFILE_SLUG=""
[[ -z "$DCONF" ]] && DCONF=dconf
[[ -z "$UUIDGEN" ]] && UUIDGEN=uuidgen

dset() {
    local key="$1"; shift
    local val="$1"; shift

    if [[ "$type" == "string" ]]; then
        val="'$val'"
    fi

    "$DCONF" write "$PROFILE_KEY/$key" "$val"
}

# because dconf still doesn't have "append"
dlist_append() {
    local key="$1"; shift
    local val="$1"; shift

    local entries="$(
        {
            "$DCONF" read "$key" | tr -d '[]' | tr , "\n" | fgrep -v "$val"
            echo "'$val'"
        } | head -c-1 | tr "\n" ,
    )"

    "$DCONF" write "$key" "[$entries]"
}

usage ()
{
    printf "\
        -bg | --background-color \n\t set terminal background color\n
        -fg | --foreground-color \n\t set terminal foreground color\n
        -p  | --palette \n\t set terminal color palette\n
        -i  | --id\n\t append to theme with this id number\n
        -n  | --name \n\t set profile name\n
        -h  | --help \n\t print help page\n
    "
}

BACKGROUND_COLOR="#000000"
FOREGROUND_COLOR="#ffffff"
PALETTE="['#282a2e', '#a54242', '#8c9440', '#de935f', '#5f819d', '#85678f', '#5e8d87', '#707880', '#373b41', '#cc6666', '#b5bd68', '#f0c674', '#81a2be', '#b294bb', '#8abeb7', '#c5c8c6']"

while [ "$1" != "" ]; do
    case $1 in
        -bg | --background-color )
            shift
            BACKGROUND_COLOR=$1
            ;;
        -fg | --foreground-color )
            shift
            FOREGROUND_COLOR=$1
            ;;
        -p | --palette)
            shift
            PALETTE=$1
            ;;
        -i | --id)
            shift
            PROFILE_SLUG=$1
            ;;
        -n | --name)
            shift
            PROFILE_NAME=$1
            ;;
        -h | --help )
            usage
            exit
            ;;
        * )
            usage
            exit 1
    esac
    shift
done


# Newest versions of gnome-terminal use dconf
if which "$DCONF" > /dev/null 2>&1; then
    [[ -z "$BASE_KEY_NEW" ]] && BASE_KEY_NEW=/org/gnome/terminal/legacy/profiles:

    if [[ -n "`$DCONF list $BASE_KEY_NEW/`" ]]; then
        if [[ -z $PROFILE_SLUG ]]; then
            if which "$UUIDGEN" > /dev/null 2>&1; then
                PROFILE_SLUG=`uuidgen`
            fi
        fi

        if [[ -n "`$DCONF read $BASE_KEY_NEW/default`" ]]; then
            DEFAULT_SLUG=`$DCONF read $BASE_KEY_NEW/default | tr -d \'`
        else
            DEFAULT_SLUG=`$DCONF list $BASE_KEY_NEW/ | grep '^:' | head -n1 | tr -d :/`
        fi

        DEFAULT_KEY="$BASE_KEY_NEW/:$DEFAULT_SLUG"
        PROFILE_KEY="$BASE_KEY_NEW/:$PROFILE_SLUG"

        # copy existing settings from default profile
        $DCONF dump "$DEFAULT_KEY/" | $DCONF load "$PROFILE_KEY/"

        # add new copy to list of profiles
        dlist_append $BASE_KEY_NEW/list "$PROFILE_SLUG"

        # update profile values with theme options
        dset visible-name "'$PROFILE_NAME'"
        dset palette "$PALETTE"
        dset background-color "'$BACKGROUND_COLOR'"
        dset foreground-color "'$FOREGROUND_COLOR'"
        dset bold-color "'#c5c8c6'"
        dset bold-color-same-as-fg "true"
        dset use-theme-colors "false"
        dset use-theme-background "false"
        
        "$DCONF" write "$BASE_KEY_NEW/default" "'$PROFILE_SLUG'"

        unset PROFILE_NAME
        unset PROFILE_SLUG
        unset DCONF
        unset UUIDGEN
        exit 0
    fi
fi

exit -1
