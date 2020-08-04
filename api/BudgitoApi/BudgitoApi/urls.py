from django.contrib import admin
from django.urls import path, include
from rest_framework.documentation import include_docs_urls
from rest_framework import permissions
from drf_yasg.views import get_schema_view
from drf_yasg import openapi

schema_view = get_schema_view(
   openapi.Info(
      title="Budget-Go API",
      default_version='v1',
      description="Budget-Go API",
      terms_of_service="https://www.google.com/policies/terms/",
      contact=openapi.Contact(email="admin@budgetgo.com"),
      license=openapi.License(name="MIT License"),
   ),
   public=True,
   permission_classes=(permissions.AllowAny,),
)

urlpatterns = [
    path('auth/', include('rest_framework.urls')),
    path('admin/', admin.site.urls),
    path('api/accounts/', include('accounts.urls')),
    path('api/budget/', include('budget.urls')),
    path('', schema_view.with_ui('swagger', cache_timeout=0), name='Budget-Go API'),  # Doc with swagger schema
    path('api/redoc/', schema_view.with_ui('redoc', cache_timeout=0), name='Budget-Go API'),  # Doc with redoc schema
    path('api/docs/', include_docs_urls(title='Budget-Go API')),  # Core API doc
]
