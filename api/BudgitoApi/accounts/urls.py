from django.urls import path
from .views import UserView, UserActivationView, AuthUserDataView
from rest_framework.authtoken.views import obtain_auth_token


urlpatterns = [
    path('api-token-auth/', obtain_auth_token),
    path('', UserView.as_view()),
    path('me/', AuthUserDataView.as_view()),
    path('activate/<str:uid>/<str:token>/', UserActivationView.as_view()),
]
