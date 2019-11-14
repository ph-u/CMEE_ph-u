import subprocess

p=subprocess.Popen(["echo","hi bash"], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
stdout, stderr=p.communicate()
stderr
stdout
print(stdout.decode())

p=subprocess.Popen(["ls","-l"], stdout=subprocess.PIPE)
stdout, stderr=p.communicate()
print(stdout.decode())

p=subprocess.Popen(["python3","../../Week2/Code/boilerplate.py"], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
stdout, stderr = p.communicate()
print(stdout.decode())

subprocess.os.path.join('directory','subdirectory','file')
