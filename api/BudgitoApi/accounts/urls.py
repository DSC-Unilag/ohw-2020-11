from django.urls import path
from .views import UserView, UserActivationView, AuthUserDataView
from rest_framework_simplejwt.views import (
    TokenRefreshView,
    TokenObtainPairView,
)

from .serializers import CustomTokenObtainPairSerializer


urlpatterns = [
    path(
        'token/',
        TokenObtainPairView.as_view(serializer_class=CustomTokenObtainPairSerializer),
        name='token_obtain_pair'
    ),
    path('refresh/', TokenRefreshView.as_view(), name='token_refresh'),
    path('', UserView.as_view()),
    path('me/', AuthUserDataView.as_view()),
    path('activate/', UserActivationView.as_view()),
]
