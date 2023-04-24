from django.db import models
from django.utils.timezone import now
from django.contrib.auth.models import User

# Create your models here.
from django.db import models 

def ready(self):
    from django.conf import settings
    from django.db.models.signals import post_save
    from django.dispatch import receiver
    from rest_framework.authtoken.models import Token
    @receiver(post_save, sender=settings.AUTH_USER_MODEL)
    def create_auth_token(sender, instance=None, created=False, **kwargs):
        if created:
            Token.objects.create(user=instance)
            
    for user in User.objects.all():
        Token.objects.get_or_create(user=user)
    
#parent model
class Post(models.Model):
    user = models.ForeignKey(User,blank=False,on_delete=models.CASCADE)
    topic= models.CharField(max_length=300)
    description = models.CharField(max_length=1000,blank=True)
    link = models.CharField(max_length=100 ,null =True)
    date_created=models.DateTimeField(auto_now_add=True,null=True)
    
    def __str__(self):
        return str(self.topic)
 
#child model
class Comment(models.Model):
    Post = models.ForeignKey(Post,blank=True,on_delete=models.CASCADE)
    comment = models.CharField(max_length=1000)
 
    def __str__(self):
        return str(self.Post)
    

class ForumPost(models.Model):
    title = models.CharField(max_length=255)
    content = models.TextField()
    author = models.ForeignKey(User, on_delete=models.CASCADE)
    created_at = models.DateTimeField(auto_now_add=True)
    # modified_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.title
     
