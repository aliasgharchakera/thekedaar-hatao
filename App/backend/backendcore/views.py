from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import AllowAny
from rest_framework.response import Response
from django.contrib.auth.models import User
from django.contrib.auth import authenticate, login

from django.shortcuts import render,redirect
from .models import * 
from .forms import * 
# Create your views here.
 
def home(request):
    posts=Post.objects.all()
    count=posts.count()
    discussions=[]
    for i in posts:
        discussions.append(i.discussion_set.all())
 
    context={'posts':posts,
              'count':count,
              'discussions':discussions}
    return render(request,'home.html',context)
 
@api_view(['POST'])
@permission_classes([AllowAny],)
def createPost(request):
    form = CreateInPost()
    if request.method == 'POST':
        form = CreateInPost(request.POST)
        if form.is_valid():
            form.save()
            return Response({'post created successfully'}, status = 201)
    context ={'form':form}
    return Response({'post created failed'}, status = 401)
    
@api_view(['POST'])
@permission_classes([AllowAny],)
def createComment(request):
    form = CreateInComment()
    if request.method == 'POST':
        form = CreateInComment(request.POST)
        if form.is_valid():
            form.save()
            return redirect('/')
    context ={'form':form}
    return render(request,'addInDiscussion.html',context)
  
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

