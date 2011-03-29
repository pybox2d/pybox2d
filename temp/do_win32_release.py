import os

platform='win32'

versions=['2.5', '2.6', '2.7', '3.0', '3.1', '3.2']
interpreters=[r'c:\python%s\python.exe' % version.replace('.', '') for version in versions]
lib_paths=[r'build\lib.%s-%s' % (platform, version) for version in versions]

print '@echo off'
print 'echo ---Start--- > test_results.txt'
print 'echo ---Start--- > build_results.txt'
#print '\n'.join(interpreters)
do_stuff='''
echo * %(version)s
echo -------- %(version)s -------- >> build_results.txt
echo -------- %(version)s -------- >> test_results.txt
%(interpreter)s setup.py clean -a >> build_results.txt 2>&1
%(interpreter)s setup.py build --force >> build_results.txt 2>&1

type Box2D\pybox2d_license_header.txt > Box2D_.py
type %(lib_path)s\Box2D\Box2D.py >> Box2D_.py
move /y Box2D_.py %(lib_path)s\Box2D\Box2D.py
%(interpreter)s setup.py develop >> build_results.txt 2>&1
%(interpreter)s setup.py test >> test_results.txt 2>&1
%(interpreter)s setup.py bdist_wininst -t"pybox2d" -dinstaller >> build_results.txt 2>&1
'''

distutils_cfg='''[build]
compiler=mingw32'''

for version, interpreter, lib_path in zip(versions, interpreters, lib_paths):
    python_path=os.path.split(interpreter)[0]
    if version < '2.6':
        cfg_file=r'%s\lib\distutils\distutils.cfg' % python_path
        open(cfg_file, 'w').write(distutils_cfg)
    print do_stuff % locals()
