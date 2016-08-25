
PREFIX=`realpath $(cd "$(dirname "$0")"; pwd)/..`
cd $PREFIX
wget https://raw.githubusercontent.com/RubyLouvre/avalon/master/dist/avalon.modern.js
mv avalon.modern.js src/js/
hg diff
hg ci -m "update avalon"
hg push
