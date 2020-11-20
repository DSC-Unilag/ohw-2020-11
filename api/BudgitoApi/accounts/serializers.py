from rest_framework import serializers
from django.contrib.auth.models import User
from .mixins import TokenValidationMixin
from .tokens import account_activation_token
from budget.serializers import (
    CRUDIncomeSerializer,
    CRUDExpenseSerializer,
)


class CreateUserSerializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only=True)
    confirm_password = serializers.CharField(write_only=True)

    class Meta:
        model = User
        fields = ('email', 'username', 'first_name', 'last_name', 'password', 'confirm_password')

    def validate_email(self, email):
        existing = User.objects.filter(email=email).first()
        if existing:
            if existing.is_active:
                raise serializers.ValidationError(
                    "Someone with that Email Address has already registered."
                )
        return email

    def validate_username(self, username):
        existing = User.objects.filter(username=username).first()
        if existing:
            if existing.is_active:
                raise serializers.ValidationError(
                    "Someone with that Username has already registered."
                )
        return username

    def validate(self, data):
        if data.get('password') != data.get('confirm_password'):
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
    income = CRUDIncomeSerializer(many=True, read_only=True)
    expense = CRUDExpenseSerializer(many=True, read_only=True)

    class Meta:
        model = User
        fields = (
            'id', 'username', 'email', 'first_name', 'last_name', 'income', 'expense',
        )


class UpdateUserSerializer(serializers.ModelSerializer):

    class Meta:
        model = User
        fields = ('username', 'email', 'first_name', 'last_name')

    def update(self, instance, validated_data):
        instance.username = validated_data.get('username', instance.username)
        instance.email = validated_data.get('email', instance.email)
        instance.first_name = validated_data.get('first_name', instance.first_name)
        instance.last_name = validated_data.get('last_name', instance.last_name)
        instance.save()
        return instance
