from django.contrib.auth.models import User
from django.utils.encoding import force_text
from django.utils.http import urlsafe_base64_decode
from rest_framework import serializers


class TokenValidationMixin:
    def validate(self, data):
        data = super().validate(data)
        uid = force_text(urlsafe_base64_decode(data['uid']))
        try:
            user = User.objects.get(pk=uid)
        except (TypeError, ValueError, OverflowError, User.DoesNotExist):
            raise serializers.ValidationError({'uid': 'User does not exist'})
        token = data['token']
        valid_token = self.token_generator.check_token(user, token)
        if not valid_token:
            raise serializers.ValidationError({'token': 'Token is invalid'})
        data['user'] = user
        return data
