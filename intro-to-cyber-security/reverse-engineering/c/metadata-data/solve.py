header = (b"CMag" + (1).to_bytes(1, "little") + (62).to_bytes(4, "little") + (23).to_bytes(4, "little"))

data = b"A" * (62 * 23)

with open("solve.cimg", "wb") as f:
    f.write(header + data)
