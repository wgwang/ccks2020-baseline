TIMENOW=`date +%y.%m.%d`

# -f 指定文件 ， -t 指定生成镜像名称 ， 冒号后为版本号 ， 各位大佬命名请不要冲突 例子 ： rec_action_pipe:17.08.01.1311
docker build -f Dockerfile -t dockerhub.datagrand.com/gfyuqing/doc_compare:${TIMENOW} .
