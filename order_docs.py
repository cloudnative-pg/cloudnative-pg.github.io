from pathlib import Path
from argparse import ArgumentParser

parser = ArgumentParser()
parser.add_argument('config')
parser.add_argument('location')
args = parser.parse_args()

config = Path(args.config).read_text()
in_nav = False
counter = 0
order = {}
for l in config.split("\n"):
    if ':' in l:
        if l == "nav:":
            in_nav = True
        else:
            in_nav = False
    else:
        if in_nav:
            parts = l.split('-', 1)
            if len(parts) > 1 and parts[1].strip() != 'index.md':
                counter += 1
                order[counter] = parts[1].strip()

pad = 2
if len(order) > 99:
    pad = 3
for k, v in order.items():
    fmt_string = f'0{pad}d'
    print(f'{k:{fmt_string}}_{v}')
    Path(f'{args.location}/{v}').rename(f'{args.location}/{k:{fmt_string}}_{v}')