from django.http import HttpResponse
from django.shortcuts import render, HttpResponse
from rest_framework.response import Response
from rest_framework.permissions import AllowAny
from rest_framework.decorators import api_view, permission_classes
from .models import Uuser
# from django.contrib.auth.models import Uuser
from .serializers import Uuserserializer

from .models import User


# Create your views here.

@api_view(['GET'],)
@permission_classes([AllowAny],)
def hello_django(request):
    print("Request received")
    return Response({'message: Request Successfully returned! Hello Django!'}, status = 200)

@api_view(['GET'],)
@permission_classes([AllowAny],)
def getUuser(request):
    Uusers = Uuser.objects.all()
    serializer = Uuserserializer(Uusers,many = True)
    return Response(serializer.data)


@api_view(['POST'])
@permission_classes([AllowAny],)
def createUuser(request):
    data = request.data
    user = Uuser.objects.create(
        email = data['email'],
        password = data['password'],
        contact = data['contact'],
    )
    serializer = Uuserserializer(user,many=False)
    return Response(serializer.data)





# @api_view(['POST'],)
# # @permission_classes([AllowAny],)
# def user(request):
#     if request.method == 'POST':
#         # Retrieve the request data
#         contact = request.data.get('contact')
#         email = request.data.get('email')
#         password = request.data.get('password')
#     users = User.objects.all()
#     serialzer = Userserializer(User,many =True) 
#     return Response(serialzer.data)
#     # user = User.objects.create_user(contact=contact, email=email, password=password)
#     # user.save()
    
#     # return Response({'created user sucssesfully'}, status = 200)
# def 
