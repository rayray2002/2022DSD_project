import sys


def twos_complement(hexstr, bits=16):
    value = int(hexstr, 16)
    if value & (1 << (bits - 1)):
        value -= 1 << bits
    return value


print(twos_complement(sys.argv[1], 33) / 2**17)
