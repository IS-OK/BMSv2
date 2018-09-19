# -*- coding: utf-8 -*-
from __future__ import unicode_literals

import datetime
import os
import time

import chardet
from django.core.paginator import Paginator
from django.http import HttpResponseRedirect, HttpResponse
from django.shortcuts import render
from .models import  *
# Create your views here.

import sys
reload(sys)
sys.setdefaultencoding('utf8')













# 登录功能
def login_view(request):
    if request.method == 'GET':
        login = request.GET.get('login','')
        if login=='':
            return render(request,'login.html')
        else:
            response=HttpResponse()
            response.delete_cookie('login',path='/')
            return render(request, 'login.html')

# 注册功能
def register_view(request):
    if request.method == 'GET':
        return render(request,'register.html')
    else:
        #接收数据
        uname = request.POST.get('username','')
        upwd=request.POST.get('password','')
        print uname,upwd
        if not insertUser(uname,upwd):
            return HttpResponseRedirect('/login/')
        else:
            return HttpResponse('注册失败')

# 展示主页并判断登录状态
def index_view(request,login):
    if request.method=='GET':
        if request.COOKIES.has_key('login'):
            uname = request.COOKIES['login']
            users = User.objects.all().count()
            types=BookType.objects.all().count()
            book=Book.objects.all().count()
            # 获得当前登录用户的对象实例
            user = User.objects.get(uname=uname)
            # 查询当前用户的借书记录
            borrow = Userborrow.objects.filter(uname_id=user).all().order_by('-created')[:5]
            books=Book.objects.all()
            print user,borrow
            return render(request, 'index.html',{'uname':uname,'users':users,'book':book,'types':types,'borrow':borrow,'books':books})
        return HttpResponseRedirect('/login/')
    elif request.method == 'POST':
        uname=request.POST.get('username','')
        upwd=request.POST.get('password','')
        print uname,upwd
        count = User.objects.filter(uname=uname, upwd=upwd).count()
        if count == 1:
            response=HttpResponseRedirect('/index/?login=True')
            response.set_cookie('login',uname,max_age=24*600,path='/')
            response.content=uname
            if login == True:
                print login
                return render(request,'index.html')
            return response
        else:
            # response=HttpResponseRedirect()
            # response.content='<script>window.alert("登录失败")</script>'
            # response.url('/login/')
            return HttpResponseRedirect('/login/')

# 借阅页面
def borrow_view(request):
    if request.method == 'GET':
        # 接受bookid
        bids=list()
        bid = request.GET.get('bid','')
        did = request.GET.get('del','')
        print bid,did
        if bid == '' and did == '' and request.COOKIES.has_key('login'):
            uname = request.COOKIES['login']
            user=User.objects.get(uname=uname)
            books=Userborrow.objects.all()
            # print books
            return render(request, 'borrow.html',{'uname':uname,'user':user})
        elif request.COOKIES.has_key('login') and did != ''and bid == '':
            uname = request.COOKIES['login']
            user = User.objects.get(uname=uname)
            print u'用户ID%s,图书ID%s'%(user.uid,did)
            delUserborrow(user,did)
            return render(request, 'borrow.html')
        elif request.COOKIES.has_key('login') and bid != '' and did== '':
            bids.append(bid)
            uname = request.COOKIES['login']
            user = User.objects.get(uname=uname)
            insertborrow(user.uid,bids)
            return render(request, 'borrow.html')
        else:
            return HttpResponseRedirect('/login/')

    elif request.method == 'POST':
        if request.COOKIES.has_key('login'):
            search_book = request.POST.get('search', '')
            # print search_book
            books = Book.objects.filter(bname__icontains=search_book)
            uname = request.COOKIES['login']
            user = User.objects.get(uname=uname)
            ubooks=Userborrow.objects.filter(uname_id=user.uid)
            # print ubooks
            return render(request, 'borrow.html', {'uname':uname,'books': books,'ubooks':ubooks,'user':user})
        else:
            return HttpResponseRedirect('/login/')



# 个人信息页面
def person_view(request):
    if request.method=='GET':
        did=request.GET.get('del','')
        if request.COOKIES.has_key('login') and did=='':
            uname = request.COOKIES['login']
            user = User.objects.get(uname=uname)
            borrow = Userborrow.objects.filter(uname_id=user,borrow=False).all().order_by('-created')
            return render(request, 'person.html',{'uname':uname,'user':user,'borrow':borrow})
        elif request.COOKIES.has_key('login') and did!='':
            uname = request.COOKIES['login']
            user = User.objects.get(uname=uname)
            delUserborrow(user,did)
            borrow = Userborrow.objects.filter(uname_id=user, borrow=False).all().order_by('-created')
            return render(request, 'person.html', {'uname': uname, 'user': user, 'borrow': borrow})
        else:
            return HttpResponseRedirect('/login/')


# 全部书籍页面
def showall_view(request,num=1):
    if request.method == 'GET':
        if request.COOKIES.has_key('login'):
            uname = request.COOKIES['login']
            size=4
            books = page(num,size)
            return render(request,'Allbook.html',{'uname':uname,'books':books})
        else:
            return HttpResponseRedirect('/login/')
    else:
        if request.COOKIES.has_key('login'):
            uname = request.COOKIES['login']
            user = User.objects.get(uname=uname)
            boxs=request.POST.getlist('check_boxs','')
            size = 4
            books = page(num, size)
            print boxs
            insertborrow(user.uid,boxs)
            return render(request, 'Allbook.html', {'uname': uname, 'books': books})
        else:
            return HttpResponseRedirect('/login/')


# 在线预览功能
def content_view(request):
    if request.method == 'GET':
        bid=request.GET.get('bid','')

        if request.COOKIES.has_key('login') and bid!='':
            uname = request.COOKIES['login']
            book = Book.objects.get(bid=bid)
            file = book.bcontent.name
            with open('media/'+file,'r') as f:
                content=f.read()
            return render(request,'content.html',{'uname':uname,'book':book,'content':content.decode('gb2312','ignore').encode('utf-8','ignore')})
        elif request.COOKIES.has_key('login') and bid =='':
            uname = request.COOKIES['login']
            book = Book.objects.first()
            file = book.bcontent.name
            with open('media/'+file,'r') as f:
                content=f.read()
            print content
            return render(request, 'content.html', {'uname': uname,'book':book,'content': content.decode('gb2312','ignore').encode('utf-8','ignore')})
        else:
            return HttpResponseRedirect('/login/')








# 全部书籍分页功能
def page(num,size):
    paginator=Paginator(Book.objects.all(),size)
    return paginator.page(int(num))

# 注册用户功能
def insertUser(uname,upwd):
    try:
        user = User.objects.get(uname=uname)
        return False
    except User.DoesNotExist:

        user = User.objects.create(uname=uname,upwd=upwd)
        return True


# 借阅书籍功能
def insertborrow(uid,bids):

    user = User.objects.get(uid=uid)
    for bid in bids:
        print bid
        book = Book.objects.get(bid=bid)
        borrrow_obj = Userborrow.objects.create(uname=user, bname=book)


def borrowdata(user,book):
    try:
        Userborrow.objects.get(uname=user,bname=book)
        return True
    except Userborrow.DoesNotExist:
        Userborrow.objects.create(uname=user,bname=book)
        return False

# 归还图书功能
def delUserborrow(user,bid):
    book=Book.objects.get(bid=bid)
    userborrow=Userborrow.objects.filter(uname=user,bname_id=book.bid).update(borrow=True)










# 留言页面
def help_view(request):

    if request.method=='GET':

        if request.COOKIES.has_key('login') :
            uname=request.COOKIES['login']

            filepath = os.getcwd() + '\\' + 'media' + '\\' + 'host.txt'
            with open(filepath,'r') as file:
                data= file.read()

            return render(request,'help.html',{'uname':uname,'data':data.decode('utf-8','ignore').encode('utf-8', 'ignore')})
        else:
            return HttpResponseRedirect('/login/')
    else:
        re=str(request.POST.get('re',''))
        print re
        uname = request.COOKIES['login']
        print uname,type(uname),re,type(re)
        data = insertdata(uname,re)

        print data
        return render(request, 'help.html', {'uname':uname,'data': data.decode('utf-8','ignore').encode('utf-8','ignore')})



def insertdata(uname,re):
    data = '%s:%s'%(uname,re)
    filepath = os.getcwd() + '\\' + 'media' + '\\' + 'host.txt'
    with open(filepath,'a')as file1:
        file1.write('\n')
        file1.write(datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')+' ')
        file1.write(data.encode('UTF-8'))
        file1.write('\n')
    with open(filepath,'r') as file2:
         data=file2.read()
    return data.decode('UTF-8')


# 关于页面
def contact_view(request):
    if request.method=='GET':
        if request.COOKIES.has_key('login') :
            uname=request.COOKIES['login']
            return render(request,'contact.html',{'uname':uname})
        else:
            return HttpResponseRedirect('/login/')