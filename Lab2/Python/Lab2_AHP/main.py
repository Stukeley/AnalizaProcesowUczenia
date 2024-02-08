from ahpy import ahpy
import itertools

# Kryteria wyboru telefonu: RAM, PAMIĘĆ, APARAT, CENA
criteria_comparisons = {('ram', 'pamiec'): 1, ('ram', 'aparat'): 1, ('ram', 'cena'): 1 / 3,
                        ('pamiec', 'aparat'): 1, ('pamiec', 'cena'): 1 / 3,
                        ('aparat', 'cena'): 1 / 3}

criteria = ahpy.Compare('Kryteria', criteria_comparisons, precision=3)

report = criteria.report(show=True)

# Tworzymy wszystkie możliwe pary telefonów
# Samsung Galaxy S23 Ultra
# Xiaomi 13
# Motorola moto G22
# Samsung Galaxy M33 5G
# Motorola edge 30 neo
# OPPO Find N2 Flip
# Motorola moto G82 5G
# Infinix SMART 6 HD
# Xiaomi Redmi Note 11s
# Samsung Galaxy S20 FE 5G
smartfony = ('Samsung Galaxy S23 Ultra', 'Xiaomi 13', 'Motorola moto G22', 'Samsung Galaxy M33 5G',
             'Motorola edge 30 neo', 'OPPO Find N2 Flip', 'Motorola moto G82 5G', 'Infinix SMART 6 HD',
             'Xiaomi Redmi Note 11s', 'Samsung Galaxy S20 FE 5G')

smartfony_pairs = list(itertools.combinations(smartfony, 2))

print(smartfony_pairs)

# Porównanie pod względem RAM
# 1	1	5	3	1	1	3	7	3	3
# 1	5	3	1	1	3	7	3	3
# 1	1/3	1/5	1/5	1/3	3	1/3	1/3
# 1	1/3	1/3	1	5	1	1
# 1	1	3	7	3	3
# 1	3	7	3	3
# 1	5	1	1
# 1	1/5	1/5
# 1	1
# 1
ram_values = (1, 5, 3, 1, 1, 3, 7, 3, 3,
              5, 3, 1, 1, 3, 7, 3, 3,
              1 / 3, 1 / 5, 1 / 5, 1 / 3, 3, 1 / 3, 1 / 3,
              1 / 3, 1 / 3, 1, 5, 1, 1,
              1, 3, 7, 3, 3,
              3, 7, 3, 3,
              5, 1, 1,
              1 / 5, 1 / 5,
              1)

print(len(smartfony_pairs) == len(ram_values))

ram_comparisons = dict(zip(smartfony_pairs, ram_values))
print(ram_comparisons)
# ('Samsung Galaxy S23 Ultra', 'Xiaomi 13'): 1  ...

# Porównanie pod względem PAMIĘĆ
# 1	1	5	3	3	1	3	9	7	3
# 1	5	3	3	1	3	9	7	3
# 1	1/3	1/3	1/5	1/3	3	1	1/3
# 1	1	1/3	1	7	5	1
# 1	1/3	1	5	3	1
# 1	3	7	5	3
# 1	5	3	1
# 1	1/3	1/5
# 1	1/3
# 1
pamiec_values = (1, 5, 3, 3, 1, 3, 9, 7, 3,
                 5, 3, 3, 1, 3, 9, 7, 3,
                 1 / 3, 1 / 3, 1 / 5, 1 / 3, 3, 1, 1 / 3,
                 1, 1 / 3, 1, 7, 5, 1,
                 1 / 3, 1, 5, 3, 1,
                 3, 7, 5, 3,
                 5, 3, 1,
                 1 / 3, 1 / 5,
                 1 / 3)

print(len(smartfony_pairs) == len(pamiec_values))

pamiec_comparisons = dict(zip(smartfony_pairs, pamiec_values))
# print(pamiec_comparisons)

# Porównanie pod względem APARAT
# 1	5	5	5	5	5	5	9	3	9
# 1	1	1	1	1	1	5	1/5	5
# 1	1	1	1	1	5	1/5	5
# 1	1	1	1	5	1/5	5
# 1	1	1	5	1/5	5
# 1	1	5	1/5	5
# 1	5	1/5	5
# 1	1/7	1
# 1	7
# 1
aparat_values = (5, 5, 5, 5, 5, 5, 9, 3, 9,
                 1, 1, 1, 1, 1, 5, 1 / 5, 5,
                 1, 1, 1, 1, 5, 1 / 5, 5,
                 1, 1, 1, 5, 1 / 5, 5,
                 1, 1, 5, 1 / 5, 5,
                 1, 5, 1 / 5, 5,
                 5, 1 / 5, 5,
                 1 / 7, 1,
                 7)

print(len(smartfony_pairs) == len(aparat_values))

aparat_comparisons = dict(zip(smartfony_pairs, aparat_values))
# print(aparat_comparisons)

# Porównanie pod względem CENA
# 1	1/3	1/9	1/7	1/5	1/3	1/9	1/9	1/7	1/5
# 1	1/9	1/7	1/7	1	1/7	1/9	1/7	1/5
# 1	3	3	9	3	1/3	3	5
# 1	1	5	1	1/5	1/3	3
# 1	7	1	1/5	1/3	3
# 1	1/7	1/9	1/7	1/5
# 1	1/5	1	3
# 1	3	5
# 1	3
# 1
cena_values = (1/3, 1/9, 1/7, 1/5, 1/3, 1/9, 1/9, 1/7, 1/5,
               1/9, 1/7, 1/7, 1, 1/7, 1/9, 1/7, 1/5,
               3, 3, 9, 3, 1/3, 3, 5,
               1, 5, 1, 1/5, 1/3, 3,
               7, 1, 1/5, 1/3, 3,
               1/7, 1/9, 1/7, 1/5,
               1/5, 1, 3,
               3, 5,
               3)

print(len(smartfony_pairs) == len(cena_values))

cena_comparisons = dict(zip(smartfony_pairs, cena_values))
# print(cena_comparisons)

# Porównanie AHP
print("Podsumowanie AHP")
ram = ahpy.Compare('ram', ram_comparisons, precision=3)
pamiec = ahpy.Compare('pamiec', pamiec_comparisons, precision=3)
aparat = ahpy.Compare('aparat', aparat_comparisons, precision=3)
cena = ahpy.Compare('cena', cena_comparisons, precision=3)

criteria.add_children([ram, pamiec, aparat, cena])

# Wagi lokalne kryteriów
print(criteria.target_weights)

# Podsumowanie
report = criteria.report(show=True, verbose=True)

# Wyniki:
# {'Infinix SMART 6 HD': 0.161, 'Samsung Galaxy S23 Ultra': 0.124, 'Motorola moto G22': 0.122, 'Xiaomi Redmi Note
# 11s': 0.122, 'Motorola edge 30 neo': 0.095, 'Motorola moto G82 5G': 0.083, 'Xiaomi 13': 0.083, 'OPPO Find N2 Flip':
# 0.082, 'Samsung Galaxy M33 5G': 0.078, 'Samsung Galaxy S20 FE 5G': 0.051}
