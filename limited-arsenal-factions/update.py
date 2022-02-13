from argparse import ArgumentParser
from ast import parse
import os

def handle_file(filename: str, blank: list[str]):
    with open(filename) as f:
        content = f.readlines()
    data = ['[']
    data.extend([f'"{x}",' for x in blank])
    data.extend(['\n'])
    skip = True
    for line in content:
        # line2 = line.replace(',', '').replace('"', '').strip()
        # print(f"{line2=}")
        # if line2 in blank:
            # continue
        if '[' in line or ']' in line:
            continue
        # print(f"{line=}")
        if line == '\n':
            skip = False
            continue
        if skip:
            continue
        data.append(line.strip())
    data.append(']\n')
    with open(filename, 'w') as f:
        f.write('\n'.join(data))


if __name__ == '__main__':
    parser = ArgumentParser(description='Update all templates based on the blank template')
    parser.add_argument(type=str, dest='filename', help='blank template')
    args = parser.parse_args()
    blank_file = args.filename
    with open(blank_file) as f:
        blank = f.read().replace('[', '').replace(']', '').replace('"', '').replace(',' , '').strip().split('\n')

    for _, _, files in os.walk('.'):
        for filename in files:
            if filename == blank_file:
                continue
            if filename.endswith('.txt'):
                print(filename)
                handle_file(filename, blank)
