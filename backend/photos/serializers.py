from rest_framework import serializers
from .models import Photo, PhotoInAlbum

class PhotoSerializer(serializers.ModelSerializer):
    class Meta:
        model = Photo
        fields = ['id', 'name', 'owner']

class PhotoInAlbumSerializer(serializers.ModelSerializer):
    class Meta:
        model = PhotoInAlbum
        fields = ['id', 'photo', 'album']