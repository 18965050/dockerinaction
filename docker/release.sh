#判断docker宿主机是否添加了docker-harbor域名
docker-machine ssh default "cat /etc/hosts|grep docker.vemic.com"
if [ $? == 1 ];then
	docker-machine ssh default "sudo -- sh -c 'echo 192.168.28.63    docker.vemic.com>>/etc/hosts'"
fi

IO_HOME=m:/git/io-all
CK_PUCK_HOME=M:/git/ck-puck
CK_PUCK_FRONT_HOME=M:/git/ck-puck-front

DOCKER_HOME=${IO_HOME}/docs/deploy/docker
PROD_BASIC_HOME=${IO_HOME}/product/io-product-basic

## 编译IO-ALL
# 文件修改
sed -i 's/dubbo.registry.address=redis:\/\/192.168.27.240:6379/dubbo.registry.address=redis:\/\/redis-server:6379/g' ${PROD_BASIC_HOME}/src/main/resources/properties/application.development.properties
cd ${IO_HOME}
mvn clean install -Dmaven.test.skip=true
cp ${PROD_BASIC_HOME}/target/*.jar ${PROD_BASIC_HOME}/target/lib
if [ ! -d "${DOCKER_HOME}/io-all/target" ];then
	mkdir -p ${DOCKER_HOME}/io-all/target
fi
rm -rf ${DOCKER_HOME}/io-all/target/*
cp -rf ${PROD_BASIC_HOME}/target/lib ${DOCKER_HOME}/io-all/target

## 编译CK-PUCK
# 文件修改
sed -i 's/service:jmx:rmi:\/\/\/jndi\/rmi:\/\/localhost:9009\/jmxrmi/service:jmx:rmi:\/\/\/jndi\/rmi:\/\/ioall-server:9009\/jmxrmi/g' ${CK_PUCK_HOME}/src/main/webapp/WEB-INF/web.xml
sed -i 's/dubbo:\/\/localhost:20980/dubbo:\/\/ioall-server:20980/g' ${CK_PUCK_HOME}/src/test/resources/properties/dubbo-resolve.properties
cd ${CK_PUCK_HOME}
mvn clean package -Dmaven.test.skip=true
if [ ! -d "${DOCKER_HOME}/ck-puck/target" ];then
	mkdir -p ${DOCKER_HOME}/ck-puck/target
fi
rm -rf ${DOCKER_HOME}/ck-puck/target/*
cp -rf ${CK_PUCK_HOME}/target/*.war ${DOCKER_HOME}/ck-puck/target
cp -rf ${CK_PUCK_HOME}/src/test/resources/properties/dubbo-resolve.properties ${DOCKER_HOME}/ck-puck/target

## 编译CK-PUCK-FRONT
cd ${CK_PUCK_FRONT_HOME}
if [ -d "dist" ];then
	rm -rf dist
fi
npm install && npm run build
if [ ! -d "${DOCKER_HOME}/ck-puck-front/target" ];then
	mkdir -p ${DOCKER_HOME}/ck-puck-front/target
fi
rm -rf ${DOCKER_HOME}/ck-puck-front/target/*
cp -rf ${CK_PUCK_FRONT_HOME}/index.html ${DOCKER_HOME}/ck-puck-front/target
cp -rf ${CK_PUCK_FRONT_HOME}/dist ${DOCKER_HOME}/ck-puck-front/target



## DOCKER操作
cd ${DOCKER_HOME}
docker-compose up -d  

## 还原修改的文件
cd ${IO_HOME}
git checkout -f HEAD -- product/io-product-basic/src/main/resources/properties/application.development.properties
cd ${CK_PUCK_HOME}
git checkout -f HEAD -- src/main/webapp/WEB-INF/web.xml
git checkout -f HEAD -- src/test/resources/properties/dubbo-resolve.properties


