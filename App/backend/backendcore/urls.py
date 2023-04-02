from django.urls import path
from . import views

urlpatterns = [
    path('', views.hello_django, name='hellodjango'),
    path('newuser', views.user, name='user')

]
