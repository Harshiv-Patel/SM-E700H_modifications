#!/system/bin/sh
# script to reset device resolution every boot.
# Intended to work with root via magisk.
# this file's location should be /data/adb/service.d/wminit.sh
# permissions : chmod 0700
# or -rwx------

# the log file in case anything goes wrong
# can be put into "/data/local" or "/data/media/0" aka sdcard
exec >/data/media/0/r_reset.log 2>&1
# should go to log file
echo $(date)": running now : resolution reset script to be run after each boot complete\n"

# wait till boot completes, otherwise wm command wouldn't be available
# perhaps it's better to repeat for limited number of times
# TODO : limit sleep to 10-30 seconds, via a repeat count

while [ "$(getprop sys.boot_completed)" != 1 ];
do sleep 1;
done

# if we boot successfully, reset the resolution 720x1280
status="empty"

echo $(date)" : now attempting to reset the device resolution...\n"
wm size reset && status="successfull!" || status="failed!"

echo $(date)" : resolution reset $status\n"

# hopefully this can reset resolution, every time there is a mess up
# just restarting the device should do the trick.
exit 0
