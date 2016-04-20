#!/usr/bin/env bash
### date modified: 2016년 4월 20일 수요일 15시 45분 12초 KST/
sed -i "2 d" $0
sed -i "2 i ### date modified: $(date)/" $0

git commit -a -m "bump up"
git push