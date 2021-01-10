通过本仓库可以实现一键构建GitHub Pages博客

需要根据自己的GitHub用户名和GitHub邮箱修改docker-compose.yml，然后执行docker-compose up命令

或者通过下面的命令进行构建（注：xxx、xxx.@gmail.com修改成自己的GitHub用户名和GitHub邮箱）

```bash
git clone https://github.com/wenchengji159357/Hexo-blog-docker.git
sed -ri "/Github_User/ s#^(.*)(: )(.*)#\1\2xxx#" docker-compose.yml
sed -ri "/Github_Email/ s#^(.*)(: )(.*)#\1\2xxx.@gmail.com#" docker-compose.yml
docker-compose up
```





