#!/bin/bash

# simply converts all html files in the filings/html directory
# to simplified Markdown files in the filings/md directory
# Works on the massively over-formatted EDGAR docs from the SEC
# but should work on other HTML files, as well
#
# This drops the first 4 lines, as they are often complete trash

for file in filings/html/*
do
    #    filename=`echo "${file% .*}"`
    filename=$(basename "$file" .html)
    if [ ! -s filings/md/$filename.md ]; then
        echo "Now converting $filename ..."
	pandoc -f html -t markdown_github-raw_html $file |tail -n +4 > filings/md/$filename.md
    fi
done
