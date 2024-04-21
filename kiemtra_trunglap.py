def kiemtra_trunglap(mang):
    if len(mang) < 2:
        return False
    
    luu = set()
    for num in mang:
        if num in luu:
            return True
        luu.add(num)
    return False

A = [1, 2, 3, 1, 4]
print(kiemtra_trunglap(A))

B = [1, 2, 3, 4]
print(kiemtra_trunglap(B))

C = [1]
print(kiemtra_trunglap(C))
