#!/usr/bin/python3

import argparse
import sqlite3
import html2text
from datetime import datetime
import os.path

def convert_to_iso8601(timestamp):
    return datetime.utcfromtimestamp(timestamp / 1000).isoformat()

# Markdown format conversion for e.g. import into Obsidian.md
def convert_html_to_markdown(html):
    h = html2text.HTML2Text()
    h.body_width = 0
    return h.handle(html)

# The plaintext version is meant to really be stripped of everything
# The original URL is placed at the top of the article, so it can be
# retrieved with all the formatting
def convert_html_to_text(html):
    h = html2text.HTML2Text()
    h.body_width = 0
    h.ignore_links = True
    h.ignore_images = True
    h.ignore_tables = True
    h.ignore_emphasis = True
    return h.handle(html)

def extract_messages_from_database(database_path):
    try:
        conn = sqlite3.connect(database_path)
        c = conn.cursor()
        c.execute("SELECT m.id, m.title, m.date_created, m.url, m.contents, m.feed, c.title, m.author "
                  "FROM Messages m "
                  "INNER JOIN Feeds f ON m.feed = f.id "
                  "INNER JOIN Categories c ON f.category = c.id")
        messages = c.fetchall()
        conn.close()
        return messages
    except sqlite3.Error as e:
        print("Error connecting to the database:", e)
        return []

def create_text_documents(messages, output_path, output_format):
    for message in messages:
        message_id = message[0]
        title = message[1]
        date_created = message[2]
        url = message[3]
        contents = message[4]
        feed = message[5]
        category = message[6]
        author = message[7]

        # create the correct extension 
        if output_format == "markdown":
            filename = os.path.join(output_path, f"rssarticle-{message_id}.md")
        else:
            filename = os.path.join(output_path, f"rssarticle-{message_id}.txt")

            
        # skip files processed on a previous run
        if os.path.exists(filename):
            print(f"Skipping existing file: {filename}")
            continue


        with open(filename, "w") as file:
            if output_format == "markdown":
                file.write("---\n")
                file.write(f"title: \"{title}\"\n")
                file.write(f"date_created: {convert_to_iso8601(date_created)}\n")
                file.write(f"author: \"{author}\"\n")
                file.write(f"tags: #rss, #{category}\n")
                file.write("---\n\n")
                file.write(f"# {title}\n\n")
                file.write(convert_html_to_markdown(contents))
            else:
                file.write(f"{title}\n")
                file.write(url + "\n\n")
                file.write(convert_html_to_text(contents))

        print(f"Created file: {filename}")  # print successful creation notice
        
if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Extract messages from a SQLite database and create text documents.")
    parser.add_argument("database_file", help="Path to the SQLite database file")
    parser.add_argument("output_path", help="Path to the output directory")
    parser.add_argument("-f", "--format", choices=["markdown", "plaintext"], default="plaintext",
                        help="Output format for the contents field: 'markdown' or 'plaintext' (default: plaintext)")

    args = parser.parse_args()
    database_file = args.database_file
    output_path = args.output_path
    output_format = args.format

    if not os.path.exists(output_path):
        os.makedirs(output_path)

    messages = extract_messages_from_database(database_file)
    create_text_documents(messages, output_path, output_format)
