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

for i in range(256):
    # print(x_j)
    if i > 128:
        lamb = 0.6
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

x_ans /= 1
print(np.square(A @ x_ans[3:19] - b[3:19]).sum())
print(np.square(A @ x_gs[3:19] - b[3:19]).sum())
print(np.square(A @ x_j[3:19] - b[3:19]).sum())
# print(x_j)

x = np.array(
    [
        0,
        0,
        0,
        400.3109893799,
        1692.8279724121,
        2470.7897796631,
        578.5978851318,
        679.6752929688,
        1666.0978546143,
        -16.1641235352,
        761.3870697021,
        -103.5678863525,
        984.4603271484,
        1019.9316101074,
        -322.1333618164,
        -511.2349853516,
        1664.2899627686,
        2238.9533538818,
        0.0001373291,
        0,
        0,
        0,
    ]
)

x_j[3:19] = (
    (
        b
        + 13 * (np.roll(x, -1) + np.roll(x, 1))
        - 6 * (np.roll(x, -2) + np.roll(x, 2))
        + (np.roll(x, -3) + np.roll(x, 3))
    )
    / 20
)[3:19]

print(x_j - x)

# print(A @ x - b[3:19])
