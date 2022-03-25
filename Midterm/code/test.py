import numpy as np
# from pprint import pprint

# a = [-1, 6, -13, 20, -13, 6, -1]

# A_tmp = np.zeros((16, 22))

# for i in range(16):
#     A_tmp[i, i : i + 7] = a

# A = A_tmp[:, 3:-3]
# pprint(A)

b = np.zeros(22, dtype=np.float64)


def twos_complement(hexstr, bits):
    value = int(hexstr, 16)
    if value & (1 << (bits - 1)):
        value -= 1 << bits
    return value


with open("pattern1.dat") as f:
    for i, line in enumerate(f):
        b[i + 3] = twos_complement(line[:4], 16)
# pprint(b)

x_gs = b / 20
x_j = b / 20

for i in range(1000):
    # x_new = np.zeros(22)
    x_j[3:19] = (
        (
            b
            + 13 * (np.roll(x_j, -1) + np.roll(x_j, 1))
            - 6 * (np.roll(x_j, -2) + np.roll(x_j, 2))
            + (np.roll(x_j, -3) + np.roll(x_j, 3))
        )
        / 20
    )[3:19]

    for j in range(3, 19):
        x_gs[j] = (
            b[j]
            + 13 * (x_gs[j + 1] + x_gs[j - 1])
            - 6 * (x_gs[j + 2] + x_gs[j - 2])
            + (x_gs[j + 3] + x_gs[j - 3])
        ) / 20

print(x_j)
print(x_gs)
