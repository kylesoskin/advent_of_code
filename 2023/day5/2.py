import time

class Seed:
    def __init__(self, num):
        self.num = int(num)

    def map_eval(self, i, n, maps):
        m1, m2 = next(((sr, dr) for sr, dr in maps[i].mappings.items() if sr.start <= n < sr.stop), (None, None))
        if m1 is None or m2 is None:
            return n
        else:
            return (n - m1.start) + m2.start

    def find_location(self, maps):
        soil = self.map_eval(0, self.num, maps)
        fertilizer = self.map_eval(1, soil, maps)
        water = self.map_eval(2, fertilizer, maps)
        light = self.map_eval(3, water, maps)
        temperature = self.map_eval(4, light, maps)
        humidity = self.map_eval(5, temperature, maps)
        location = self.map_eval(6, humidity, maps)
        return location


class AlmanacMap:
    def __init__(self, heading):
        parts = heading.split(' ')
        self.source_type, _, self.dest_type = parts[0].split('-')
        self.mappings = {}

    def add_to_mapping(self, m):
        dest_range, source_range, length = map(int, m.split(' '))
        dr = range(dest_range, dest_range + length)
        sr = range(source_range, source_range + length)
        self.mappings[sr] = dr


all_lines = open('input.txt').read().splitlines()
seeds_line = all_lines.pop(0)
seeds_l = seeds_line.split(":")[-1].lstrip().split(" ")
it = iter(seeds_l)
seeds = []
for x in it:
  o = int(x)
  seeds.append(range(o, o + int(next(it)) - 1))


maps = []
current_map = None

for line in all_lines:
  if line:
    if line[0].isdigit():
        current_map.add_to_mapping(line)
    elif line[0].isalpha():
        map_obj = AlmanacMap(line)
        current_map = map_obj
        maps.append(map_obj)

lowest = None
seed_count = len(seeds) - 1
current_seed = 0

for s in seeds:
    print(f"({current_seed}/{seed_count})::{time.strftime('%Y-%m-%d %H:%M:%S')}:: Working seeds in range: {s} ({s[-1] - s[0]})")
    for n in s:
        location = Seed(n).find_location(maps)
        if lowest is None or location < lowest:
            lowest = location
    current_seed += 1

print(lowest)
