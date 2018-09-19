# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models

# Create your models here.

# 书籍类型
class BookType(models.Model):
    # 书籍类型名称
    tname=models.CharField(max_length=20,unique=True,verbose_name='类型')

    def __unicode__(self):
        return u'%s'%self.tname

    class Meta:
        db_table='t_booktype'
        verbose_name_plural='书籍类型'

# 书籍信息
class Book(models.Model):
    # 书籍编号
    bid=models.PositiveIntegerField(primary_key=True,unique=True,verbose_name='书籍编号')
    # 书籍名称
    bname=models.CharField(max_length=30,verbose_name='图书名称')
    # 书籍图片
    bimage=models.ImageField(upload_to='images/',verbose_name='封面图片')
    # 作者
    buser=models.CharField(max_length=20,verbose_name='作者')
    # 书籍类型
    btype=models.ForeignKey(BookType,on_delete=models.CASCADE,verbose_name='书籍类型')
    # 存放路径
    bcontent=models.FileField(upload_to='txts/',verbose_name='书籍内容')

    def __unicode__(self):
        return u'%s'%self.bname

    class Meta:
        db_table='t_book'
        verbose_name_plural='书籍信息'





# 用户
class User(models.Model):

    # 用户id
    uid=models.AutoField(primary_key=True,verbose_name='编号')
    # 用户名称
    uname=models.CharField(max_length=30,verbose_name='用户')
    # 用户密码
    upwd=models.CharField(max_length=20,verbose_name='密码')
    # 注册时间
    created=models.DateField(auto_now_add=True,verbose_name='注册时间')

    def __unicode__(self):
        return u'%s'%self.uname

    class Meta:
        db_table='t_user'
        verbose_name_plural='用户信息'




# 用户借书记录表
class Userborrow(models.Model):
    # 借书用户名
    uname=models.ForeignKey(User,on_delete=models.CASCADE,verbose_name='用户id')
    # 所借书籍
    bname=models.ForeignKey(Book,verbose_name='书籍名称')
    # 借书时间
    created=models.DateTimeField(auto_now_add=True,verbose_name='借书时间')
    #是否归还状态
    borrow=models.BooleanField(default=False,verbose_name='是否归还')

    def __unicode__(self):
        return u'%s,%s,%s'%(self.uname,self.created,self.borrow)

    class Meta:
        db_table='t_userborrow'
        verbose_name_plural=u'用户借书记录'
