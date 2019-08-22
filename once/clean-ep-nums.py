import os

path = os.getcwd()
content = os.listdir(path)
last = 0


for f in content:
	name, ext = os.path.splitext(f)
	ep_num = name.split('x', 1)[1]
	ep_num = int(ep_num.split(' -', 1)[0])
	if ep_num != last + 1:
		ep_num = last + 1
	last += 1
	season = name.split('x', 1)[0]
	name = name.split(' - ', 1)[1]
	new = f'{season}x{ep_num:02} - {name}{ext}'
	os.rename(os.path.join(path, f), os.path.join(path, new))
