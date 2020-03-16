---
layout: post
title: "Ionic2 使用iconfont图标"
category: tech
date: 2018-03-15 14:04:21 +0800
---
在ionic2中使用自定义图标，如iconfont（阿里巴巴矢量图标）。

先在http://www.iconfont.cn/ 中找到自己需要的图标，然后将图标加入购物车，然后下载该图标。

![~](/assets/fb1b1f46-016d-49af-ae0b-ec115663f6a5.png)

下载完成后解压，打开文件demo_unicode.html可以看到它提供的使用方法，我们在ionic2中按照以下方法使用：

1、在项目的assets目录下新建fonts文件夹，然后将下载解压后的iconfont.woff、iconfont.ttf、iconfont.svg、iconfont.eot添加到fonts文件夹中。

![~](/assets/48e67922-8e7f-47a9-bc40-d31ca4af5b2d.png)

2、将font-face和自定义样式写入app.scss

```css
@font-face {
    font-family: 'iconfont';
    src: url('../assets/fonts/iconfont.eot');
    src: url('../assets/fonts/iconfont.eot?#iefix') format('embedded-opentype'),
    url('../assets/fonts/iconfont.woff') format('woff'),
    url('../assets/fonts/iconfont.ttf') format('truetype'),
    url('../assets/fonts/iconfont.svg#iconfont') format('svg');
}

.iconfont {
    font-family: "iconfont" !important;
    font-size: 16px;
    font-style: normal;
    -webkit-font-smoothing: antialiased;
    -webkit-text-stroke-width: 0.2px;
    -moz-osx-font-smoothing: grayscale;
}

.ion-qq:before {
    content: '\e601'
}
```

3、在html页面使用图标

```html
<i class="iconfont ion-qq"></i>
```

还有一种方式是按原有方式使用图标，需要修改第二步中的修改为以下代码：

```css
@font-face {
    font-family: 'Ionicons';
    src: url('../assets/fonts/iconfont.eot');
    src: url('../assets/fonts/iconfont.eot?#iefix') format('embedded-opentype'),
    url('../assets/fonts/iconfont.woff') format('woff'),
    url('../assets/fonts/iconfont.ttf') format('truetype'),
    url('../assets/fonts/iconfont.svg#iconfont') format('svg');
}

.icon{
    font-family: "Ionicons" !important;
    font-size: 16px;
    font-style: normal;
    -webkit-font-smoothing: antialiased;
    -webkit-text-stroke-width: 0.2px;
    -moz-osx-font-smoothing: grayscale;
}

.ion-ios-qq:before {
    content: '\e601'
}

.ion-md-qq:before {
    content: '\e601'
}
```

然后就可以按照

```html
<ion-icon name="qq"></ion-icon> 
```

来使用。