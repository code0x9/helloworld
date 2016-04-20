#!/usr/bin/env bash
### date modified: 2016년 4월 20일 수요일 12시 00분 11초 KST/
sed -i "2 d" $0
sed -i "2 i ### date modified: $(date)/" $0

git commit -a -m "bump up"
git push