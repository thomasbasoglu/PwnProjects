header = (b"CNmG" + (1).to_bytes(2, "little") + (66).to_bytes(2, "little") + (17).to_bytes(2, "little"))

data = b"A" * (66 * 17)

with open("solve.cimg", "wb") as f:
    f.write(header + data)
