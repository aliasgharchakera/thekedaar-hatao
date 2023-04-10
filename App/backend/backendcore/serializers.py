from rest_framework.serializers import ModelSerializer
from .models import Uuser


class Uuserserializer(ModelSerializer):
    
    class Meta:
        model = Uuser
        fields = '__all__'
