from django.urls import path
from .views import *
urlpatterns = [
    path('login/', login_view),
    path('signup/', signup_view),
    path('example/',example_view),
    path('forum/create/', createForumPost),
    path('forum/', getForumPosts),
]
