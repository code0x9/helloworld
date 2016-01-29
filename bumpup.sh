#!/usr/bin/env bash
### date modified: 2016년 1월 29일 금요일 13시 33분 18초 KST/
sed -i "2 d" $0
sed -i "2 i ### date modified: $(date)/" $0

git commit -a -m "bump up"
git push