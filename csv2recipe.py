#!/usr/bin/env python3
import sys, csv

def main():
    if len(sys.argv) != 3:
        print(f"Usage: {sys.argv[0]} <input.csv> <output.legacy>")
        sys.exit(1)
    with open(sys.argv[1], 'r', newline='') as infile, open(sys.argv[2], 'w') as outfile:
        reader = csv.DictReader(infile)
        for row in reader:
            fields = [
                row.get('name', ''),
                row.get('dir', ''),
                row.get('url', ''),
                row.get('git_branch', ''),
                row.get('enabled', ''),
                row.get('command', ''),
                row.get('makefile', ''),
                row.get('subdir', ''),
            ]
            args = row.get('args', '').strip()
            line = ' '.join(fields)
            if args:
                line += ' ' + args
            outfile.write(line.strip() + '\n')

if __name__ == '__main__':
    main()
