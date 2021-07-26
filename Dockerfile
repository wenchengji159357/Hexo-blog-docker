# 基础镜像
FROM icoty1/ubuntu-hexo-blog:latest

MAINTAINER jiwencheng <wenchengji159357@gmail.com>

ARG Github_User
ARG Github_Email
ARG Github_Branch_Name=master

ENV Hexo_Server_Port=4000

EXPOSE ${Hexo_Server_Port}

WORKDIR /${Github_User}.github.io

COPY ./build_hexo_blog.yml /root/build_hexo_blog.yml
COPY ./sources.list /root/sources.list

RUN \
# 更换源
mv /etc/apt/sources.list /etc/apt/sources.list.bak && \
cp /root/sources.list /etc/apt/sources.list && \
apt-get update && \
# 设置时区
ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
apt-get install -y tzdata && \
apt-get install -y vim && \
# hexo初始化
# npm config set registry https://registry.npm.taobao.org && \
# npm config set registry https://mirrors.huaweicloud.com/repository/npm/ && \
npm install -g hexo-cli && \
hexo init && \
npm install  && \
npm install hexo-server --save && \
# 一键部署到Github Pages
npm install hexo-deployer-git --save && \
# 安装fluid主题
npm install hexo-theme-fluid --save && \
npm install hexo-migrator-rss --save && \
npm install hexo-asset-image --save && \
npm install hexo-wordcount --save && \
npm install hexo-generator-sitemap --save && \
npm install hexo-generator-baidu-sitemap --save && \
npm install hexo-helper-live2d --save && \
# 升级 node 到最新稳定版本
n stable && \
# 创建SSH公私钥
rm -rf ~/.ssh/* && \
ssh-keygen -t rsa -f ~/.ssh/id_rsa -q -P "" -C ${Github_Email} && \
ssh-keyscan github.com > ~/.ssh/known_hosts 2 > /dev/null && \
# git基本配置
git config --global user.email ${Github_Email} && \
git config --global user.name ${Github_User} && \
# git config --global push.default matching && \
# git log中文显示
git config --global i18n.commitencoding utf-8 && \
git config --global i18n.logoutputencoding utf-8 && \
export LESSCHARSET=utf-8 && \
# git 代码编辑器 vim
git config --global core.editor vim && \
git init && \
git remote add origin git@github.com:${Github_User}/${Github_User}.github.io.git && \
# 修改hexo-deployer-git插件配置
sed -ri "/type/ s#^(.*)(: )(.*)#\1\2git#" _config.yml && \
echo "  repo: git@github.com:${Github_User}/${Github_User}.github.io.git" >> _config.yml && \
echo "  branch: ${Github_Branch_Name}" >> _config.yml && \
# 修改Hexo主题
sed -ri "/theme/ s#^(.*)(: )(.*)#\1\2fluid#" _config.yml && \
# 修改Hexo语言
sed -ri "/language/ s#^(.*)(: )(.*)#\1\2zh-CN#" _config.yml && \
# 修改Hexo作者
sed -ri "/author/ s#^(.*)(: )(.*)#\1\2${Github_User}#" _config.yml && \
# mkdir .github && \
mkdir .github/workflows/ && \
mv /root/build_hexo_blog.yml .github/workflows/build_hexo_blog.yml && \
sed -ri "/GIT_NAME/ s#^(.*)(: )(.*)#\1\2${Github_User}#" .github/workflows/build_hexo_blog.yml && \
sed -ri "/GIT_EMAIL/ s#^(.*)(: )(.*)#\1\2${Github_Email}#" .github/workflows/build_hexo_blog.yml && \
git add .github/workflows/build_hexo_blog.yml && \
# hexo_blog分支首次提交
git checkout -b hexo_blog && \
git add . && \
git commit -m "hexo_blog branch init" && \
# git push -u origin hexo_blog && \
# 博客页面初始化
# Generate static files
hexo generate
# Deploy to remote sites
# hexo deploy

CMD hexo server -d -p ${Hexo_Server_Port}
