from django.urls import path, include
from rest_framework import routers
from .views import AlbumViewSet, AlbumSharedWithViewSet

router = routers.DefaultRouter()

router.register(r'albums', AlbumViewSet)
router.register(r'albums_shared_with', AlbumSharedWithViewSet)

urlpatterns = [
    path("", include(router.urls)),
]