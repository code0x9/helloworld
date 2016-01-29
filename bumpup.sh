#!/usr/bin/env bash
### date modified: 2016년 1월 29일 금요일 13시 51분 21초 KST/
sed -i "2 d" $0
sed -i "2 i ### date modified: $(date)/" $0

git commit -a -m "bump up"
git push