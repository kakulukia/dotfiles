#!/usr/bin/env python3
""" to run the script, open a second iTerm window and enjoy the show """
import iterm2
from random import random
from time import sleep


async def send_text(value, session):
    last_char = ''
    for char in value:

        schlaf = random()*0.1+0.05+0.5
        if char == last_char:
            schlaf+=0
        if last_char in '.!?#ß' and char == ' ':
            schlaf += 0.5
        if char in '|':
            schlaf += 1

        if (char == 'ü') or (last_char == 'ü' and char == '\n'):
            last_char = char
            continue
        last_char = char
        sleep(schlaf)

        print(char)

        if char == 'ß':
            sleep(1)
            await session.async_send_text('\t')
        elif char == "L":
            await session.async_send_text(chr(iterm2.Keycode.LEFT_ARROW.value))
        elif char == "R":
            await session.async_send_text(chr(iterm2.Keycode.RIGHT_ARROW.value))
        elif char == "U":
            arrow = chr(27) + chr(91) + chr(65)
            await session.async_send_text(arrow)
        elif char == "D":
            arrow = chr(27) + chr(91) + chr(66)
            await session.async_send_text(arrow)
        else:
            if char == '\n':
                print('Enter')
            await session.async_send_text(char)

        if char == '\n':
            sleep(0.5)


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
