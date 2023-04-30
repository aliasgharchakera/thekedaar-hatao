from django.urls import path
from .views import *
urlpatterns = [
    path('',example_view),
    path('login/', login_view),
    path('signup/', signup_view),
    path('forum/create/', create_forum_post),
    path('forum/', get_forum_posts),
    path('forum/<int:pk>/', get_forum_post),
    path('forum/<int:pk>/create/', create_post_comment),
    path('forum/<int:pk>/<int:ck>/', get_post_comment),
    path('forum/<int:pk>/comments/', get_post_comments),
    path('marketplace/', get_marketplace_posts),
    path('marketplace/create/', create_marketplace_post),
    path('user/', get_user),
    path('user/update/', update_user),
    path('user/update_password/', update_password),
    path('user/posts/', get_user_posts),
    path('vendor/<int:pk>/', get_vendor),
    path('vendor/<int:pk>/posts/', get_vendor_posts),
]
