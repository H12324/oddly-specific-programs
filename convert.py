import sys
from PIL import Image

if len(sys.argv) != 3:
    print('To use this, enter as follows into command line -> convert.py enter_image.format name_of_array')
    sys.exit(1)

im = Image.open(sys.argv[1]) 
#probably should have used width and height but c'est la vie
x_size, y_size = im.size




def checkArray(array, num):
    for i in range(len(array)):
        if array[i] == num:
            return i
    array.append(num)
    return len(array) - 1

with open(sys.argv[2], 'w') as f:
    f.write("int " + sys.argv[2] + "["+str(y_size) +"]" + "["+str(x_size) +"]" +" = {\n")

    array = []
    array.append(0)
    rgb_im = im.convert('L')            #Can change to RGBA or RGB depending on use case
    for y in range(y_size):
        f.write('   {')
        for x in range(x_size):
            colour = rgb_im.getpixel((x, y))
            #val = checkArray(array, colour) #replace with colour if you want the actual rgb value in array
            val = colour
            if (x != x_size - 1):
                f.write(str(val) + ",")
                
            else:
                f.write(str(val))
                if (y == y_size - 1 ):
                    f.write("}")
                else:
                    f.write("},")
        f.write("\n")


    f.write('};\n')

print("Done")

