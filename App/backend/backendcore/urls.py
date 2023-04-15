# from django.urls import path
# from . import views

# urlpatterns = [
#     path('', views.hello_django, name='hellodjango'),
#     path('hello/', views.hello_django, name='hellodjango'),
#     path('uusers/',views.getUuser),
#     path('user/create/', views.createUuser),
#     # path ('')
# ]

from django.urls import path
from .views import UserDetailAPI,RegisterUserAPIView, my_view, signup_view
urlpatterns = [
  path("get-details",UserDetailAPI.as_view()),
  path('register',RegisterUserAPIView.as_view()),
  path('login', my_view),
  path('signup', signup_view)
]
