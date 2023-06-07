from rest_framework import serializers
from .models import Album, AlbumSharedWith

class AlbumSerializer(serializers.ModelSerializer):
    class Meta:
        model = Album
        fields = ['id', 'name', 'owner']


class AlbumSharedWithSerializer(serializers.ModelSerializer):
    class Meta:
        model = AlbumSharedWith
        fields = ['id', 'album', 'user']