s = 0
if int(input("Q1: ")) == 2: s += 1
if int(input("Q2: ")) == 4: s += 1
if int(input("Q3: ")) == 6: s += 1
if int(input("Q4: ")) == 8: s += 1
if int(input("Q5: ")) == 10: s += 1
g = float((s / 5) * 100)
print("Grade: {}%".format(g))