from django.urls import path
from .views import *
urlpatterns = [
    path('login/', login_view),
    path('signup/', signup_view),
    path('example/',example_view),
    path('forum/create/', create_forum_post),
    path('forum/', get_forum_posts),
    path('forum/<str:pk>/', get_forum_post),
    path('forum/<str:pk>/create/', create_post_comment),
]
