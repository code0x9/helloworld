#!/usr/bin/env bash
### date modified: 2016년 4월 22일 금요일 17시 32분 30초 KST/
sed -i "2 d" $0
sed -i "2 i ### date modified: $(date)/" $0

VER=$(cat VERSION)
echo $((VER+1)) > VERSION

git commit -a -m "bump up"
git push
