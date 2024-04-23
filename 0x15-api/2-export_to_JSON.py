#!/usr/bin/python3
"""exports data in JSON format"""

import json
import requests
import sys


if __name__ == "__main__":
    user_id = sys.argv[1]
    url = "https://jsonplaceholder.typicode.com/"
    user = requests.get("{url}users/{user_id}").json()
    tasks = requests.get("{url}users/{user_id}/todos").json()
    data_dict = {
                user_id: [{"task": task.get("title"),
                           "completed": task.get("completed"),
                           "username": user.get("username")} for task in tasks]
            }
    with open(f"{user_id}.json", "w", newline="") as file:
        json.dump(data_dict, file)
