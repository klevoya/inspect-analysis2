
def string_from_long(action):
    charmap = ['.','1','2','3','4','5','a','b','c','d','e','f','g','h','i',
                'j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']
    str = [None] * 13
    tmp = int(float(action))
    for i in range(13):
        c = charmap[int(tmp & (0x0f if i == 0 else 0x1f))]
        str[12-i] = c
        tmp >>= (4 if i == 0 else 5)
    out_str = ''.join(str)
    return out_str.split('.', 1)[0]


def string_to_long(name):
    n = 0
    i = 0
    while i < len(name) and i < 12:
        tmp = char2symbol(name[i])
        n |= (tmp & 0x1f) << (64 - 5 * (i + 1))
        i += 1

    if i == 12:
        n |= char2symbol(name[12]) & 0x0F

    return n

def char2symbol(c):
    if c >= 'a' and c <= 'z':
        return (c - 'a') + 6;
    if c >= '1' and c <= '5':
        return (c - '1') + 1;
    return 0




