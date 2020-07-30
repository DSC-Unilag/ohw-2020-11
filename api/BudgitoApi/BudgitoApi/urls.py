from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('auth/', include('rest_framework.urls')),
    path('admin/', admin.site.urls),
    path('api/accounts/', include('accounts.urls')),
]
