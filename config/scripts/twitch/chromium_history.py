#!/usr/bin/env python3
import sqlite3
from datetime import datetime, timedelta

import os

home = os.environ['HOME']

history_db = f"{home}/.config/chromium/Default/History"
history_db_ = f"{home}/.config/chromium/Default/History_Double"

import shutil
shutil.copy(history_db, history_db_)

# history_db = history_db_

def chrome_time_to_datetime(chrome_time):
    epoch_start = datetime(1601, 1, 1)
    return epoch_start + timedelta(microseconds=chrome_time)

# Conecta em modo somente leitura
conn = sqlite3.connect(f"file:{history_db_}?mode=ro", uri=True)
cursor = conn.cursor()

cursor.execute("""
    SELECT url, title, last_visit_time
    FROM urls
    ORDER BY last_visit_time DESC
""")

entries = cursor.fetchall()
import re

few = [(url, title, last_visit_time) for (url, title, last_visit_time) in entries if len(re.findall("https://www.twitch.tv/[^/]+$", url))]

def skip(few):
    few = [
        (url, title, last_visit_time) for
        (url, title, last_visit_time) in few
        if all(not token in url for token in ['directory', 'search'])
    ]
    return few

few = skip(few)

for (url, title, last_visit_time) in few:
    x = re.findall(r'https://www.twitch.tv/([^?]+)', url)
    print(x[0])

conn.close()
