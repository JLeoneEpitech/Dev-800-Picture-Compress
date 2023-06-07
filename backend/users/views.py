from rest_framework import viewsets, generics
from rest_framework.response import Response
from rest_framework.request import Request
from django.contrib.auth.models import User
from .serializers import UserSerializer
from rest_framework.permissions import IsAuthenticated

class UserViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = User.objects.all()
    serializer_class = UserSerializer

    def destroy(self, request: Request, *args, **kwargs) -> Response:
        """Redefined destroy method to allow only owner to delete their account"""
        current_user_username = request.user.username

        instance = self.get_object()
        serializer = self.get_serializer(instance)
        username = serializer.data['username']
        
        if current_user_username == username:
            self.perform_destroy(instance)
            return Response('User deleted!')
        else:
            return Response("You're not allowed to delete this user!")

class UserCreate(generics.CreateAPIView):
    queryset = User.objects.all()
    serializer_class = UserSerializer