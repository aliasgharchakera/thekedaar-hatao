from rest_framework.decorators import api_view, permission_classes, authentication_classes
from rest_framework.permissions import AllowAny
from rest_framework.response import Response
from django.contrib.auth.models import User
from django.contrib.auth import authenticate, login
from rest_framework.authentication import SessionAuthentication, BasicAuthentication, TokenAuthentication
from rest_framework.permissions import IsAuthenticated
from rest_framework.views import APIView
from rest_framework import generics

from django.shortcuts import render,redirect
from .models import *
from .serializers import *
# Create your views here.
from rest_framework.authtoken.views import ObtainAuthToken
from rest_framework.authtoken.models import Token
from rest_framework.response import Response

class CustomAuthToken(ObtainAuthToken):

    def post(self, request, *args, **kwargs):
        serializer = self.serializer_class(data=request.data,
                                           context={'request': request})
        serializer.is_valid(raise_exception=True)
        user = serializer.validated_data['user']
        token, created = Token.objects.get_or_create(user=user)
        return Response({
            'token': token.key,
            'first_name': user.first_name,
            'email': user.email
        }, status=201)
        
@api_view(['GET'])
@permission_classes([AllowAny],)
def example_view(request):
    return Response({'Welcome to Thekedaar Hatao'}, status=200)

@api_view(['POST'])
@permission_classes([AllowAny],)
def login_view(request):
    data = request.data
    username = data['username']
    password = data['password']
    user = authenticate(request, username=username, password=password)
    if user is not None:
        login(request, user)
        # Redirect to a success page.
        return Response({'login successfully'}, status = 201)
    else:
        # Return an 'invalid login' error message.
        return Response({'login failed'}, status = 401)
      
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

     
'''Forum Views'''
@api_view(['POST'])
@authentication_classes([TokenAuthentication])
@permission_classes([IsAuthenticated])
def create_forum_post(request):
    data = request.data
    forumPost= ForumPost.objects.create(
        title = data['title'],
        content = data['content'],
        user_id = request.user
        )
    serializer = ForumPostSerializer(forumPost,many=False)
    return Response(serializer.data, status = 201)

@api_view(['POST'])
@authentication_classes([TokenAuthentication])
@permission_classes([IsAuthenticated])
def create_post_comment(request, pk):
    data = request.data
    forum_post = ForumPost.objects.get(id=pk)
    if not forum_post:
        return Response({'error': 'ForumPost does not exist'}, status=404)
    postComment= Comment.objects.create(
        # this needs fixing
        post_id = forum_post,
        comment = data['comment'],
        user_id = request.user
        )
    serializer = PostCommentSerializer(postComment,many=False)
    return Response(serializer.data, status = 201)

@api_view(['GET'])
@permission_classes([AllowAny],)
def get_forum_posts(request):
    forumPosts= ForumPost.objects.all()
    serializer = ForumPostSerializer(forumPosts,many=True)
    return Response(serializer.data, status = 200)


@api_view(['GET'])
@authentication_classes([TokenAuthentication])
@permission_classes([IsAuthenticated])
def get_forum_post(request,pk):
    forumPost= ForumPost.objects.get(id=pk)
    serializer = ForumPostSerializer(forumPost,many=False)
    return Response(serializer.data, status = 200)

@api_view(['GET'])
@authentication_classes([TokenAuthentication])
@permission_classes([IsAuthenticated])
def get_post_comment(request, pk, ck):
    forumPost= ForumPost.objects.get(id=pk)
    postComment = Comment.objects.get(id=ck, post_id=pk)
    serializer = PostCommentSerializer(postComment,many=False)
    return Response(serializer.data, status = 200)

@api_view(['GET'])
@authentication_classes([TokenAuthentication])
@permission_classes([IsAuthenticated])
def get_post_comments(request, pk):
    postComments = Comment.objects.all().filter(post_id=pk)
    serializer = PostCommentSerializer(postComments,many=True)
    return Response(serializer.data, status = 200)


'''Market Place Views'''
@api_view(['GET'])
@permission_classes([AllowAny],)
def get_marketplace_posts(request):
    marketPlacePosts= MarketPlacePost.objects.all()
    serializer = MarketPlacePostSerializer(marketPlacePosts,many=True)
    return Response(serializer.data, status = 200)

@api_view(['POST'])
@authentication_classes([TokenAuthentication])
@permission_classes([IsAuthenticated])
def create_marketplace_post(request):
    data = request.data
    marketPlacePost= MarketPlacePost.objects.create(
        material = data['material'],
        price = data['price'],
        quantity = data['quantity'],
        user_id = request.user
        )
    serializer = MarketPlacePostSerializer(marketPlacePost,many=False)
    return Response(serializer.data, status = 201)


'''User Views'''
@api_view(['GET'])
@authentication_classes([TokenAuthentication])
@permission_classes([IsAuthenticated])
def get_user_posts(request):
    forumPosts= ForumPost.objects.all().filter(user_id=request.user)
    serializer = ForumPostSerializer(forumPosts,many=True)
    return Response(serializer.data, status = 200)

@api_view(['GET'])
@authentication_classes([TokenAuthentication])
@permission_classes([IsAuthenticated])
def get_user(request):
    user= request.user
    serializer = UserSerializer(user, many=False)
    return Response(serializer.data, status = 200)

@api_view(['PUT'])
@authentication_classes([TokenAuthentication])
@permission_classes([IsAuthenticated])
def update_user(request):
    user = request.user
    serializer = UserSerializer(user, data=request.data, partial=True)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data, status=200)
    return Response(serializer.errors, status=400)

@api_view(['PUT'])
@authentication_classes([TokenAuthentication])
@permission_classes([IsAuthenticated])
def update_password(request):
    user = request.user
    data = request.data
    old_password = data['old_password']
    new_password = data['new_password']
    if user.check_password(old_password):
        user.set_password(new_password)
        user.save()
        return Response({'message': 'Password updated successfully.'}, status=200)
    else:
        return Response({'message': 'Old password is incorrect.'}, status=400)

'''Vendor Views'''
@api_view(['GET'])
@permission_classes([AllowAny],)
def get_vendor(request, pk):
    user= User.objects.get(id=pk)
    serializer = UserSerializer(user, many=False)
    return Response(serializer.data, status = 200)

@api_view(['GET'])
@permission_classes([AllowAny],)
def get_vendor_posts(request, pk):
    marketPlacePosts= MarketPlacePost.objects.all().filter(user_id=pk)
    serializer = MarketPlacePostSerializer(marketPlacePosts,many=True)
    return Response(serializer.data, status = 200)