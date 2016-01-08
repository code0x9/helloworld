#!/usr/bin/env bash
### date modified: 2016년 1월  8일 금요일 15시 59분 13초 KST/
sed -i "2 d" $0
sed -i "2 i ### date modified: $(date)/" $0

git commit -a -m "bump up"
git push