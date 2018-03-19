# Fix ownership and permissions
sudo chmod 775 $SHARED_DIR $WORK_DIR $CCACHE_DIR $OUT_DIR $INIT_DIR
sudo chown $USER:$USER $SHARED_DIR $WORK_DIR $CCACHE_DIR $OUT_DIR $INIT_DIR

# add Android SDK platform tools to path
if [ -d "$INIT_DIR/platform-tools" ] ; then
    PATH="$INIT_DIR/platform-tools:$PATH"
fi

# Initialize ccache if needed
if [ ! -f $CCACHE_DIR/ccache.conf ]; then
	echo "Initializing ccache in $CCACHE_DIR..."
	ccache -M 50G
fi
export USE_CCACHE=0
export CCACHE_COMPRESS=1
export ANDROID_JACK_VM_ARGS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx4G"
sudo apt-get install git-core gnupg flex bison gperf build-essential zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z-dev ccache libgl1-mesa-dev libxml2-utils xsltproc unzip
mkdir LineageOS
cd LineageOS/
git config --global user.name "Sean Taylor"
git config --global user.email "sean.r.taylor.1912@gmail.com"
repo init -u git://github.com/LineageOS/android.git -b lineage-15.1
repo sync
source build/envsetup.sh
brunch lineage_a3xeltexx-userdebug
# Show general info
screenfetch
