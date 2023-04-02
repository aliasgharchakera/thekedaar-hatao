from django.db import models

# Create your models here.
class User(models.Model):
    # username: models.TextField()
    email: models.TextField()
    password: models.TextField()
    contact: models.TextField()
    
    def __str__(self):
        return self.email 
     
