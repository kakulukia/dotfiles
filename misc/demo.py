#!/usr/bin/env python3

import iterm2
from random import random
from time import sleep

async def send_text(value, session):
    last_char = ''
    for char in value:

        schlaf = random()*0.1+0.05
        if char == last_char:
            schlaf+=0
        if last_char in '.,!?#ß' and char == ' ':
            schlaf += 0.5
        if char in '|':
            schlaf += 1

        if (char == 'ü') or (last_char == 'ü' and char == '\n'):
            last_char = char
            continue
        last_char = char
        sleep(schlaf)

        if char == 'ß':
            sleep(1)
            await session.async_send_text('\t')
        else:
            await session.async_send_text(char)
    


async def main(connection):
    app = await iterm2.async_get_app(connection)
    session = None
    current_window = app.current_window 
    for window in app.terminal_windows:
        if window == current_window:
            continue 
        for tab in window.tabs:
            for s in tab.sessions:
                session = s
    if not session:
       print('no session found')
       return

    with open('demo-script.txt', 'r') as source:
        for line in source.readlines():

            if 'SLEEP' in line:
                schlaf = int(line.split(':')[1])
                sleep(schlaf)
            elif 'BREAK' in line:
                break
            else:
                await send_text(line, session)

iterm2.run_until_complete(main)