from rest_framework.serializers import ModelSerializer
from .models import User


class Userserializer(ModelSerializer):
    class Meta:
        model = User
        field = '__all__'