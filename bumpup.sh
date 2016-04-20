#!/usr/bin/env bash
### date modified: 2016년 4월 20일 수요일 11시 59분 37초 KST/
sed -i "2 d" $0
sed -i "2 i ### date modified: $(date)/" $0

git commit -a -m "bump up"
git push