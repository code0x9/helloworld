#!/usr/bin/env bash
### date modified: 2016년 2월  2일 화요일 11시 51분 06초 KST/
sed -i "2 d" $0
sed -i "2 i ### date modified: $(date)/" $0

git commit -a -m "bump up"
git push