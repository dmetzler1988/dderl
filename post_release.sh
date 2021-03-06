. $(dirname $0)/common.sh

log green "-------------------------------------------------------------------------"
app=${1:-dderl}
log green "post_release $app @ $(pwd)"

dderlPriv=$(readlink -f _build/prod/rel/$app/lib/dderl-*/priv/)
log lightgrey "building dderl @ $dderlPriv"

if [ -d "$dderlPriv/dev/node_modules" ]; then
    log red "$dderlPriv/dev/node_modules already exists"
	exit 1
fi

if [ -d "$dderlPriv/public/dist" ]; then
    log red "$dderlPriv/public/dist already exists"
    exit 1
fi

cd $dderlPriv/dev
log green "yarn install-build-prod @ $(pwd)"
yarn install-build-prod

# cleanup
cd $dderlPriv
rm -rf $dderlPriv/dev
log green "dir $dderlPriv/dev deleted"

log green "------------------------------------------------------------ post_release"
