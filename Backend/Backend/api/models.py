from unittest.util import _MAX_LENGTH
from django.db import models
from django.contrib.auth.models import AbstractBaseUser, BaseUserManager
from django.contrib.auth import get_user_model
from django.contrib.auth.backends import ModelBackend
from datetime import datetime    
from django.utils.timezone import now

class Input(models.Model):
    created_at = models.DateTimeField(auto_now_add=True,blank=True)
    temperature = models.FloatField(max_length=50)
    humidity = models.FloatField(max_length=50)
    water = models.FloatField(max_length=50)
    def __int__(self):
        return self.id

class Guide(models.Model):
    plantName = models.CharField(max_length=50)
    plantDisc = models.CharField(max_length=500)
    plantWaterUsage = models.FloatField(max_length=50)
    plantImageUrl = models.CharField(max_length=100)
    def __int__(self):
        return self.id

class EmailBackend(ModelBackend):
    def authenticate(self, request, username=None, password=None, **kwargs):
        UserModel = get_user_model()
        try:
            user = UserModel.objects.get(email=username)
        except UserModel.DoesNotExist:
            return None
        else:
            if user.check_password(password):
                return user
        return None

# when adding new field
# run python manage.py migrate --run-syncdb