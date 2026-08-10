x = int(input("Enter A Number: "))
hailstone_number = 1
while x != 1:

    hailstone_number+=1
    if x % 2 == 0:
        x = x / 2

    else:
        x = 3 * x + 1

print(hailstone_number)
