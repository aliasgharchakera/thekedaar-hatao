from django.db import models
from django.utils.timezone import now

# Create your models here.
class Uuser(models.Model):
    email= models.TextField()
    password= models.TextField()
    contact= models.TextField()
    

    def __str__(self):
        return f"{self.email}" 
    

    
     
