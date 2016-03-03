#!/usr/bin/env bash
### date modified: 2016년 3월  3일 목요일 15시 20분 49초 KST/
sed -i "2 d" $0
sed -i "2 i ### date modified: $(date)/" $0

git commit -a -m "bump up"
git push