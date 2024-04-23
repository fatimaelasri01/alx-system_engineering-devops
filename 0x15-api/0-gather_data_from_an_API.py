#!/usr/bin/python3
"""Returns info about todo list progress for a given employee ID using API"""
import requests
import sys

if __name__ == "__main__":
    url = "https://jsonplaceholder.typicode.com/"
    name = requests.get(f"{url}users/{sys.argv[1]}").json()
    tasks = requests.get(f"{url}users/{sys.argv[1]}/todos").json()
    cp_tasks = [task for task in tasks if task.get("completed")]
    cp_titles = [task.get("title") for task in cp_tasks]
    print("Employee {} is done with tasks({}/{}):"
          .format(name.get("name"), len(cp_tasks), len(tasks)))
    for title in cp_titles:
        print(f"\t {title}")
