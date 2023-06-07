from django.db import models
from django.contrib.auth.models import User
from albums.models import Album

class Photo(models.Model):
    name = models.CharField(max_length=255)
    owner = models.ForeignKey(User, on_delete=models.CASCADE)

    def __str__(self):
        return self.name

class PhotoInAlbum(models.Model):
    photo = models.ForeignKey(Photo, on_delete=models.CASCADE)
    album = models.ForeignKey(Album, on_delete=models.CASCADE)