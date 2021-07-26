#!/bin/bash

SCRIPTDIR=$PWD

gcc fuse.c marfs.c change_user.c logging.c -o fuse -D_FILE_OFFSET_BITS=64 -I/usr/include/fuse -lfuse

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root"
   exit 1
fi

cd /tmp/marfs
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi
echo "preparing test environment"

echo "rm -rf *"
rm -rf *
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "mkdir mntdir"
mkdir mntdir
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "chmod 777 mntdir"
chmod 777 mntdir
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "chown root:root mntdir"
chown root:root mntdir
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "mkdir srcdir"
mkdir srcdir
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "chmod 777 srcdir"
chmod 777 srcdir
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "chown root:root srcdir"
chown root:root srcdir
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

while (( "$#" )); do
  if [[ $1 -eq "-f" ]]
  then
    $SCRIPTDIR/fuse -f -o allow_other /tmp/marfs/mntdir
    exit 0
  fi
  shift
done

echo "launching fuse"
$SCRIPTDIR/fuse -o allow_other /tmp/marfs/mntdir
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "cd mntdir"
cd mntdir
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "echo \"hello world\" > hello"
echo "hello world" > hello
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "chmod 777 hello"
chmod 777 hello
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "chown root:root hello"
chown root:root hello
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "mkdir dandir"
mkdir dandir
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "chmod 770 dandir"
chmod 770 dandir
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "chown dan:dan dandir"
chown dan:dan dandir
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "echo \"this is dan's file\" > danfile"
echo "this is dan's file" > danfile
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "chmod 770 danfile"
chmod 770 danfile
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "chown dan:dan danfile"
chown dan:dan danfile
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "mkdir guineadir"
mkdir guineadir
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "chmod 770 guineadir"
chmod 770 guineadir
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "chown guinea:guinea guineadir"
chown guinea:guinea guineadir
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "echo \"this is guinea's file\" > guineafile"
echo "this is guinea's file" > guineafile
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "chmod 770 guineafile"
chmod 770 guineafile
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "chown guinea:guinea guineafile"
chown guinea:guinea guineafile
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "cat hello"
cat hello
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "cat danfile"
cat danfile
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "cat guineafile"
cat guineafile
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "cd dandir"
cd dandir
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "ls"
ls
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "cd ../guineadir"
cd ../guineadir
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "ls"
ls
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "cd .."
cd ..
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "echo \"this is only a test\" >> testfile"
echo "this is only a test" >> testfile
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "rename testfile testfile1 testfile"
rename testfile testfile1 testfile
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "unlink testfile1"
unlink testfile1
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "mkdir testdir"
mkdir testdir
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "rmdir testdir"
rmdir testdir
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "ln hello link"
ln hello link
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "cat link"
cat link
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "unlink link"
unlink link
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "ln -s hello link"
ln -s hello link
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "readlink link"
readlink link
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "cat link"
cat link
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "unlink link"
unlink link
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "ls -lR"
ls -lR
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "cd .."
cd ..
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "
changing user to dan"
su dan << EOF
echo "cd mntdir"
cd mntdir
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "ls -lR"
ls -lR
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "cat hello"
cat hello
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "cat danfile"
cat danfile
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "cat guineafile"

if cat guineafile
then
  echo "failed"
  exit -1
fi

echo "cd dandir"
cd dandir
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "ls"
ls
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "cd ../guineadir"
cd ../guineadir
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "ls"
if ls
then
  echo "failed"
  exit -1
fi

echo "cd .."
cd ..
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "echo \"this is only a test\" >> testfile"
echo "this is only a test" >> testfile
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "rename testfile testfile1 testfile"
rename testfile testfile1 testfile
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "unlink testfile1"
unlink testfile1
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "mkdir testdir"
mkdir testdir
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "rmdir testdir"
rmdir testdir
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "ln hello link"
ln hello link
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "cat link"
cat link
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "unlink link"
unlink link
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "ln -s hello link"
ln -s hello link
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "readlink link"
readlink link
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "cat link"
cat link
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "unlink link"
unlink link
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "ls -lR"
ls -lR
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "cd .."
cd ..
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi
EOF

echo "
changing user to guinea"
su guinea << EOF
echo "cd mntdir"
cd mntdir
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "ls -lR"
ls -lR
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "cat hello"
cat hello
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "cat danfile"
cat danfile
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "cat guineafile"
cat guineafile
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "cd dandir"
cd dandir
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "ls"
ls
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "cd ../guineadir"
cd ../guineadir
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "ls"
ls
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "cd .."
cd ..
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "echo \"this is only a test\" >> testfile"
echo "this is only a test" >> testfile
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "rename testfile testfile1 testfile"
rename testfile testfile1 testfile
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "unlink testfile1"
unlink testfile1
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "mkdir testdir"
mkdir testdir
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "rmdir testdir"
rmdir testdir
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "ln hello link"
ln hello link
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "cat link"
cat link
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "unlink link"
unlink link
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "ln -s hello link"
ln -s hello link
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "readlink link"
readlink link
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "cat link"
cat link
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "unlink link"
unlink link
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "ls -lR"
ls -lR
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi

echo "cd .."
cd ..
if [[ $? -ne 0 ]]
then
  echo "failed"
  exit -1
fi
EOF
exit -1
umount -l /tmp/marfs/mntdir

rm -rf /tmp/marfs/*
