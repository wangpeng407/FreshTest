wc -l /TJPROJ1/MICRO/wangpeng/NewTest/linux_file/test.m8

awk 'END{print NF}' /TJPROJ1/MICRO/wangpeng/NewTest/linux_file/test.m8 

grep -w A0.1_100 test.m8 | wc -l 

awk '$1~/A0.1_100$/ && $3 >=50 {print }' test.m8 > A0.1_100_iden50.m8

awk '$1~/A0.1_100$/ && $3 >=50 {print }' test.m8 | sort -k 12 -n > A0.1_100_iden50.sort.m8

awk '{print $1}' test.m8 | sort | uniq | wc -l 

awk '{print $1}' test.m8 | sort | uniq > uniq_id.list

awk '{s+=$2} END{print s}' seq.len.xls

grep -f uniq_id.list -w seq.len.xls > uniq_id.len.xls

awk '$2>100 && $2<=500 {print }' seq.len.xls | sort -k2 -r > sort.seq.len.xls

sed -e 's/\./_test_/g' sort.seq.len.xls  > sed.sort.seq.len.xls

