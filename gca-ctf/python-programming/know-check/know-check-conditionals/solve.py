x = int(input("Num 1: "))
operation  = input("operation: ")
y = int(input("Num 2: "))

if operation == "/":
    print(x/y)

elif operation == "*":
    print(x*y)

elif operation == "+":
    print(x+y)

elif operation == "-":
    print(x-y)

else:
    print(f"{operation} operation unknown.")
