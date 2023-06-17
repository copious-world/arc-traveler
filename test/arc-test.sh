
NODE_NAME='here'
DIR='arc-ops'
echo $DIR

mkdir ./$DIR
pushd $DIR
#
#   keep all the backrefs together so that the deepest lists the path back to the root
#
#    upload_scripts,download_scripts,ops,post_ops
#
GRAPH_FLDS='name,depth,sibs,user,pass,addr,backrefs,upload_scripts,download_scripts,ops,op_dir,y_fingerprint,post_ops'
# for startup
GRAPH_STR=$(cat <<EOL
here,1,home otw copious popsong,richardalbertleddy,local pass base64 encoded,localhost,./arc-ops,1,none
home,2,g_sessions contacts endpoint-users otw-create,richard,pass base64 encoded,IP YOU BOX,./arc-ops,1,here
g_sessions,3,none,root,pass base64 encoded,192.168.1.71,/home/arc-ops,0,home here
contacts,3,none,root,pass base64 encoded,192.168.1.75,/home/arc-ops,0,home here
endpoint-users,3,none,root,pass base64 encoded,192.168.1.77,/home/arc-ops,0,home here
otw-create,3,none,root,pass base64 encoded,192.168.1.81,/home/arc-ops,0,home here
EOL
)


GRAPH_STR=$(echo "$GRAPH_STR" | base64)
OPS_STR=$(echo 'pwd\nls' | base64)                      # pwd ls for setup, just one 
UPLOADER="setup_uploader.sh"

PASS=$(echo 'your password' | base64)
USER='me'
IP='localhost'
OP_DIR=$DIR


bash ../../scripts/$UPLOADER $PASS $USER $IP $OP_DIR "1" "local"
#
popd
#
./${OP_DIR}/arc-traveler-setup.sh $NODE_NAME $DIR "$GRAPH_STR" "$OPS_STR" "$UPLOADER"

# rm ./arc-traveler-setup.sh
