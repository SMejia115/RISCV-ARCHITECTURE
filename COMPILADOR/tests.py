binary = open('bin.txt', 'r')

test = open('test.txt', 'r')

num = 1
while True:
    line = binary.readline()
    line2 = test.readline()
    if not line:
        break
    if line != line2:
        print(f'Error line {num}')
        print(line)
        print(line2)
        break
      
    num += 1