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
from .views import login_view, signup_view
urlpatterns = [
  path('login', login_view),
  path('signup', signup_view)
]
