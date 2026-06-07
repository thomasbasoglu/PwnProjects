balance = int(input("Balance: "))
withdraw = int(input("Withdraw: "))

if withdraw < 0:
    print("Error: Withdraw Amount Must Be Positive")

elif withdraw > balance:
    print("Error: Insufficient funds")

elif withdraw % 20 != 0:
    print("Error: Withdraw Amount Must Be a Multiple of 20")

else:
    print(f"New Balance: {balance-withdraw}")
