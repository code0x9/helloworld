#!/usr/bin/env bash
### date modified: 2016년 4월 21일 목요일 16시 29분 27초 KST/
sed -i "2 d" $0
sed -i "2 i ### date modified: $(date)/" $0

VER=$(cat VERSION)
echo $((VER+1)) > VERSION

git commit -a -m "bump up"
git push
