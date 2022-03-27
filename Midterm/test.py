import numpy as np

a = [-1, 6, -13, 20, -13, 6, -1]

A_tmp = np.zeros((16, 22))

for i in range(16):
    A_tmp[i, i : i + 7] = a

A = A_tmp[:, 3:-3]

b = np.zeros(22, dtype=np.float64)


def twos_complement(hexstr, bits):
    value = int(hexstr, 16)
    if value & (1 << (bits - 1)):
        value -= 1 << bits
    return value


with open("./code/pattern1.dat") as f:
    for i, line in enumerate(f):
        b[i + 3] = twos_complement(line[:4], 16)
# pprint(b)

x_gs = b / 20
tmp = [0, 0, 0] + list(range(400, 6500, 400)) + [0, 0, 0]
x_j = np.array(tmp, dtype=np.float64)
x_j = np.zeros(22, dtype=np.float64)
x_ans = b / 20
lamb = 0.5

for i in range(3000):
    # print(x_j)
    x_j[3:19] = (
        (
            b
            + 13 * (np.roll(x_j, -1) + np.roll(x_j, 1))
            - 6 * (np.roll(x_j, -2) + np.roll(x_j, 2))
            + (np.roll(x_j, -3) + np.roll(x_j, 3))
        )
        / 20
    )[3:19] * lamb + x_j[3:19] * (1 - lamb)

    for j in range(3, 19):
        x_gs[j] = (
            b[j]
            + 13 * (x_gs[j + 1] + x_gs[j - 1])
            - 6 * (x_gs[j + 2] + x_gs[j - 2])
            + (x_gs[j + 3] + x_gs[j - 3])
        ) / 20

for i in range(3000):
    for j in range(3, 19):
        x_ans[j] = (
            b[j]
            + 13 * (x_ans[j + 1] + x_ans[j - 1])
            - 6 * (x_ans[j + 2] + x_ans[j - 2])
            + (x_ans[j + 3] + x_ans[j - 3])
        ) / 20

print(np.square(A @ x_ans[3:19] - b[3:19]).sum())
print(np.square(A @ x_gs[3:19] - b[3:19]).sum())
print(np.square(A @ x_j[3:19] - b[3:19]).sum())
print(x_j)

x = np.array(
    [
        400.7906036377,
        1686.0266418457,
        2453.5168762207,
        570.5681304932,
        719.9454803467,
        1749.0246887207,
        -10.1293487549,
        531.5038757324,
        -465.1992187500,
        1104.4526367188,
        2215.2684631348,
        1278.3922576904,
        -744.3394470215,
        -125.3479614258,
        1309.5965118408,
        -723.6249542236,
    ]
)

print(A @ x - b[3:19])
