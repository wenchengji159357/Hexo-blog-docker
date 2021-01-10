通过本仓库可以实现一键构建GitHub Pages博客

通过下面的命令进行构建（注：xxx、xxx.@gmail.com修改成自己的GitHub用户名和GitHub邮箱）

```bash
git clone https://github.com/wenchengji159357/Hexo-blog-docker.git
docker build . --file Dockerfile --build-arg Github_User="xxx" --build-arg Github_Email="xxx.@gmail.com" --tag hexo-blog-image
```





