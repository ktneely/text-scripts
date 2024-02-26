
## edgarHTML2MD.sh

Because the sec-downloader file below extracts information from EDGAR
in the raw HTML format, filled with XML and CSS, this quick script
uses `pandoc` to convert the file to Markdown and drops the first 2
lines, which are usually a lot of junk we don't want.

### Setup

This file expects the source to have been downloade with the
`sec-downloader.py` script below and that there is a directory
structure like `filings/html` and `filings/md` available.  Intended to
work on Linux, but probably works on Mac, as well.  Windows users will
need to adjust pathing or use WSL.

## rssfeeds2txt.py
Takes articles from an RSSguard database and converts them into text or Markdown format

**Example:**
`/rssfeeds2txt.py -f markdown ~/.config/RSS\ Guard\ 4/database/database.db ~/Documents/Articles/`


## sec-downloader.py
Pulls down information from the SEC's EDGAR site
for corporate filings.  This version is focused on the 10-K filings.
The specified ticker symbols file should be a list of symbols, with
one symbol per line.

**Example:**
`python ./sec-downloader.py ticker-symbols.txt`


## splitstring.sh

creates csv from "01Country99", separating it into the rank, country, score



