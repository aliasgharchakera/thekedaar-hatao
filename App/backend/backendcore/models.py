from django.db import models
from django.utils.timezone import now
from django.contrib.auth.models import User

# Create your models here.
from django.db import models 
    
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
    

    
     
