from rest_framework.serializers import ModelSerializer
<<<<<<< HEAD
from .models import Uuser


class Uuserserializer(ModelSerializer):
    
    class Meta:
        model = Uuser
        fields = '__all__'
=======
from .models import User


class Userserializer(ModelSerializer):
    class Meta:
        model = User
        field = '__all__'
>>>>>>> 8e052e21a33856780a0c495f2c938c497e8b4b27
