通过下面的命令进行构建docker容器（注：xxx、yyy修改成自己的GitHub用户名和GitHub邮箱，Github_Branch_Name为Github Pages设置的分支名称）

```bash
docker build https://github.com/wenchengji159357/Hexo-blog-docker.git --file Dockerfile --build-arg Github_User="xxx" --build-arg Github_Email="yyy" --build-arg Github_Branch_Name="main" --tag hexo-blog-image
```