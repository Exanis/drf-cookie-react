from django.conf.urls import url, include
from rest_framework.routers import DefaultRouter
from api import views
# from api import viewsets


router = DefaultRouter()

urlpatterns = [
    url(r'^health', views.health),
    url(r'^', include(router.urls))
]
