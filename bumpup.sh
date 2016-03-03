#!/usr/bin/env bash
### date modified: 2016년 3월  3일 목요일 13시 59분 21초 KST/
sed -i "2 d" $0
sed -i "2 i ### date modified: $(date)/" $0

git commit -a -m "bump up"
git push