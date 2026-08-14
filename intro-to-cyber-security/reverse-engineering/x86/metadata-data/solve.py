header = (b"CN~R" + (1).to_bytes(1, "little") + (61).to_bytes(4, "little") + (15).to_bytes(8, "little"))

data = b"A" * 0x393

with open("solve.cimg", "wb") as f:
    f.write(header + data)
