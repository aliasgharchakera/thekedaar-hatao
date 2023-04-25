from django.urls import path
from .views import *
urlpatterns = [
    path('login', login_view),
    path('signup', signup_view),
    path('forumposts/', getForumPosts),
    # path('forumpost/<str:pk>/', getForumPosts),
    path('forumpost/create/',CreateForumPost.as_view())
    # path('addInDiscussion/',addInComment,name='addInDiscussion'),
    # path('forum-posts/', ForumPostView.as_view(), name='forum_posts'),
]
