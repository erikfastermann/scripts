import os

for f in os.listdir():
    f_name, f_ext = (os.path.splitext(f))
    if f_ext == '' and not os.path.isfile('{}.part'.format(f_name)) and not os.path.isdir(f_name):
        f_new = '{}.mp4'.format(f_name)
        os.rename(f, f_new)
