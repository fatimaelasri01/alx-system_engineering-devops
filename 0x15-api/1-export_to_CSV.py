#!/usr/bin/python3
"""exports data in the CSV format"""
import csv
import requests
import sys


if __name__ == "__main__":
    user_id = sys.argv[1]
    url = "https://jsonplaceholder.typicode.com/"
    user = requests.get(f"{url}users/{user_id}").json()
    tasks = requests.get(f"{url}users/{user_id}/todos").json()
    d_rows = [
        [sys.argv[1], user.get("username"), task.get("completed"),
            task.get("title")] for task in tasks
    ]

    with open(f"{sys.argv[1]}.csv", "w", newline="") as file:
        writer = csv.writer(file, quoting=csv.QUOTE_ALL)
        for data in d_rows:
            writer.writerow(data)
