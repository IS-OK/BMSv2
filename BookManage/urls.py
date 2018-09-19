from django.conf.urls import url

from BookManage import views

urlpatterns = [
    url(r'login/$',views.login_view),
    url(r'register/$',views.register_view),
    url(r'index/?(\w=True)*$', views.index_view),
    url(r'person/$', views.person_view),
    url(r'borrow/$',views.borrow_view),
    url(r'allbook/?(\d+)$',views.showall_view),
    url(r'content/$',views.content_view),
    url(r'help/$',views.help_view),
    url(r'contact/$',views.contact_view),
]
