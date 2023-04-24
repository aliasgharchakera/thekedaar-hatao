from django.urls import path
from .views import login_view, signup_view, createPost, createComment
urlpatterns = [
    path('login/', login_view),
    path('signup/', signup_view),
    path('forum/', createPost,name='createPost'),
    path('comment/',createComment,name='createComment'),
]
