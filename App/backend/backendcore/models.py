from django.db import models
<<<<<<< HEAD
from django.utils.timezone import now

# Create your models here.
class Uuser(models.Model):
    email= models.TextField()
    password= models.TextField()
    contact= models.TextField()
    

    def __str__(self):
        return f"{self.email}" 
    

    
     
=======
from django.contrib.auth.models import User

# Create your models here.
# class User(models.Model):
#     # username: models.TextField()
#     email: models.TextField()
#     password: models.TextField()
#     contact: models.TextField()
    
#     def __str__(self):
#         return self.email 
    
class Post(models.Model):
    user = models.ForeignKey(User, on_delete=models.SET_NULL, null=True)
    text = models.TextField(null=True, blank=True)
    name = models.CharField(max_length=200, null=True, blank=True)
    image = models.ImageField(null=True, blank=True)
    brand = models.CharField(max_length=200, null=True, blank=True)
    category = models.CharField(max_length=200, null=True, blank=True)
    rating = models.DecimalField(max_digits=7, decimal_places=2, null=True, blank=True)
    numReviews = models.IntegerField(null=True, blank=True, default=0)
    price = models.DecimalField(max_digits=7, decimal_places=2, null=True, blank=True)
    createdAt = models.DateTimeField(auto_now_add=True)
    _id = models.AutoField(primary_key=True, editable=False)
    
    def __str__(self) -> str:
        return self.name
    
     
>>>>>>> 8e052e21a33856780a0c495f2c938c497e8b4b27
