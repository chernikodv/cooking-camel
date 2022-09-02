import csv, json, sqlalchemy

path = "/home/zachhilman/Downloads/full_dataset.csv"

s = set()

with open(path) as file:
    reader = csv.reader(file)
    first = True
    for row in reader:
        if first:
            first = False
            continue
        j = json.loads(row[6])
        for v in j:
            s.add(v.replace('-', '').replace('\'', ''))

o = open('out.sql', 'w')

o.write('insert into "ingredient" values ')
first = True
for i in s:
    if first:
        first = False
    else:
        o.write(',')
    o.write('(default, \'%s\')' % i)
o.write(';')