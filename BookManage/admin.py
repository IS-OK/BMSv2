# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.contrib import admin

# Register your models here.
# Register your models here.
from .models import User,Book,BookType,Userborrow


class Bookfilter(admin.ModelAdmin):
    list_display = ('bid', 'bname', 'buser', 'btype',)

class Userfilter(admin.ModelAdmin):
# #     #显示表格列表字段
    list_display = ('uid','uname','upwd','created',)
# #     #排序字段
    ordering = ['created']
class UserBorrowfilter(admin.ModelAdmin):

    list_display = ('created','uname','bname','borrow',)


admin.site.register(BookType)
admin.site.register(Book,Bookfilter)
admin.site.register(User,Userfilter)
admin.site.register(Userborrow,UserBorrowfilter)
