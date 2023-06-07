from django.urls import path, include
from rest_framework import routers
from .views import PhotoViewSet, PhotoInAlbumViewSet

router = routers.DefaultRouter()

router.register(r'photos', PhotoViewSet)
router.register(r'photos_in_album', PhotoInAlbumViewSet)

urlpatterns = [
    path("", include(router.urls)),
]