from rest_framework import viewsets
from rest_framework.response import Response
from rest_framework.request import Request
from rest_framework.permissions import IsAuthenticated
from .models import Photo, PhotoInAlbum
from .serializers import PhotoSerializer, PhotoInAlbumSerializer

class PhotoViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = Photo.objects.all()
    serializer_class = PhotoSerializer

    def retrieve(self, request: Request, *args, **kwargs) -> Response:
        """Redefined retrieve method to only authorize the admin to get all photos"""
        current_user_id = request.user.id

        if current_user_id == 1:
            instance = self.get_object()
            serializer = self.get_serializer(instance)
            return Response(serializer.data)
        
        return Response("You're not authorized to access to this data!")

    def list(self, request: Request, *args, **kwargs) -> Response:
        """Redefined list method to filter photo by owner id & to authorize only owner to read their photos"""
        queryset = self.filter_queryset(self.get_queryset())

        current_user_id = request.user.id
        owner = request.GET.get("owner")

        if owner:
            queryset = queryset.filter(owner=current_user_id)

        page = self.paginate_queryset(queryset)
        if page is not None:
            serializer = self.get_serializer(page, many=True)
            return self.get_paginated_response(serializer.data)

        serializer = self.get_serializer(queryset, many=True)
        return Response(serializer.data)
    
    def destroy(self, request: Request, *args, **kwargs) -> Response:
        """Redefined destroy method to allow only owner to delete their albums"""
        current_user_id = request.user.id

        instance = self.get_object()
        serializer = self.get_serializer(instance)
        owner = serializer.data['owner']
        
        if current_user_id == owner:
            self.perform_destroy(instance)
            return Response('Photo deleted!')
        else:
            return Response("You're not allowed to delete this photo!")

class PhotoInAlbumViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = PhotoInAlbum.objects.all()
    serializer_class = PhotoInAlbumSerializer

    def list(self, request: Request, *args, **kwargs) -> Response:
        """Redefined list method to filter photos_in_album by album"""
        queryset = self.filter_queryset(self.get_queryset())

        album = request.GET.get("album")
        if album:
            queryset = queryset.filter(album=album)

        page = self.paginate_queryset(queryset)
        if page is not None:
            serializer = self.get_serializer(page, many=True)
            return self.get_paginated_response(serializer.data)

        serializer = self.get_serializer(queryset, many=True)
        return Response(serializer.data)