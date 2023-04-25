from django.urls import path
from .views import login_view, signup_view, addInPost, addInComment
urlpatterns = [
    path('login', login_view),
    path('signup', signup_view),
    path('addInForum/',addInPost,name='addInForum'),
    path('addInDiscussion/',addInComment,name='addInDiscussion'),
]
