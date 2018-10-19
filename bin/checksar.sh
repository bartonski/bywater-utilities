#! /bin/sh

SAR_OUT_DIR=sar_$(date +%Y%m%d)
[[ -d "$SAR_OUT_DIR" ]] ||  mkdir $SAR_OUT_DIR

for sarfile in /var/log/sysstat/sa[0-9][0-9]; do
    base="$SAR_OUT_DIR/$(basename $sarfile)"
    sar -f $sarfile > $base.general
    sar -q -f $sarfile > $base.load
    sar -r -f $sarfile > $base.memory
    sar -p -d -f $sarfile > $base.disk_io
done


# TODO: These should show the file name of the activity report where bad stats show up.
# TODO: Do a better job of excluding data that we don't want
echo check idle below 50%
for i in $SAR_OUT_DIR/*.general; do  awk '{print $8}' $i | perl -ne 'print $_ if( $_ < 50.0 )'; done

echo "Divide load averages by the number of processors: "
lscpu | grep "^CPU"

echo "check load where ldavg-1 > 8.0"
for i in $SAR_OUT_DIR/*.load; do  awk '{print $4}' $i | perl -ne 'print $_ if( $_ > 8.0 )'; done

echo "check load where ldavg-5 > 8.0"
for i in $SAR_OUT_DIR/*.load; do  awk '{print $5}' $i | perl -ne 'print $_ if( $_ > 8.0 )'; done

echo "check load where ldavg-15 > 8.0"
for i in $SAR_OUT_DIR/*.load; do  awk '{print $6}' $i | perl -ne 'print $_ if( $_ > 8.0 )'; done

echo "show memory if '%commit' is greater than 60%"
for i in $SAR_OUT_DIR/*.memory; do  awk '{print $8}' $i | perl -ne 'print $_ if( $_ > 60.0 )'; done

