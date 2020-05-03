---
layout: post
title: java改变图片尺寸
date: 2020-05-03 16-06-22
author: 七禾叶
tags: [java]
comments: true
toc: true
pinned: true
---

> 改了下blog的名字就想着连logo一起改了，就网上抄了代码。。抄是之前就抄了。。忘记记录出处了，见谅。。
>本文就是做个记录。。

#### 代码
```java
package study;

import java.awt.AlphaComposite;
import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import javax.imageio.ImageIO;

public class Main {

    private static final int IMG_WIDTH = 64;
    private static final int IMG_HEIGHT = 64;
    private static final String prefix = "/Users/guoying/Desktop/image1";
    private static final String prefix1 = "/Users/guoying/Desktop/image/";
    private static final String postFix = ".jpeg";

    public static void main(String[] args) {

        try {//要遍历的路径
            File file = new File(prefix);
            File[] fs = file.listFiles();
            for (File f : fs) {
                if (!f.isDirectory()) {
                    System.out.println(f.getName());
                    BufferedImage originalImage = ImageIO.read(f);
                    int type = originalImage.getType() == 0 ? BufferedImage.TYPE_INT_ARGB : originalImage.getType();

                    BufferedImage resizeImageJpg = resizeImage(originalImage, type);
                    ImageIO.write(resizeImageJpg, "jpg", new File(prefix1+f.getName()));
                }
            }

        } catch (IOException e) {
            System.out.println(e.getMessage());
        }

    }

    private static BufferedImage resizeImage(BufferedImage originalImage, int type) {
        BufferedImage resizedImage = new BufferedImage(IMG_WIDTH, IMG_HEIGHT, type);
        Graphics2D g = resizedImage.createGraphics();
        g.drawImage(originalImage, 0, 0, IMG_WIDTH, IMG_HEIGHT, null);
        g.dispose();

        return resizedImage;
    }
}
```
