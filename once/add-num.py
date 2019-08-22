import os

path = os.getcwd()
f_list = []
content = os.listdir(path)


for f in content:
	name, ext = os.path.splitext(f)
	name = int(name)
	name += 1
	f_list.append(tuple([f, name, ext]))
	
	
f_list = sorted(f_list, key=lambda x: x[1], reverse=True)


for f in f_list:
	old = os.path.join(path, f[0])
	new = os.path.join(path, (str(f[1]) + f[2]))
	os.rename(old, new)