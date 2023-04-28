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
from .forms import * 
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
            'user_first_name': user.first_name,
            'email': user.email
        }, status=201)
        
@api_view(['GET'])
@authentication_classes([TokenAuthentication])
@permission_classes([IsAuthenticated])
def example_view(request, format=None):
    content = {
        'user': str(request.user),  # `django.contrib.auth.User` instance.
        'auth': str(request.auth),  # None
    }
    return Response(content)

 
# def home(request):
#     posts=ForumPost.objects.all()
#     count=posts.count()
#     discussions=[]
#     for i in posts:
#         discussions.append(i.discussion_set.all())
 
#     context={'posts':posts,
#               'count':count,
#               'discussions':discussions}
#     return render(request,'home.html',context)
 
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
@authentication_classes([TokenAuthentication])
@permission_classes([IsAuthenticated])
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