test_score = int(input("Average Test Score: "))
attendance = int(input("Attendance: "))

if test_score >= 85 and attendance >= 90:
        print("Student is a Honors Student")

elif test_score >= 70 and attendance >= 75:
        print("Student is a Passing Student")

else:
    print("Student is a Failing Student")
