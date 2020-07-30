from smtplib import SMTPAuthenticationError
from django.conf import settings
from django.contrib.auth.models import User
from django.contrib.sites.shortcuts import get_current_site
from django.core.mail import EmailMessage
from django.template.loader import render_to_string
from django.utils.encoding import force_bytes
from django.utils.http import urlsafe_base64_encode
from rest_framework import status, permissions
from rest_framework.response import Response
from rest_framework.views import APIView
from .serializers import CreateUserSerializer, UserSerializer, UserActivationSerializer, UpdateUserSerializer
from .tokens import account_activation_token


class UserView(APIView):
    def post(self, request):
        email = request.data.get('email')
        if email:
            try:
                user = User.objects.get(email__iexact=email)
                if user.is_active is False:
                    user.delete()
            except User.DoesNotExist:
                pass
        serializer = CreateUserSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        user = serializer.save(is_active=False)
        # domain = settings.DOMAIN
        domain = get_current_site(request)
        mail_subject = 'Activate your Budgito account'
        message = render_to_string('account_activation_email.html', {
            'user': user,
            'domain': domain,
            'uid': urlsafe_base64_encode(force_bytes(user.pk)),
            'token': account_activation_token.make_token(user),
        })
        to_email = serializer.validated_data.get('email')
        email = EmailMessage(
            mail_subject, message, to=[to_email]
        )
        try:
            email.send()
            return Response(
                {
                    'detail': 'account created subject to activation',
                    'user_data': UserSerializer(user).data
                },
                status=status.HTTP_201_CREATED
            )
        except SMTPAuthenticationError:
            user.delete()
            return Response(
                {'detail': 'smtp authentication failed'},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR
            )


class UserActivationView(APIView):
    """
    Users accounts are activated via the mail sent
    """
    def post(self, request):
        user = request.data.get('user', {})
        serializer = UserActivationSerializer(data=request.data, user=user)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        return Response(
            {'detail': 'account activation successful'},
            status=status.HTTP_200_OK
        )


class AuthUserDataView(APIView):
    permission_classes = (permissions.IsAuthenticated,)

    def get(self, request):
        user = request.user
        serializer = UserSerializer(user)
        return Response(serializer.data)

    def put(self, request):
        # full update
        user = request.user
        serializer = UpdateUserSerializer(user, request.data)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        return Response(serializer.data, status=status.HTTP_204_NO_CONTENT)
