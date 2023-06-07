from django.contrib import admin
from .models import Album, AlbumSharedWith

admin.site.register(Album)
admin.site.register(AlbumSharedWith)
