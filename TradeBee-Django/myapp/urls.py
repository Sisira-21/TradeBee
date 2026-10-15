"""TradeBee URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path

from myapp import views

urlpatterns = [
    # path('admin/', admin.site.urls),
    path('login_get/',views.login_get),
    path('',views.login_post),
    path('logout1/',views.logout1),
    path('adminhome_get/',views.adminhome_get),
    path('adminview_user/',views.adminview_user),
    path('adminblocked_user/',views.adminblocked_user),
    path('block_user/<id>',views.block_user),
    path('unblock_users/<id>',views.unblock_users),

    path('adminadd_content_get/',views.adminadd_content_get),
    path('adminadd_content_post/',views.adminadd_content_post),
    path('adminview_content/',views.adminview_content),
    path('search_content/',views.search_content),

    path("edit_content_get/<id>",views.edit_content_get),
    path("edit_content_post/",views.edit_content_post),
    path("delete_content/<id>",views.delete_content),

    path('adminadd_video_get/',views.adminadd_video_get),
    path('adminadd_video_post/',views.adminadd_video_post),
    path('adminview_video/',views.adminview_video),
    path('search_video/',views.search_video),
    path("adminedit_video_get/<id>",views.adminedit_video_get),
    path("adminedit_video_post/",views.adminedit_video_post),
    path("admindelete_video/<id>",views.admindelete_video),

    path("adminnews_add_get/",views.adminnews_add_get),
    path("adminews_add_post/",views.adminews_add_post),
    path("adminview_news/",views.adminview_news),
    path("search_news/",views.search_news),
    path("adminedit_news_get/<id>",views.adminedit_news_get),
    path("adminedit_news_post/",views.adminedit_news_post),
    path("admindelete_news/<id>",views.admindelete_news),

    path("asend_notification_get/",views.asend_notification_get),
    path("asend_notification_post/",views.asend_notification_post),
    path("asendview_notification/",views.asendview_notification),
    path("search_noti/",views.search_noti),
    path("adminedit_noti_get/<id>",views.adminedit_noti_get),
    path("adminedit_noti_post/",views.adminedit_noti_post),
    path("admindelete_noti/<id>",views.admindelete_noti),

    path("admin_feedback/",views.admin_feedback),
    path("search_feedback/",views.search_feedback),
    path("admin_complaint/",views.admin_complaint),
    path("search_comp/",views.search_comp),
    path("reply_get/<id>",views.reply_get),
    path("reply_post/",views.reply_post),
    path("achangepassword/",views.achangepassword),
    path("changep_post/",views.changep_post),


    ################

    path("user_login_post/", views.user_login_post),
    path("user_changep_post/", views.user_changep_post),
    path("user_viewprofile/", views.user_viewprofile),
    path("user_viewsignup/", views.user_viewsignup),
    path("user_viewnoti/", views.user_viewnoti),
    path("user_viewvideo/", views.user_viewvideo),
    path("user_viewcontent/", views.user_viewcontent),
    path("user_viewreply/", views.user_viewreply),
    path("user_viewnews/", views.user_viewnews),
    path("user_editprofile/", views.user_editprofile),
    path("user_sendcomplanit/", views.user_sendcomplanit),
    path("user_sendreview/", views.user_sendreview),
    path("getallstock/", views.getallstock),
    path("stock_detail/", views.stock_detail),
    path("add_fav/", views.add_fav),
    path("view_favstock/", views.view_favstock),
    path("view_price/", views.view_price),
    path("priceprediction/", views.priceprediction),
    path("buy/", views.buy),
    path("user_viewbuy/", views.user_viewbuy),
    path("viewNotification/", views.viewNotification),
    path("report/", views.report),
    path("sell/", views.sell),
    path("viewselled_stock/", views.viewselled_stock),
    path("android_forget_password_post/", views.android_forget_password_post),






]
