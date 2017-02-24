HOST=192.168.2.47
USER=root
PASS=123456
REMOTE_PATH=/var/mobile/Documents
TARGET_NAME=hello

ISDKP=$(xcrun --sdk iphoneos --show-sdk-path)
ICC=$(xcrun --sdk iphoneos --find clang)
ISDKF="-arch arm64 -isysroot $ISDKP"

$ICC ./main.c $ISDKF -o ./$TARGET_NAME
ldid -S ./$TARGET_NAME
sshpass -p $PASS scp ./$TARGET_NAME $USER@$HOST:$REMOTE_PATH/
sshpass -p $PASS ssh $USER@$HOST "chmod +x $REMOTE_PATH/$TARGET_NAME && $REMOTE_PATH/$TARGET_NAME"