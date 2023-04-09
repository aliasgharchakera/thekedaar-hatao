from django.urls import path
from . import views

urlpatterns = [
    path('', views.hello_django, name='hellodjango'),
    path('uusers/',views.getUuser),
    path('user/create/', views.createUuser),
    # path ('')


]
