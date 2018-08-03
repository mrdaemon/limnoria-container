#!/usr/bin/env bash
# Super non-optimal startup wrapper for the limnoria process.

# Sanity checks
# While not strictly necessary, they help in debugging common issues
# in docker containers.
if [[ ! -w $LIMNORIA_HOME ]] ; then
    >&2 echo "WARNING: Home directory \"$LIMNORIA_HOME\" is not writable"
    >&2 echo "  Did you set permissions on the volume correctly?"
fi

if [[ ! -w $LIMNORIA_HOME/$LIMNORIA_CONFIG ]] ; then
    >&2 echo "WARNING: Configuration \"$LIMNORIA_CONFIG\" is not writable"
    >&2 echo "  Is your data volume configured correctly?"
    >&2 echo "  Do you need to run 'supybot-create' first?"
fi

# Enter home directory and hand off to limnoria
cd "$LIMNORIA_HOME" || exit 1
exec supybot "$LIMNORIA_CONFIG"





 
