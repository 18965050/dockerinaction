## 准备
1. 进入BIOS,修改`Intel Virtual Technology`配置项为`Enabled`
2. 安装 [Docker Toolbox](https://github.com/docker/toolbox/releases/download/v1.12.2/DockerToolbox-1.12.2.exe "Toolbox"), 并修改启动目标为`${GIT_HOME}\bin\bash.exe`启动
3. (可选) 为方便docker管理,可安装Eclipse的Docker插件. 此插件可方便的对docker的image, container进行管理
4. 本机(windows)hosts文件中添加配置:
	```
	192.168.28.63    docker.vemic.com		#此为公司docker harbor地址
	```

	并修改default docker VM配置文件config.json,添加`InsecureRegistry`配置项内容`"docker.vemic.com"`
	

## 运行
1. git下载最新的项目代码
2. 在hosts文件中配置`<docker虚拟机的IP>	 dd.xyz.cn`
3. 修改`release.sh`脚本中的`IO_HOME`,`CK_PUCK_HOME`,`CK_PUCK_FRONT_HOME`变量为本机对应的项目路径
2. 在Docker Toolbox中运行`release.sh`进行各项目的编译, 打包, 并启动docker container运行 
3. 浏览器访问`http://dd.xyz.cn`

**注: 如果docker-redis或docker-ck-puck启动不了, 注销对应Dockfile中的USER指令**