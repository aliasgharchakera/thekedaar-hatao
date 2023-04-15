# from django.http import HttpResponse
# from django.shortcuts import render, HttpResponse
# from rest_framework.response import Response
from rest_framework.permissions import AllowAny
from rest_framework.decorators import api_view, permission_classes
# from .models import Uuser
# # from django.contrib.auth.models import Uuser
# from .serializers import Uuserserializer

# # from .models import User


# # Create your views here.

# @api_view(['GET'],)
# @permission_classes([AllowAny],)
# def hello_django(request):
#     print("Request received")
#     return Response({'message: Request Successfully returned! Hello Django!'}, status = 200)

# @api_view(['GET'],)
# @permission_classes([AllowAny],)
# def getUuser(request):
#     Uusers = Uuser.objects.all()
#     serializer = Uuserserializer(Uusers,many = True)
#     return Response(serializer.data)


# @api_view(['POST'])
# @permission_classes([AllowAny],)
# def createUuser(request):
#     data = request.data
#     user = Uuser.objects.create(
#         email = data['email'],
#         password = data['password'],
#         # contact = data['contact'],
#     )
#     print(user.email, '\n', user.password)
#     serializer = Uuserserializer(user,many=False)
#     return Response(serializer.data, status=201)


from rest_framework.permissions import AllowAny
from rest_framework.views import APIView
from rest_framework.response import Response
from .serializers import UserSerializer,RegisterSerializer
from django.contrib.auth.models import User
from rest_framework.authentication import TokenAuthentication
from rest_framework import generics
from django.contrib.auth import authenticate, login

@api_view(['POST'])
@permission_classes([AllowAny],)
def my_view(request):
    data = request.data
    username = data['username']
    password = data['password']
    user = authenticate(request, username=username, password=password)
    if user is not None:
        login(request, user)
        # Redirect to a success page.
        return Response({'login successfully'}, status = 200)
    else:
        # Return an 'invalid login' error message.
        return Response({'login failed'}, status = 201)
      
@api_view(['POST'])
@permission_classes([AllowAny],)  
def signup_view(request):
    data = request.data
    username = data['username']
    email = data['email']
    password = data['password']
    first_name = data['first_name']
    last_name = data['last_name']
    user = User.objects.create_user(username=username, email=email, password=password, first_name=first_name, last_name=last_name)
    if user is not None:
        user.save()
        return Response({'user created successfully'}, status = 200)
    return Response({'user created failed'}, status = 201)

# Class based view to Get User Details using Token Authentication
class UserDetailAPI(APIView):
    authentication_classes = (TokenAuthentication,)
    permission_classes = (AllowAny,)
    def get(self,request,*args,**kwargs):
        user = User.objects.get(id=request.user.id)
        serializer = UserSerializer(user)
        return Response(serializer.data)

#Class based view to register user
class RegisterUserAPIView(generics.CreateAPIView):
    permission_classes = (AllowAny,)
    serializer_class = RegisterSerializer



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
