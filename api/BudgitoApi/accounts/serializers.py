from rest_framework import serializers
from django.contrib.auth.models import User
from rest_framework_simplejwt.serializers import TokenObtainPairSerializer
from rest_framework_simplejwt.settings import api_settings
from .mixins import TokenValidationMixin
from .tokens import account_activation_token


class CustomTokenObtainPairSerializer(TokenObtainPairSerializer):
    @classmethod
    def get_tokens(self, user):
        refresh = self.get_token(user)

        return {
            'refresh': str(refresh),
            'access': str(refresh.access_token),
            'expires': int(api_settings.ACCESS_TOKEN_LIFETIME.total_seconds()),
            'userData': UserSerializer(user).data,
        }

    def validate(self, attrs):
        data = super().validate(attrs)

        expires = api_settings.ACCESS_TOKEN_LIFETIME
        data['expires'] = int(expires.total_seconds())
        return data


class CreateUserSerializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only=True)
    confirm_password = serializers.CharField(write_only=True)

    class Meta:
        model = User
        fields = ('email', 'username', 'first_name', 'last_name', 'password', 'confirm_password')

    def validate(self, data):
        if data['password'] != data['confirm_password']:
            raise serializers.ValidationError(
                {'confirm_password': 'password does not match'}
            )
        return data

    def create(self, validated_data):
        validated_data.pop('confirm_password')
        user = User.objects.create(**validated_data)
        user.set_password(validated_data['password'])
        user.save()
        return user


class UserActivationSerializer(TokenValidationMixin, serializers.Serializer):
    token_generator = account_activation_token
    uid = serializers.CharField(required=True)
    token = serializers.CharField(required=True)

    def save(self):
        user = self.validated_data['user']
        user.is_active = True
        user.save()


class UserSerializer(serializers.ModelSerializer):

    class Meta:
        model = User
        fields = ('id', 'email', 'first_name', 'last_name')


class UpdateUserSerializer(serializers.ModelSerializer):

    class Meta:
        model = User
        fields = ('email', 'first_name', 'last_name')

    def update(self, instance, validated_data):
        instance.email = validated_data.get('email', instance.email)
        instance.first_name = validated_data.get('first_name', instance.first_name)
        instance.last_name = validated_data.get('last_name', instance.last_name)
        instance.save()
        return instance
