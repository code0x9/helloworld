#!/usr/bin/env bash
### date modified: 2016년 5월  7일 토요일 12시 48분 02초 KST/
sed -i "2 d" $0
sed -i "2 i ### date modified: $(date)/" $0

VER=$(cat VERSION)
echo $((VER+1)) > VERSION

git commit -a -m "bump up"
git push
