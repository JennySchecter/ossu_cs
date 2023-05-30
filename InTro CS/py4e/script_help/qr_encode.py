import hashlib


def tenTo64String(term_no,seq,serial_no):
    """
    返回64进制字符串
    """
    step3 = term_no+seq
    step4 = hashlib.md5((serial_no+step3).encode(encoding='UTF-8')).hexdigest()[-5:].upper();
    base = ['A', 'a', 'B', 'b', 'C', 'c', 'D', 'd',
               'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l',
               'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't',
               'U', 'V', 'W', 'X', 'Y', 'Z', 'u', 'v', 'w', 'x', 'y', 'z', '1', '2', '3', '4',
               '0', '5', '6', '7', '8', '9', '-', '_'];
    result = "";
    quotient = int(step3)
    while (quotient > 0):
        mod = quotient % 64
        result = base[mod]+result
        quotient = quotient // 64
    return result+step4


print(tenTo64String("4420099865181", "000002", "dJX8Mc"))
